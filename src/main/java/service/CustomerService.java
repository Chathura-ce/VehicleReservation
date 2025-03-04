package service;

import java.sql.Connection;
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

    public String insertCustomer(Customer customer, Connection conn) throws SQLException {
       return customerDAO.addCustomer(customer,conn);
    }

    public Customer selectCustomer(int id) throws SQLException {
        return customerDAO.selectCustomer(id);
    }

    public int getCustomerIdByNumber(String number) throws SQLException {
        return customerDAO.getCustomerIdByNumber(number);
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