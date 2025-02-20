package dao;

import util.DatabaseUtil;
import model.User;
import util.PasswordUtil;

import java.sql.*;

public class UserDAO {

    public int addUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, password_hash,salt, full_name, email, role,phone) VALUES (?, ?,?, ?, ?, ?,?)";
        try (Connection connection = DatabaseUtil.getConnection();
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


    public boolean checkUsernameExists(String username) throws SQLException {
        String sql = "SELECT username FROM users WHERE username = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Returns true if a record is found
            }
        }
    }

    public boolean checkEmailExists(String email) throws SQLException {
        String sql = "SELECT email FROM users WHERE email = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Returns true if a record is found
            }
        }
    }
}
