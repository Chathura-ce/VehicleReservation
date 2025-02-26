package service;

import java.sql.SQLException;
import java.util.List;

import dao.CustomerDAO;
import model.Customer;

public class CustomerService {
    private CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    public List<Customer> selectAllCustomers() throws SQLException {
        return customerDAO.selectAllCustomers();
    }

    public void insertCustomer(Customer customer) throws SQLException {
        customerDAO.insertCustomer(customer);
    }

    public Customer selectCustomer(int id) throws SQLException {
        return customerDAO.selectCustomer(id);
    }

    public boolean deleteCustomer(int id) throws SQLException {
        return customerDAO.deleteCustomer(id);
    }

    public boolean updateCustomer(Customer customer) throws SQLException {
        return customerDAO.updateCustomer(customer);
    }

    public List<Customer> searchCustomers(String query) throws SQLException {
        return customerDAO.searchCustomers(query);
    }
}