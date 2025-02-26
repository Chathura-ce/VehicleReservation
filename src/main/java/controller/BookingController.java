package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;

import model.Booking;
import model.Car;
import model.Customer;
import service.BookingService;
import service.CustomerService;
import service.CarService;

@WebServlet("/booking/*")
public class BookingController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingService bookingService;
    private CustomerService customerService;
    private CarService carService;

    public void init() {
        bookingService = new BookingService();
        customerService = new CustomerService();
        carService = new CarService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        System.out.println(action);
        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    insertBooking(request, response);
                    break;
                case "/delete":
                    deleteBooking(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateBooking(request, response);
                    break;
                default:
                    listBooking(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Booking> listBooking = bookingService.getAllBookings();
        request.setAttribute("listBooking", listBooking);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/booking-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Customer> customers = customerService.selectAllCustomers();
        List<Car> cars = carService.selectAllCars();
        request.setAttribute("customers", customers);
        request.setAttribute("cars", cars);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/bookings/create-booking.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Booking existingBooking = bookingService.getBookingById(id);
        List<Customer> customers = customerService.selectAllCustomers();
        List<Car> cars = carService.selectAllCars();

        request.setAttribute("bookings", existingBooking);
        request.setAttribute("customers", customers);
        request.setAttribute("cars", cars);
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookings/create-booking.jsp");
        dispatcher.forward(request, response);
    }

    private void insertBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        Map<String, Object> jsonResponse = new HashMap<>();
        try {
            // Retrieve form parameters (same as before)
            String bookingNumber = request.getParameter("bookingNumber");
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String driverId = request.getParameter("driver"); // From dropdown
            String carId = request.getParameter("carId");
            String destination = request.getParameter("destination");
            Timestamp bookingTime = Timestamp.valueOf(
                    request.getParameter("bookingTime").replace("T", " ") + ":00"
            );
            double priceForHr = Double.parseDouble(request.getParameter("priceForHr"));
            int timeHr = Integer.parseInt(request.getParameter("timeHr"));
            double totalFare = Double.parseDouble(request.getParameter("totalFare"));

            // Create booking object
            Booking newBooking = new Booking();
            newBooking.setBookingNumber(bookingNumber);
            newBooking.setCustomerId(customerId);
            newBooking.setDriverId(driverId);
            newBooking.setCarId(carId);
            newBooking.setDestination(destination);
            newBooking.setBookingTime(bookingTime);
            newBooking.setPriceForHr(priceForHr);
            newBooking.setTimeHr(timeHr);
            newBooking.setTotalFare(totalFare);

            // Save the booking (validations occur in the service)
            int bookingId = bookingService.createBooking(newBooking);

            jsonResponse.put("status", "success");
            jsonResponse.put("bookingId", bookingId);
        } catch (IllegalArgumentException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
        } catch (SQLException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Database error while creating booking.");
        }
        response.getWriter().write(gson.toJson(jsonResponse));
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String driverId = request.getParameter("driverId") ;
        String carId = request.getParameter("carId");
        String destination = request.getParameter("destination");
        Timestamp bookingTime = Timestamp.valueOf(request.getParameter("bookingTime"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        int statusId = Integer.parseInt(request.getParameter("statusId"));
/*
        Booking booking = new Booking(customerId, driverId, carId, destination, bookingTime, amount, statusId);
        try {
            if (bookingService.updateBooking(booking)) {
                response.sendRedirect("list");
            } else {
                request.setAttribute("error", "Failed to update booking");
                showEditForm(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            showEditForm(request, response);
        }*/
    }

    private void deleteBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            if (bookingService.deleteBooking(id)) {
                response.sendRedirect("list");
            } else {
                request.setAttribute("error", "Failed to delete booking");
                listBooking(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            listBooking(request, response);
        }
    }
}