package controller;

import dao.CarDAO;
import dao.DriverDAO;
import model.Car;
import model.Driver;
import util.FlashMessageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/edit-car")
public class EditCarServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carId = request.getParameter("carId");
        
        if (carId != null && !carId.isEmpty()) {
            try {
                CarDAO carDAO = new CarDAO();
                Car car = carDAO.getCarById(carId);
                
                if (car != null) {
                    DriverDAO driverDAO = new DriverDAO();
                    List<Driver> availableDrivers  = driverDAO.getAvailableDrivers();
                    request.setAttribute("car", car);
                    request.setAttribute("availableDrivers", availableDrivers);
                    request.getRequestDispatcher("cars/edit-car.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                FlashMessageUtil.setFlashMessage("errorMessage", request, "Error retrieving car details.");
            }
        }
        response.sendRedirect("list-cars");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carId = request.getParameter("carId");
        String model = request.getParameter("model");
        String type = request.getParameter("type");
        String regNumber = request.getParameter("regNumber");
        String seatingCapacityStr = request.getParameter("seatingCapacity");
        String available = request.getParameter("available");
        int seatingCapacity = Integer.parseInt(seatingCapacityStr);
        
        try {
            Car car = new Car(carId, model, type, regNumber, seatingCapacity, available);
            CarDAO carDAO = new CarDAO();

            // Save changes to database
            carDAO.updateCar(car);
            FlashMessageUtil.setFlashMessage("successMessage", request, "Car updated successfully.");
            response.sendRedirect("/list-cars");
            
        } catch (Exception e) {
            e.printStackTrace();
            FlashMessageUtil.setFlashMessage("errorMessage", request, "Failed to update car.");
            response.sendRedirect("/edit-car?carId=" + carId);
        }
    }
}