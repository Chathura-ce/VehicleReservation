package controller;

import com.google.gson.Gson;
import dao.CarTypeDAO;
import model.CarType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/getCarTypes")
public class GetCarTypesServlet extends HttpServlet {

    private CarTypeDAO carTypeDAO;

    @Override
    public void init() throws ServletException {
        carTypeDAO = new CarTypeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<CarType> carTypes;
        try {
            carTypes = carTypeDAO.getAllCarTypes();
        } catch (SQLException e) {
            throw new ServletException("Database error while retrieving car types", e);
        }
        Gson gson = new Gson();
        String json = gson.toJson(carTypes);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
