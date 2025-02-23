package controller;

import dao.CarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.FlashMessageUtil;

import java.io.IOException;

@WebServlet("/delete-car")
public class DeleteCarServlet extends HttpServlet {

    private CarDAO carDAO;

    @Override
    public void init() throws ServletException {
        carDAO = new CarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carId = request.getParameter("carId");

        if (carId == null || carId.trim().isEmpty()) {
            FlashMessageUtil.setFlashMessage("errorMessage", request, "Invalid car ID.");
            response.sendRedirect("list-cars");
            return;
        }

        try {

            // Delete driver
            boolean carDeleted = carDAO.deleteCar(carId);

            if (carDeleted) {
                FlashMessageUtil.setFlashMessage("successMessage", request, "Car deleted successfully.");
            } else {
                FlashMessageUtil.setFlashMessage("errorMessage", request, "Failed to delete car. Please try again.");
            }

            response.sendRedirect("list-cars");
        } catch (Exception e) {
            e.printStackTrace();
            FlashMessageUtil.setFlashMessage("errorMessage", request, "Database error. Please try again.");
            response.sendRedirect("list-cars");
        }
    }
}
