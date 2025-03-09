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
import jakarta.servlet.http.HttpSession;
import model.Booking;
import model.User;
import service.BookingService;

@WebServlet("/driver-dashboard/*")
public class DriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingService bookingService;
    public void init() {
        bookingService = new BookingService();
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
                case "/assigned-bookings":
                    assignedBookings(request, response);
                    break;
                default:

                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void assignedBookings(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("loggedInUser") != null) {
            // Retrieve the user object from the session
            User loggedInUser = (User) session.getAttribute("loggedInUser");

            // Get the user ID
            int userId = loggedInUser.getUserId();

            List<Booking> assignedBookings = bookingService.getAssignedBookings(userId);
            request.setAttribute("assignedBookings", assignedBookings);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/driver/assigned-bookings.jsp");
            dispatcher.forward(request, response);

        } else {
            // Redirect to login page or show an error
            response.sendRedirect("../login.jsp");
        }

    }
}
