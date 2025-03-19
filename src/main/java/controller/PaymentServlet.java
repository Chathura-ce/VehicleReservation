package controller;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

import exception.ValidationException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Booking;
import model.Car;
import service.BookingService;
import service.CarService;
import util.PricingConfig;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/create-checkout-session")
public class PaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        try {
            switch (action) {
                case "/book-car":
                    bookingPaymentPage(request, response);
                    break;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the total fare from the request parameters
        String bookingNumber = request.getParameter("bookingNumber");

        BookingService bookingService = new BookingService();
        Booking booking = null;
        try {
            booking = bookingService.getBookingByNumber(bookingNumber);
        } catch (ValidationException | SQLException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Error while getting booking by number");
        }

        try {
            // Convert totalFare to Long (amount in cents)
            assert booking != null;
            long totalFare = Math.round(booking.getTotalFare() * 100); // Convert to cents

            // Set your Stripe Secret Key
            Stripe.apiKey = "sk_test_51R2xBMHBoMeUyf28IOmf5Eh6UNX4XaX5UFanFOpdBlFH05j8KkrTGRfo4udl7nWJLiAarismH4MNjfKsmy3RehvF0059vc0kEJ";

            // Create a new Checkout Session with dynamic values
            SessionCreateParams params = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setSuccessUrl("http://localhost:8080/customer-booking/payment-success?bookingNo="+bookingNumber) // Update with your success URL
                    .setCancelUrl("http://localhost:8080/customer-booking/payment-cancel?bookingNo="+bookingNumber)   // Update with your cancel URL
                    .addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD)
                    .addLineItem(
                            SessionCreateParams.LineItem.builder()
                                    .setQuantity(1L)
                                    .setPriceData(
                                            SessionCreateParams.LineItem.PriceData.builder()
                                                    .setCurrency("lkr") // Set currency to Sri Lankan Rupee
                                                    .setUnitAmount(totalFare) // Use the dynamic total fare in cents
                                                    .setProductData(
                                                            SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                    .setName(booking.getCar().getCarModel().getModelName()) // Update with your product name
                                                                    .build())
                                                    .build())
                                    .build())
                    .build();

            // Create the session using Stripe API
            Session session = Session.create(params);

            bookingService.updateBookingPayment(1,bookingNumber);

            // Return JSON response with session ID
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"id\": \"" + session.getId() + "\"}");
            out.flush();

        } catch (NumberFormatException e) {
            // Handle invalid number format for totalFare
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid 'totalFare' format. Must be a numeric value.");
        } catch (StripeException e) {
            // Handle Stripe-related errors
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Stripe Error: " + e.getMessage());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected void bookingPaymentPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String carId = request.getParameter("carId");

        if (carId != null && !carId.isEmpty()) {
            CarService carService = new CarService();
            Car car = null;
            try {
                car = carService.getCarById(carId);
            } catch (SQLException e) {
                System.out.println("SQLException: " + e.getMessage());
            }

            if (car != null) {
                // Car exists, forward to book-car.jsp with car data
                request.setAttribute("car", car);
                request.setAttribute("baseCharge", PricingConfig.BASE_CHARGE);
                request.setAttribute("taxPercentage", PricingConfig.TAX_PERCENTAGE);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/customer-booking-payment.jsp");
                dispatcher.forward(request, response);
            } else {
                // Car not found, redirect to an error page or show a message
                response.sendRedirect("error.jsp?message=Car not available");
            }
        } else {
            // Invalid carId, redirect back
            response.sendRedirect("car-selection.jsp?message=Please select a valid car");
        }
    }
}
