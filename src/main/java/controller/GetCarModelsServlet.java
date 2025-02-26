package controller;

import com.google.gson.Gson;
import dao.CarModelDAO;
import model.CarModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/getCarModels")
public class GetCarModelsServlet extends HttpServlet {

    private CarModelDAO carModelDAO;

    @Override
    public void init() throws ServletException {
        carModelDAO = new CarModelDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String typeIdParam = request.getParameter("typeId");
        int typeId = 0;
        try {
            typeId = Integer.parseInt(typeIdParam);
        } catch(NumberFormatException e) {
            // If no valid typeId is provided, return an empty array
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("[]");
            return;
        }
        List<CarModel> models;
        try {
            models = carModelDAO.getCarModelsByTypeId(typeId);
        } catch (SQLException e) {
            throw new ServletException("Database error while fetching car models", e);
        }
        Gson gson = new Gson();
        String json = gson.toJson(models);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
