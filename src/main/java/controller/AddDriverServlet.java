package controller;

import dao.DriverDAO;
import dao.UserDAO;
import exception.ValidationException;
import model.Driver;
import model.User;

import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.EmailSender;
import util.FlashMessageUtil;
import validator.DriverValidator;
import validator.UserValidator;

import java.io.IOException;

//@WebServlet("/add-driver")
public class AddDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
//        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String licenseNumber = request.getParameter("licenseNumber");
        String role = "driver";

        try {
            DriverValidator driverValidator = new DriverValidator();
            driverValidator.validateDriver(licenseNumber,null);

            // Create the user
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);  // Use proper password hashing in production
            user.setFullName(fullName);
            user.setEmail(email);
            user.setRole(role);
            user.setPhone(phoneNumber);
            user.setNic(nic);

            UserDAO userDAO = new UserDAO();
            UserValidator userValidator = new UserValidator(userDAO);
            userValidator.validateUser(user);

            int userId = userDAO.addUser(user);

            // Create the driver record (linked by userId)
            Driver driver = new Driver(userId, null, licenseNumber);

            DriverDAO driverDAO = new DriverDAO();
            driverDAO.addDriver(driver);

            EmailSender.sendEmail(email, "Your Mega City Cab Driver Account", generateDriverEmailTemplate(user,password));
            // Set success message and redirect to driver list
            FlashMessageUtil.setFlashMessage("successMessage",request, "New Driver created successfully.");
            response.sendRedirect("list-drivers");

        }catch (ValidationException e){
            e.printStackTrace();
            request.setAttribute("username", request.getParameter("username"));
            request.setAttribute("fullName", request.getParameter("fullName"));
            request.setAttribute("nic", request.getParameter("nic"));
            request.setAttribute("phoneNumber", request.getParameter("phoneNumber"));
            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("license", request.getParameter("licenseNumber"));
            FlashMessageUtil.setFlashMessage("errorMessage",request, e.getMessage());
            request.getRequestDispatcher("driver/add-driver.jsp").forward(request, response);
//            response.sendRedirect("driver/add-driver.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("username", request.getParameter("username"));
            request.setAttribute("fullName", request.getParameter("fullName"));
            request.setAttribute("nic", request.getParameter("nic"));
            request.setAttribute("phoneNumber", request.getParameter("phoneNumber"));
            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("license", request.getParameter("licenseNumber"));
            // Set error message and redirect back to add-driver page
//            FlashMessageUtil.setFlashMessage("errorMessage",request, "Failed to create new Driver.");
//            response.sendRedirect("driver/add-driver.jsp");
            request.getRequestDispatcher("driver/add-driver.jsp").forward(request, response);
        }
    }

    private String generateDriverEmailTemplate(User user, String password) {
        return "<div class='email-container' style='font-family: Arial, sans-serif; border: 1px solid #ddd; padding: 20px;'>"
                + "<div class='email-header' style='text-align: center; background-color: #007bff; color: white; padding: 10px;'>"
                + "<h1>MEGA CITY CAB</h1><p>Driver Account Created</p></div>"
                + "<div class='email-body' style='margin-top: 20px;'>"
                + "<p>Dear " + user.getFullName() + ",</p>"
                + "<p>Your Mega City Cab driver account has been created successfully.</p>"
                + "<p><strong>Username:</strong> " + user.getUsername() + "</p>"
                + "<p><strong>Temporary Password:</strong> " + password + "</p>"
                + "<p>Please log in and change your password immediately for security purposes.</p>"
                + "<p><a href='http://localhost:8080/login.jsp' style='color: #007bff;'>Login Here</a></p>"
                + "</div><div class='email-footer' style='text-align: center; margin-top: 20px;'>"
                + "<p>Thank you for joining Mega City Cab!</p>"
                + "<p>© 2024 Mega City Cab. All Rights Reserved.</p></div></div>";
    }

}
