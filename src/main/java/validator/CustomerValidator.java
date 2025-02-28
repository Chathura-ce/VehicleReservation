package validator;

import dao.CustomerDAO;
import exception.ValidationException;
import model.Customer;
import model.User;

import java.sql.SQLException;

public class CustomerValidator {
    private final CustomerDAO customerDAO;

    public CustomerValidator(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    public void validateCustomer(Customer customer) throws SQLException, ValidationException {
        if(customer.getAddress() == null || customer.getAddress().trim().isEmpty()){
            throw new ValidationException("Address must be provided.");
        }
    }
}
