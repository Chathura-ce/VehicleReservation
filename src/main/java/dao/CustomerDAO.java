package dao;

import model.Customer;
import model.User;
import util.CustomerUtil;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    public String addCustomer(Customer customer) throws SQLException {
        Connection connection = DatabaseUtil.getConnection();
        return   addCustomer(customer,connection);
    }

    public String addCustomer(Customer customer,Connection connection) throws SQLException {
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
                return customer.getCustomerNumber();
            }
        }
        return null;
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

    public int getCustomerIdByNumber(String number) throws SQLException {
        String sql = "SELECT c.customer_id FROM customers c WHERE c.customer_number = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, number);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("customer_id");
                }
                return 0;
            }
        }
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
        String sql = "SELECT c.*, u.* " +
                "FROM customers c JOIN users u ON c.user_id = u.user_id " +
                "WHERE u.nic LIKE ? OR u.username LIKE ? OR c.customer_number LIKE ? OR u.email LIKE ? OR u.phone LIKE ? ";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            stmt.setString(4, searchTerm);
            stmt.setString(5, searchTerm);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setCustomerNumber(rs.getString("customer_number"));
                    customer.setUserId(rs.getInt("user_id"));
                    customer.setAddress(rs.getString("address"));
//                    customer.setUsername(rs.getString("username"));
//                    customer.setEmail(rs.getString("email"));
//                    customer.setNic(rs.getString("nic"));
//                    customer.setPhoneNumber(rs.getString("phone"));

                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setNic(rs.getString("nic"));
                    user.setPhone(rs.getString("phone"));
                    user.setStatus(rs.getInt("status"));

                    customer.setUser(user);

                    customers.add(customer);
                }
            }
        }
        return customers;
    }

    public Customer getCustomerByUserId(int userId) throws SQLException {
        String sql = "SELECT c.*, u.* " +
                "FROM customers c JOIN users u ON c.user_id = u.user_id " +
                "WHERE u.user_id = ? ";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setCustomerNumber(rs.getString("customer_number"));
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
}
