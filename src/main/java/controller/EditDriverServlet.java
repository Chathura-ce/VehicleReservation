package controller;

import dao.DriverDAO;
import dao.UserDAO;
import model.Driver;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.FlashMessageUtil;
import util.ValidationUtil;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

@WebServlet("/edit-driver")
public class EditDriverServlet extends HttpServlet {

    private DriverDAO driverDAO = new DriverDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String driverIdStr = request.getParameter("driverId");
        if (driverIdStr == null) {
            response.sendRedirect("list-drivers");
            return;
        }

        try {
            Driver driver = driverDAO.getDriverById(driverIdStr);
            if (driver == null) {
                // If driver doesn't exist, redirect back to list
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Sorry, driver does not exist");
                response.sendRedirect("list-drivers");
                return;
            }
            // Put driver in request scope and forward to edit form
            request.setAttribute("driver", driver);
            request.getRequestDispatcher("driver/edit-driver.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Error while getting driver details");
            response.sendRedirect("list-drivers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        // Retrieve form fields
        String driverId = request.getParameter("driverId");
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String licenseNumber = request.getParameter("licenseNumber");
        String email = request.getParameter("email");
        String statusStr = request.getParameter("status");

        // Validate inputs
        Map<String, String> errors = ValidationUtil.validateDriverInput(Integer.parseInt(userId), driverId, username, fullName,
                phoneNumber, licenseNumber, email,
                statusStr, driverDAO, userDAO);

        // If errors exist, forward them back to the form
        if (!errors.isEmpty()) {
            StringBuilder errorMessage = new StringBuilder();
            for (String error : errors.values()) {
                errorMessage.append(error).append("<br>"); // Append each error with a line break
            }

            FlashMessageUtil.setFlashMessage("errorMessage", request, errorMessage.toString());
//            request.setAttribute("errorMessage", errorMessage.toString());
//            request.setAttribute("fullName", fullName);
//            request.setAttribute("phoneNumber", phoneNumber);
//            request.setAttribute("licenseNumber", licenseNumber);
//            request.setAttribute("email", email);
//            request.setAttribute("status", statusStr);
            response.sendRedirect("edit-driver?driverId=" + driverId);
            return;
        }

        // Convert status string to integer (1 for Active, 0 for Inactive)
        int status = "active".equalsIgnoreCase(statusStr) ? 1 : 0;

        try {
            // Fetch existing driver from DB
            Driver driver = driverDAO.getDriverById(driverId);
            if (driver == null || driver.getUser() == null) {
                response.sendRedirect("list-drivers");
                return;
            }

            // Fetch the associated User object
            User user = driver.getUser();

            // Update user details
            user.setFullName(fullName);
            user.setPhone(phoneNumber);
            user.setEmail(email);
            user.setStatus(status);

            // Only update password if provided
            if (password != null && !password.trim().isEmpty()) {
                user.setPassword(password); // Ensure password hashing if needed
            }

            // Update license number for the driver
            driver.setLicenseNumber(licenseNumber);

            // Save changes to database
            userDAO.updateUser(user);
            driverDAO.updateDriver(driver);
            FlashMessageUtil.setFlashMessage("successMessage", request, "Driver updated successfully");
            response.sendRedirect("list-drivers");
        } catch (SQLException e) {
            e.printStackTrace();
            FlashMessageUtil.setFlashMessage("errorMessage", request, "Error while updating driver details");
            response.sendRedirect("edit-driver?driverId=" + driverId);
        }
    }


}
