package controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Car;
import service.CarService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/car/*")
public class CarServlet extends HttpServlet {

    private CarService carService;

    @Override
    public void init() throws ServletException {
        carService = new CarService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        try {
            switch (action) {
                case "/searchCars":
                    searchCars(request, response);
                    break;
                default: break;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
//            throw new ServletException(ex);
        }
    }

    protected void searchCars(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int carType = !request.getParameter("carType").isEmpty() ? Integer.parseInt(request.getParameter("carType")) : 0;
        int carModel = !request.getParameter("carModel").isEmpty() ?  Integer.parseInt(request.getParameter("carModel")) : 0;
        String sortBy = request.getParameter("sortBy")!=null && !request.getParameter("sortBy").isEmpty() ?  request.getParameter("sortBy") : "";
        List<Car> cars;
        try {
            cars = carService.searchCars(carType,carModel,sortBy);
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
