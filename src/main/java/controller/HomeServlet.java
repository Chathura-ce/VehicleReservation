package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.Car;
import service.CarService;

@WebServlet("/home/*")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CarService carService;

    public void init() {
        carService = new CarService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        try {
            switch (action) {
                case "/home":
                    showHomePage(request, response);
                    break;
                default: break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void showHomePage(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Car> listBooking = carService.selectAllCars();
        request.setAttribute("cars", listBooking);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/home.jsp");
        dispatcher.forward(request, response);
    }

}