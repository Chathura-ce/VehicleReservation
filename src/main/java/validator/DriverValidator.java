package validator;

import dao.DriverDAO;
import exception.ValidationException;

import java.sql.SQLException;

public class DriverValidator {
    private final DriverDAO driverDAO;

    public DriverValidator() {
        this.driverDAO = new DriverDAO();
    }

    public void validateDriver(String licenseNumber,String driverId) throws SQLException, ValidationException {
        // Validate license number (Must be unique)
        if (licenseNumber == null || licenseNumber.trim().isEmpty()) {

            throw new ValidationException("License number is required.");
        } else if (driverDAO.isLicenseNumberExists(driverId,licenseNumber)) {
            throw new ValidationException("License number already exists.");
        }
    }
}
