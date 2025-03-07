package controller;

import dao.CarDAO;
import dao.CarModelDAO;
import dao.CarTypeDAO;
import dao.DriverDAO;
import model.Car;
import model.CarModel;
import model.CarType;
import model.Driver;
import util.FlashMessageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/edit-car")
public class EditCarServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carId = request.getParameter("carId");
        
        if (carId != null && !carId.isEmpty()) {
            try {
                CarDAO carDAO = new CarDAO();
                Car car = carDAO.getCarById(carId);

                CarTypeDAO carType = new CarTypeDAO();
                List<CarType> carTypes = new ArrayList<>();
                try {
                    carTypes = carType.getAllCarTypes();
                } catch (SQLException e) {
                }
                request.setAttribute("carTypes", carTypes);

                CarModelDAO carModelDAO = new CarModelDAO();
                List<CarModel> models = new ArrayList<>();
                try {
                    models = carModelDAO.getCarModelsByTypeId(car.getType().getTypeId());
                } catch (SQLException e) {
                }
                request.setAttribute("models", models);

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
        int available = Integer.parseInt(request.getParameter("available"));
        int seatingCapacity = Integer.parseInt(seatingCapacityStr);
        String driverId = request.getParameter("driverId");

        try {
            CarType carType = new CarType();
            carType.setTypeId(Integer.parseInt(type));

            CarModel carModel = new CarModel();
            carModel.setModelId(Integer.parseInt(model));

            Car car = new Car(carId, carModel, carType, regNumber, seatingCapacity, available);
            car.setDriverId(driverId);
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