package controller;

import dao.UserDAO;
import dao.CustomerDAO;
import model.User;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");

        try {
            //  Register the user
            UserDAO userDAO = new UserDAO();
            User user = new User();
            user.setUsername(username);
            user.setPasswordHash(password);  // Use proper password hashing in production
            user.setFullName(fullName);
            user.setEmail(email);
            user.setRoleId(2);  // 2 = Customer role

            int userId = userDAO.addUser(user);

            // Register the customer details linked to the user account
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = new Customer();
            customer.setUserId(userId);
            customer.setAddress(address);
            customer.setNic(nic);
            customer.setPhoneNumber(phoneNumber);

            customerDAO.addCustomer(customer);

            response.sendRedirect("login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
