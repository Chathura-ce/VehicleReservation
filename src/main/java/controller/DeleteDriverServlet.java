package controller;

import dao.DriverDAO;
import dao.UserDAO;
import jakarta.servlet.annotation.WebServlet;
import util.FlashMessageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
@WebServlet("/delete-driver")
public class DeleteDriverServlet extends HttpServlet {

    private DriverDAO driverDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        driverDAO = new DriverDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverId = request.getParameter("driverId");

        if (driverId == null || driverId.trim().isEmpty()) {
            FlashMessageUtil.setFlashMessage("errorMessage", request, "Invalid driver ID.");
            response.sendRedirect("list-drivers");
            return;
        }

        try {
            // Check if the driver exists
            if (!driverDAO.isDriverIdExists(driverId)) {
                FlashMessageUtil.setFlashMessage("errorMessage", request, "Driver not found.");
                response.sendRedirect("list-drivers");
                return;
            }

            // Get associated user ID before deleting driver
            int userId = driverDAO.getUserIdByDriverId(driverId);

            // Delete driver
            boolean driverDeleted = driverDAO.deleteDriver(driverId);

            if (driverDeleted) {
                // Delete the associated user account if exists
                if (userId > 0) {
                    userDAO.deleteUser(userId);
                }

                FlashMessageUtil.setFlashMessage("successMessage", request, "Driver deleted successfully.");
            } else {
                FlashMessageUtil.setFlashMessage("errorMessage", request, "Failed to delete driver. Please try again.");
            }

            response.sendRedirect("list-drivers");
        } catch (SQLException e) {
            e.printStackTrace();
            FlashMessageUtil.setFlashMessage("errorMessage", request, "Database error. Please try again.");
            response.sendRedirect("list-drivers");
        }
    }
}
