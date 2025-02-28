package service;

import dao.UserDAO;
import model.User;

import java.sql.Connection;
import java.sql.SQLException;

public class UserService {
//    private final UserDAO userDAO;
//    public UserService() {
//        this.userDAO = new UserDAO();
//    }
    public int insertUser(User user, Connection conn) throws SQLException {
        return new UserDAO().addUser(user,conn);
    }
}
