package util;

import dao.DriverDAO;
import dao.UserDAO;

import java.util.HashMap;
import java.util.Map;


public class ValidationUtil {

    public static Map<String, String> validateDriverInput(int userId,String driverId, String username, String fullName,
                                                          String phoneNumber, String licenseNumber,
                                                          String email, String status, DriverDAO driverDAO,
                                                          UserDAO userDAO) {
        Map<String, String> errors = new HashMap<>();

        // Validate driver ID (Must be unique)
        if (driverId == null || driverId.trim().isEmpty()) {
            errors.put("driverId", "Driver ID is required.");
        }

        // Validate username (Must be unique)
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Username is required.");
        } else if (userDAO.isUsernameExists(userId,username)) {
            errors.put("username", "Username already exists.");
        }

        // Validate full name
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullName", "Full name is required.");
        }

        // Validate phone number (Example: Must be 10 digits)
        if (phoneNumber == null || !phoneNumber.matches("\\d{10}")) {
            errors.put("phoneNumber", "Phone number must be 10 digits.");
        }

        // Validate license number (Must be unique)
        if (licenseNumber == null || licenseNumber.trim().isEmpty()) {
            errors.put("licenseNumber", "License number is required.");
        } else if (driverDAO.isLicenseNumberExists(driverId,licenseNumber)) {
            errors.put("licenseNumber", "License number already exists.");
        }

        // Validate email format (Must be unique)
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.put("email", "Invalid email format.");
        } else if (userDAO.isEmailExists(userId,email)) {
            errors.put("email", "Email already exists.");
        }

        // Validate status
        if (status == null || (!status.equalsIgnoreCase("active") && !status.equalsIgnoreCase("inactive"))) {
            errors.put("status", "Status must be either 'active' or 'inactive'.");
        }

        return errors;
    }
}
