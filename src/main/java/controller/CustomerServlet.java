package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.User;
import service.BookingService;
import service.CarService;
import service.CustomerService;
import service.UserService;

import java.io.IOException;
@WebServlet("/customer-data/*")
public class CustomerServlet extends HttpServlet {
    private CustomerService customerService;
    private UserService userService;
    private UserDAO userDAO;

    public void init() throws ServletException {
        customerService = new CustomerService();
        userService = new UserService();
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        try {
            switch (action) { 
                case "/customer-profile":
                    customerProfile(request, response);
                    break;
                default:
                    break;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
//            throw new ServletException(ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void customerProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get customer ID from session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Get customer data
            Customer customer = customerService.getCustomerByUserId(userId);
            if (customer == null) {
                throw new ServletException("Customer not found");
            }
            User user = userDAO.getUser(userId);

            // Set customer data in request attribute
            request.setAttribute("user", user);
            request.setAttribute("customer", customer);
            // Forward to profile JSP
            String jspPath = "/customer/customer-profile.jsp";
            request.getRequestDispatcher(jspPath).forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error retrieving customer profile", e);
        }
    }
}
