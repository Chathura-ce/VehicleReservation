package controller;

import dao.DriverDAO;
import model.Driver;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/list-drivers")
public class ListDriversServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DriverDAO driverDAO = new DriverDAO();

        try {
            List<Driver> driverList = driverDAO.getAllDrivers();
            request.setAttribute("driverList", driverList);

            // Forward to JSP page
            request.getRequestDispatcher("driver/list-drivers.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving driver list.");
            request.getRequestDispatcher("driver/list-drivers.jsp").forward(request, response);
        }
    }
}
