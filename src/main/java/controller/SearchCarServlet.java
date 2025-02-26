package controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.CarService;
import model.Car;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/searchCar")
public class SearchCarServlet extends HttpServlet {

    private CarService carService;

    @Override
    public void init() throws ServletException {
        carService = new CarService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the query parameter (for example: reg number or model)
        String query = request.getParameter("q");
        List<Car> cars;
        try {
            cars = carService.searchCars(query);
        } catch (SQLException e) {
            throw new ServletException("Database error during car search", e);
        }

        // Convert list of cars to JSON using Gson
        Gson gson = new Gson();
        String json = gson.toJson(cars);

        // Set response headers and write JSON data
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
