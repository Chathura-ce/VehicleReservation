package controller;

import dao.DriverDAO;
import dao.UserDAO;
import model.Driver;
import model.User;

import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.FlashMessageUtil;

import java.io.IOException;

//@WebServlet("/add-driver")
public class AddDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
//        String address = request.getParameter("address");
//        String nic = request.getParameter("nic");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String licenseNumber = request.getParameter("licenseNumber");
        String role = "driver";

        try {
            // Create the user
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);  // Use proper password hashing in production
            user.setFullName(fullName);
            user.setEmail(email);
            user.setRole(role);
            user.setPhone(phoneNumber);

            UserDAO userDAO = new UserDAO();
            int userId = userDAO.addUser(user);

            // Create the driver record (linked by userId)
            Driver driver = new Driver(userId, null, licenseNumber);
            DriverDAO driverDAO = new DriverDAO();
            driverDAO.addDriver(driver);

            // Set success message and redirect to driver list
            FlashMessageUtil.setFlashMessage("successMessage",request, "New Driver created successfully.");
            response.sendRedirect("list-drivers");

        } catch (Exception e) {
            e.printStackTrace();
            // Set error message and redirect back to add-driver page
            FlashMessageUtil.setFlashMessage("errorMessage",request, "Failed to create new Driver.");
            response.sendRedirect("driver/add-driver.jsp");
        }
    }
}
