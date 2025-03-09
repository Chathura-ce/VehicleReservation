package controller;

import com.google.gson.Gson;
import dao.CustomerDAO;
import dao.UserDAO;
import exception.ValidationException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;
import model.Car;
import model.Customer;
import model.User;
import service.BookingService;
import service.CarService;
import service.CustomerService;
import service.UserService;
import util.PasswordUtil;
import util.PricingConfig;
import validator.CustomerValidator;
import validator.UserValidator;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/customer-booking/*")
public class CustomerBooking extends HttpServlet {

    private CarService carService;
    private BookingService bookingService;

    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
        carService = new CarService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        try {
            switch (action) {
                case "/book-car":
                    bookingPage(request, response);
                    break;
                case "/create-booking":
                    createBooking(request, response);
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
       /*  String action = request.getPathInfo();
       try {
            switch (action) {
                case "/create-booking":
                    createBooking(request, response);
                    break;
                    case "/payment":
                    paymentPage(request, response);
                    break;
                default: break;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
//            throw new ServletException(ex);
        }*/
    }

    protected void bookingPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get existing session, don't create a new one
        if (session == null || session.getAttribute("loggedInUser") == null) {
            // Redirect to login page if user is not logged in
            response.sendRedirect("/login.jsp");
            return;
        }
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
                RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/booking-page.jsp");
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

    private void createBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession(false); // Get existing session, don't create a new one

        if (session == null || session.getAttribute("loggedInUser") == null) {
            // Redirect to login page if user is not logged in
            response.sendRedirect("/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("loggedInUser");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            // Extract parameters from request
            String bookingNum = request.getParameter("bookingNumber");
            String customerIdStr = request.getParameter("customerId");
            String driverId = request.getParameter("driver");
            String carId = request.getParameter("carId");
            String destination = request.getParameter("destination");
            String pickupLocation = request.getParameter("pickupLocation");
            String pickupDate = request.getParameter("pickupDate");
            String pickupTime = request.getParameter("pickupTime");
            double priceForKm = !request.getParameter("priceForKm").isEmpty() ? Double.parseDouble(request.getParameter("priceForKm")) : 0;
            double distance = !request.getParameter("distance").isEmpty() ? Double.parseDouble(request.getParameter("distance")) : 0;
            double totalFare = bookingService.calculateTotalFare(priceForKm, distance);


            // If the customer already exists, only create the booking.
//                int customerId = Integer.parseInt(customerIdStr);
//                int customerId = customerService.getCustomerIdByNumber(customerIdStr);
            Booking newBooking = new Booking();
            newBooking.setBookingNumber(bookingNum);
            newBooking.setCustomerId(customerIdStr);
            newBooking.setDriverId(driverId);
            newBooking.setCarId(carId);
            newBooking.setDestination(destination);
            newBooking.setPickupLocation(pickupLocation);
                newBooking.setPickupDate(pickupDate);
                newBooking.setPickupTime(pickupTime);
//                newBooking.setDropOffTime(dropOffTime);
            newBooking.setPriceForKm(priceForKm);
            newBooking.setDistance(distance);
            newBooking.setTotalFare(totalFare);

            String bookingNumber = bookingService.createBooking(newBooking);
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Booking updated successfully.Booking No: " + bookingNumber);
            jsonResponse.put("bookingNumber", bookingNumber);
        } catch (ValidationException e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Database error while creating booking.");
        }
        response.getWriter().write(gson.toJson(jsonResponse));
    }

    protected void paymentPage(HttpServletRequest request, HttpServletResponse response)
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
