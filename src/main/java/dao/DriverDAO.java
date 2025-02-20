package dao;

import model.Driver;
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

    // Retrieve all drivers
    public List<Driver> getAllDrivers() throws SQLException {
        List<Driver> driverList = new ArrayList<>();
        String sql = "SELECT * FROM drivers";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String driverId = rs.getString("driver_id");
                String licenseNumber = rs.getString("license_number");
                Driver driver = new Driver(userId,driverId,licenseNumber);
                driver.setDriverId(rs.getString("driver_id"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driverList.add(driver);
            }
        }
        return driverList;
    }

}
