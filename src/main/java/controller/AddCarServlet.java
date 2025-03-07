package controller;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.*;
import util.CarUtil;
import util.FlashMessageUtil;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Collection;

@WebServlet("/add-car")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB per file
        maxRequestSize = 1024 * 1024 * 50       // 50MB overall
)
public class AddCarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DriverDAO driverDAO = new DriverDAO();
        List<Driver> availableDrivers  = driverDAO.getAvailableDrivers();
        request.setAttribute("availableDrivers", availableDrivers);

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
             models = carModelDAO.getCarModelsByTypeId(0);
        } catch (SQLException e) {
        }
        request.setAttribute("models", models);

        String carId = CarUtil.generateCarId();
        request.setAttribute("carId", carId);
        request.getRequestDispatcher("cars/add-car.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve non-file form data
        String carId = request.getParameter("carId");
        String model = request.getParameter("model");
        String type = request.getParameter("type");
        String regNumber = request.getParameter("regNumber");
        String seatingCapacityStr = request.getParameter("seatingCapacity");
        int available = Integer.parseInt(request.getParameter("available"));
        int seatingCapacity = Integer.parseInt(seatingCapacityStr);

        try {
            CarType carType = new CarType();
            carType.setTypeId(Integer.parseInt(type));

            CarModel carModel = new CarModel();
            carModel.setModelId(Integer.parseInt(model));

            Car car = new Car(carId, carModel, carType, regNumber, seatingCapacity, available);
            CarDAO carDAO = new CarDAO();
            carDAO.addCar(car); // Insert into Car table
        } catch (Exception e) {
            e.printStackTrace();
            FlashMessageUtil.setFlashMessage("errorMessage", request, "Error while adding car");
            response.sendRedirect("/add-car");
            return; // Stop execution if car saving fails
        }

        // Retrieve uploaded image paths from hidden inputs
        String[] imagePaths = request.getParameterValues("imagePaths");
        CarImageDAO carImageDAO = new CarImageDAO();

        if (imagePaths != null) {
            for (String imagePath : imagePaths) {
                CarImage carImage = new CarImage(carId, imagePath);
                try {
                    carImageDAO.addCarImage(carImage); // Insert into Car_Image table
                } catch (Exception e) {
                    e.printStackTrace();
                    FlashMessageUtil.setFlashMessage("errorMessage", request, "Error while saving image data");
                    response.sendRedirect("/add-car");
                    return;
                }
            }
        }

        // Redirect after success
        FlashMessageUtil.setFlashMessage("successMessage", request, "Successfully added car");
        response.sendRedirect("/list-cars");
    }
}
