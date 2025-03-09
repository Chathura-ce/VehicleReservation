package dao;

import exception.ValidationException;
import model.Booking;
import util.DatabaseUtil;
import model.User;
import util.PasswordUtil;

import java.sql.*;

public class UserDAO {

    public int addUser(User user) throws SQLException, ValidationException {
        try (Connection connection = DatabaseUtil.getConnection()) {
            return addUser(user, connection);
        }
    }

    public int addUser(User user,Connection connection) throws SQLException {
        String sql = "INSERT INTO users (username, password_hash,salt, full_name, email, role,phone,nic) VALUES (?, ?,?, ?, ?, ?,?,?)";
        try (
             PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            String salt = PasswordUtil.generateSalt(); // Generate salt
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword(), salt); // Hash password

            stmt.setString(1, user.getUsername());
            stmt.setString(2, hashedPassword);
            stmt.setString(3, salt);
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getPhone());
            stmt.setString(8, user.getNic());
            stmt.executeUpdate();

            // Retrieve the generated user ID
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    public User authenticate(String username, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ? ";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                String storedSalt = rs.getString("salt");

                // Hash input password with stored salt
                String hashedInputPassword = PasswordUtil.hashPassword(password, storedSalt);

                if (storedHash.equals(hashedInputPassword)) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        }
        return null;
    }


    public boolean checkUsernameExists(String username, int userId) throws SQLException {
        String sql = "SELECT username FROM users WHERE username = ? AND user_id<>?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setInt(2, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Returns true if a record is found
            }
        }
    }

    public boolean checkEmailExists(String email,int userId) throws SQLException {
        String sql = "SELECT email FROM users WHERE email = ? AND user_id<>?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setInt(2, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Returns true if a record is found
            }
        }
    }
    public boolean checkNICExists(String nic,int userId) throws SQLException {
        String sql = "SELECT nic FROM users WHERE nic = ? AND user_id<>?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nic);
            stmt.setInt(2, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Returns true if a record is found
            }
        }
    }

    public void updateUser(User user) throws SQLException {
        String salt = PasswordUtil.generateSalt(); // Generate salt
        String hashedPassword = PasswordUtil.hashPassword(user.getPassword(), salt);

        // Base SQL query
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ? ,nic=?, status = ? ";

        // Check if password should be updated
        boolean updatePassword = (user.getPassword() != null && !user.getPassword().isEmpty());
        if (updatePassword) {
            sql += ", password_hash = ?";
        }
        sql += " WHERE user_id = ?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Set required parameters
            statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPhone());
            statement.setString(4, user.getNic());
            statement.setInt(5, user.getStatus().equalsIgnoreCase("Active") ? 1 : 0);

            int index = 6;

            // If password needs to be updated, set it dynamically
            if (updatePassword) {
                statement.setString(index++, hashedPassword); // Use the hashed password
            }

            // Set the user ID in the correct position
            statement.setInt(index, user.getUserId());

            statement.executeUpdate();
        }
    }


    public boolean isUsernameExists(int userId, String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ? AND user_id <> ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            statement.setInt(2, userId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(int userId, String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND user_id <> ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            statement.setInt(2, userId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        }
    }
}
