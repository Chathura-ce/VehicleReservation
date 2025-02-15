package dao;

import model.Customer;
import util.DatabaseUtil;

import java.sql.*;

public class CustomerDAO {

    public void addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (user_id, address, nic, phone_number) VALUES (?, ?, ?, ?)";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customer.getUserId());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getNic());
            stmt.setString(4, customer.getPhoneNumber());
            stmt.executeUpdate();
        }
    }

    public boolean customerExistsByNIC(String nic) throws SQLException {
        String sql = "SELECT customer_id FROM customers WHERE nic = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nic);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Returns true if a record is found
            }
        }
    }

    public boolean customerPhoneNumberExists(String phone_number) throws SQLException {
        String sql = "SELECT phone_number FROM customers WHERE phone_number = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, phone_number);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Returns true if a record is found
            }
        }
    }
}
