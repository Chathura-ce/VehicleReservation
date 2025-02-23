package controller;

import dao.CarDAO;
import model.Car;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/list-cars")
public class ListCarsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CarDAO carDAO = new CarDAO();

        try {
            List<Car> carList = carDAO.getAllCars();
            request.setAttribute("carList", carList);

            // Forward to JSP page
            request.getRequestDispatcher("cars/list-cars.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving car list.");
            request.getRequestDispatcher("cars/list-cars.jsp").forward(request, response);
        }
    }
}