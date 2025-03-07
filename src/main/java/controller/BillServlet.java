package controller;

import dao.BookingDAO;
import exception.ValidationException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import service.BookingService;
import util.PricingConfig;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {
    private BookingService bookingService;
    public void init() throws ServletException {
        // Initialize the BookingService (direct initialization)
        bookingService = new BookingService();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingNumber = request.getParameter("bookingNumber");

        if (bookingNumber != null && !bookingNumber.isEmpty()) {
            // Fetch booking details from the database using the booking number
            Booking booking = null;
            try {
                booking = bookingService.getBookingByNumber(bookingNumber);
            } catch (ValidationException | SQLException e) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Error while getting booking by number");
            }


            if (booking != null) {
                // Set the booking object as a request attribute to pass to the JSP
                double distanceCharge = booking.getDistance() * booking.getPriceForKm();
                request.setAttribute("baseCharge", PricingConfig.BASE_CHARGE);
                request.setAttribute("distanceCharge", distanceCharge);
                request.setAttribute("taxPercentage", PricingConfig.TAX_PERCENTAGE);
                request.setAttribute("booking", booking);
                double subTotal = PricingConfig.BASE_CHARGE + distanceCharge;
                request.setAttribute("subTotal",subTotal );

                // Forward the request to bill.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("/bookings/bill.jsp");
                dispatcher.forward(request, response);
            } else {
                // Handle case where booking is not found (optional)
                request.setAttribute("errorMessage", "Booking not found");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/bookings/bill.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            // Handle missing booking number (optional)
            request.setAttribute("errorMessage", "Booking number is missing");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/bookings/bill.jsp");
            dispatcher.forward(request, response);
        }

    }
}
