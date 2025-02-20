package controller;

import dao.UserDAO;
import dao.CustomerDAO;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String email = request.getParameter("email");

        UserDAO userDAO = new UserDAO();
        CustomerDAO customerDAO = new CustomerDAO();

        StringBuilder errorMessage = new StringBuilder();

        if (username == null || username.trim().isEmpty()) {
            errorMessage.append("Username is required.<br>");
        }
        if (password == null || password.trim().isEmpty()) {
            errorMessage.append("Password is required. <br>");
        }
        if (fullName == null || fullName.trim().isEmpty()) {
            errorMessage.append("Full name is required. <br>");
        }
        if (address == null || address.trim().isEmpty()) {
            errorMessage.append("Address is required. <br>");
        }
        if (nic == null || nic.trim().isEmpty()) {
            errorMessage.append("NIC is required. <br>");
        }
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            errorMessage.append("Phone number is required. <br>");
        }

        // Validate email format if provided
        if (email != null && !email.trim().isEmpty()) {
            String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
            if (!email.matches(emailRegex)) {
                errorMessage.append("Invalid email format. <br>");
            }
        }

        //check if the username is already registered
        try {
            if (userDAO.checkUsernameExists(username)) {
                errorMessage.append("Username  already exists.");
            }
        } catch (SQLException e) {
            errorMessage.append("Error checking username. Please try again. <br>");
        }

        //check if the email is already registered
        try {
            if (userDAO.checkEmailExists(email)) {
                errorMessage.append("Email already exists. <br>");
            }
        } catch (SQLException e) {
            errorMessage.append("Error checking email. Please try again. <br>");
        }

        //check if the phone is already registered
        try {
            if (customerDAO.customerPhoneNumberExists(phoneNumber)) {
                errorMessage.append("Phone number already exists. <br>");
            }
        } catch (SQLException e) {
            errorMessage.append("Error checking phone number. Please try again. ");
        }

        //check if the NIC is already registered
        try {
            if (customerDAO.customerExistsByNIC(nic)) {
                errorMessage.append("NIC already exists. <br>");
            }
        } catch (SQLException e) {
            errorMessage.append("Error checking NIC. Please try again. <br>");
        }

        // If there are any errors, forward back to registration page with the error message
        if (errorMessage.length() > 0) {
            request.setAttribute("errorMessage", errorMessage.toString());

            request.setAttribute("username", username);
            request.setAttribute("password", password);
            request.setAttribute("fullName", fullName);
            request.setAttribute("address", address);
            request.setAttribute("nic", nic);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("email", email);

            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            //  Register the user
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setRole("customer");

            int userId = userDAO.addUser(user);

            // Register the customer details linked to the user account

            Customer customer = new Customer();
            customer.setUserId(userId);
            customer.setAddress(address);
            customer.setNic(nic);
            customer.setPhoneNumber(phoneNumber);

            customerDAO.addCustomer(customer);
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Successfully registered! Please login.");
            response.sendRedirect("login.jsp");
//            request.setAttribute("successMessage", "Successfully registered! Please login. <br>");
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//            response.sendRedirect("login.jsp");
        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("error.jsp");
            request.setAttribute("errorMessage", "Error registering user. Please try again. <br>");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
