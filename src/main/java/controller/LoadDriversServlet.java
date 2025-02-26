package controller;

import com.google.gson.Gson;
import dao.DriverDAO;
import model.Driver;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/loadDrivers")
public class LoadDriversServlet extends HttpServlet {

    private DriverDAO driverDAO;

    @Override
    public void init() throws ServletException {
        driverDAO = new DriverDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Driver> drivers;
        drivers = driverDAO.getAvailableDrivers();
        // Convert the list of drivers to JSON using Gson
        Gson gson = new Gson();
        String json = gson.toJson(drivers);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
