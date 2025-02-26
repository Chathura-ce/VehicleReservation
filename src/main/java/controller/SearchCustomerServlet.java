package controller;

import com.google.gson.Gson;
import service.CustomerService;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/searchCustomer")
public class SearchCustomerServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the query parameter
        String query = request.getParameter("q");
        List<Customer> customers;
        try {
            customers = customerService.searchCustomers(query);
        } catch (SQLException e) {
            throw new ServletException("Database error during search", e);
        }

        // Convert the list of customers to JSON using Gson
        Gson gson = new Gson();
        String json = gson.toJson(customers);

        // Set response headers and write the JSON data
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
