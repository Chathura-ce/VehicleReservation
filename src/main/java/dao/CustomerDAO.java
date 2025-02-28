package dao;

import model.Customer;
import model.User;
import util.CustomerUtil;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    public int addCustomer(Customer customer) throws SQLException {
        Connection connection = DatabaseUtil.getConnection();
        return   addCustomer(customer,connection);
    }
    public int addCustomer(Customer customer,Connection connection) throws SQLException {
        String sql = "INSERT INTO customers (customer_number,user_id, address) VALUES (?, ?, ?)";
        try (
             PreparedStatement stmt = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)) {
            String customerNumber = CustomerUtil.generateCustomerNumber(customer.getUserId());
            customer.setCustomerNumber(customerNumber);

            stmt.setString(1, customer.getCustomerNumber());
            stmt.setInt(2, customer.getUserId());
            stmt.setString(3, customer.getAddress());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                customer.setCustomerId(generatedId);
                return generatedId;
            }
        }
        return -1;
    }


    public List<Customer> selectAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT c.*, u.* FROM customers c JOIN users u ON c.user_id = u.user_id";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setUserId(rs.getInt("user_id"));
                customer.setUsername(rs.getString("username"));
                customer.setAddress(rs.getString("address"));

                User user = new User();
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setNic(rs.getString("nic"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));

                customer.setUser(user);

                customers.add(customer);
            }
        }
        return customers;
    }


    public Customer selectCustomer(int id) throws SQLException {
        String sql = "SELECT c.*, u.user_id, u.username, u.email FROM customers c JOIN users u ON c.user_id = u.user_id WHERE c.customer_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setUserId(rs.getInt("user_id"));
                    customer.setUsername(rs.getString("username"));
                    customer.setAddress(rs.getString("address"));

                    User user = new User();
                    user.setFullName(rs.getString("full_name"));
                    user.setUsername(rs.getString("username"));
                    user.setNic(rs.getString("nic"));
                    user.setPhone(rs.getString("phone"));
                    user.setEmail(rs.getString("email"));

                    customer.setUser(user);

                    return customer;
                }
            }
        }
        return null;
    }

    public boolean updateCustomer(Customer customer) throws SQLException {
        Connection connection = null;
        try {
            connection = DatabaseUtil.getConnection();
            connection.setAutoCommit(false);

            // Update customers table
            String customerSql = "UPDATE customers SET address = ?, nic = ?, phone_number = ? WHERE customer_id = ?";
            try (PreparedStatement customerStmt = connection.prepareStatement(customerSql)) {
                customerStmt.setString(1, customer.getAddress());
                customerStmt.setString(2, customer.getNic());
                customerStmt.setString(3, customer.getPhoneNumber());
                customerStmt.setInt(4, customer.getCustomerId());
                customerStmt.executeUpdate();
            }

            // Update users table
            String userSql = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";
            try (PreparedStatement userStmt = connection.prepareStatement(userSql)) {
                userStmt.setString(1, customer.getUsername());
                userStmt.setString(2, customer.getEmail());
                userStmt.setInt(3, customer.getUserId());
                userStmt.executeUpdate();
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            if (connection != null) {
                connection.rollback();
            }
            throw e;
        } finally {
            if (connection != null) {
                connection.setAutoCommit(true);
                connection.close();
            }
        }
    }

    public boolean deleteCustomer(int id) throws SQLException {
        String sql = "DELETE FROM customers WHERE customer_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Customer> searchCustomers(String query) throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT c.*, u.user_id, u.username, u.email, u.full_name " +
                "FROM customers c JOIN users u ON c.user_id = u.user_id " +
                "WHERE c.nic LIKE ? OR u.username LIKE ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setUserId(rs.getInt("user_id"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setAddress(rs.getString("address"));
                    customer.setNic(rs.getString("nic"));
                    customer.setPhoneNumber(rs.getString("phone_number"));
                    customers.add(customer);
                }
            }
        }
        return customers;
    }
}
