package validator;

import dao.UserDAO;
import exception.ValidationException;
import model.User;
import java.sql.SQLException;

public class UserValidator {
    private final UserDAO userDAO;

    public UserValidator(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public void validateUser(User user) throws SQLException, ValidationException {
        if(user.getUsername() == null || user.getUsername().trim().isEmpty()){
            throw new ValidationException("Username must be provided.");
        }
        if (userDAO.checkUsernameExists(user.getUsername(),user.getUserId())) {
            throw new ValidationException("Username already exists.");
        }
        if(user.getEmail() == null || user.getEmail().trim().isEmpty()){
            throw new ValidationException("Email must be provided.");
        }
        if (userDAO.checkEmailExists(user.getEmail(),user.getUserId())) {
            throw new ValidationException("Email already exists.");
        }
        if(user.getNic() == null || user.getNic().trim().isEmpty()){
            throw new ValidationException("NIC must be provided.");
        }
        if (userDAO.checkNICExists(user.getNic(),user.getUserId())) {
            throw new ValidationException("NIC already exists.");
        }
    }
}
