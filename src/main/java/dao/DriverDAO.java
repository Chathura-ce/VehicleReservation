package dao;

import model.Driver;
import model.User;
import util.DatabaseUtil;
import util.DriverUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {

    // Add a new driver
    public void addDriver(Driver driver) throws SQLException {
        String sql = "INSERT INTO drivers ( user_id, driver_id, license_number) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            String driverId = DriverUtil.generateDriverId(driver.getUserId());
            stmt.setInt(1, driver.getUserId());
            stmt.setString(2, driverId);
            stmt.setString(3, driver.getLicenseNumber());
            stmt.executeUpdate();
        }
    }

    public List<Driver> getAllDrivers() throws SQLException {
        List<Driver> driverList = new ArrayList<>();
        String sql = "SELECT  d.user_id,  d.driver_id,  d.license_number,  d.created_at,u.username,  u.full_name,  u.phone,  u.status ,u.email,u.role FROM  drivers AS d  INNER JOIN users AS u ON d.user_id = u.user_id";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getInt("status"));
                user.setPhone(rs.getString("phone"));

                Driver driver = new Driver();
                driver.setDriverId(rs.getString("driver_id"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setUser(user); // Set User object inside Driver
                driverList.add(driver);
            }
        }
        return driverList;
    }

    public Driver getDriverById(String driverId) throws SQLException {
        String sql = "SELECT  d.user_id,  d.driver_id,  d.license_number,  d.created_at,  u.full_name, u.username, u.email,  u.phone,  u.role,  u.status,  u.nic  FROM  drivers AS d  INNER JOIN users AS u ON d.user_id = u.user_id " +
                " WHERE driver_id = ? ";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, driverId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getInt("status"));
                user.setPhone(rs.getString("phone"));
                user.setNic(rs.getString("nic"));

                Driver driver = new Driver();
                driver.setDriverId(rs.getString("driver_id"));
                driver.setUserId(rs.getInt("user_id"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setUser(user);
                return driver;
            }
        }
        return null;
    }

    public void updateDriver(Driver driver) throws SQLException {
        String sql = "UPDATE drivers SET license_number = ? WHERE driver_id = ?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, driver.getLicenseNumber());
            statement.setString(2, driver.getDriverId());
            statement.executeUpdate();
        }
    }

    public boolean deleteDriver(String driverId) {
        String sql = "DELETE FROM drivers WHERE driver_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, driverId);
            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0; // Returns true if at least one row was deleted
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isLicenseNumberExists(String driverId, String licenseNumber) {
        String sql = "SELECT COUNT(*) FROM drivers WHERE driver_id <> ? AND license_number = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, driverId);
            statement.setString(2, licenseNumber);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isDriverIdExists(String driverId) {
        String sql = "SELECT COUNT(*) FROM drivers WHERE driver_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, driverId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getUserIdByDriverId(String driverId) throws SQLException {
        String sql = "SELECT user_id FROM drivers WHERE driver_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, driverId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("user_id");
            }
        }
        return -1; // Return -1 if no user ID is found
    }

    public List<Driver> getAvailableDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT  d.driver_id,          u.full_name  FROM  drivers AS d  INNER JOIN users AS u ON d.user_id = u.user_id  WHERE  u.status = 1  ORDER BY  u.full_name ASC;";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                String driverId = resultSet.getString("driver_id");
                String fullName = resultSet.getString("full_name");
                User user = new User();
                Driver driver = new Driver();

                user.setFullName(fullName);

                driver.setDriverId(driverId);
                driver.setUser(user);
                drivers.add(driver); // Assuming Driver has a constructor for ID & Name
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }




}
