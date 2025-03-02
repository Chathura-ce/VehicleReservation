package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import dao.CustomerDAO;
import dao.UserDAO;
import exception.ValidationException;
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
import model.User;
import service.BookingService;
import service.CustomerService;
import service.CarService;
import service.UserService;
import util.PasswordUtil;
import validator.CustomerValidator;
import validator.UserValidator;

@WebServlet("/booking/*")
public class BookingController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingService bookingService;
    private CustomerService customerService;
    private CarService carService;
    private UserService userService;

    public void init() {
        bookingService = new BookingService();
        customerService = new CustomerService();
        carService = new CarService();
        userService = new UserService();
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
                case "/get-booking-numbers":
                    getBookingNumbers(request, response);
                    break; 
                case "/get-details":
                    getBookingDetails(request, response);
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
            // Extract parameters from request
            String username = request.getParameter("customerName");
            String password = PasswordUtil.generateRandomPassword();
            String fullName = request.getParameter("customerName");
            String phoneNumber = request.getParameter("phoneNo");
            String address = request.getParameter("address");
            String nic = request.getParameter("customerNIC");
            String email = request.getParameter("customerEmail");
            String bookingNum = request.getParameter("bookingNumber");
            String customerIdStr = request.getParameter("customerId");
            String driverId = request.getParameter("driver"); // From dropdown
            String carId = request.getParameter("carId");
            String destination = request.getParameter("destination");
            Timestamp pickupTime = Timestamp.valueOf(
                    request.getParameter("pickupTime").replace("T", " ") + ":00"
            );
            Timestamp dropOffTime = Timestamp.valueOf(
                    request.getParameter("dropOffTime").replace("T", " ") + ":00"
            );
            double priceForHr = Double.parseDouble(request.getParameter("priceForHr"));
            double timeHr = Double.parseDouble(request.getParameter("timeHr"));
//            double totalFare = Double.parseDouble(request.getParameter("totalFare"));
            double totalFare = bookingService.calculateTotalFare(priceForHr, timeHr);

            // If customerIdStr is empty, we need to create a new user and customer
            if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
                // Create and validate User
                User user = new User();
                user.setUsername(username);
                user.setPassword(password);
                user.setFullName(fullName);
                user.setEmail(email);
                user.setNic(nic);
                user.setRole("customer");
                UserValidator userValidator = new UserValidator(new UserDAO());
                userValidator.validateUser(user);

                // Create and validate Customer
                Customer customer = new Customer();
                customer.setUsername(username);
                customer.setNic(nic);
                customer.setAddress(address);
                customer.setPhoneNumber(phoneNumber);
                customer.setEmail(email);
                CustomerValidator customerValidator = new CustomerValidator(new CustomerDAO());
                customerValidator.validateCustomer(customer);

                // Create Booking object (customerId will be set in the transaction)
                Booking newBooking = new Booking();
                newBooking.setBookingNumber(bookingNum);
                newBooking.setDriverId(driverId);
                newBooking.setCarId(carId);
                newBooking.setDestination(destination);
                newBooking.setPickupTime(pickupTime);
                newBooking.setDropOffTime(dropOffTime);
                newBooking.setPriceForHr(priceForHr);
                newBooking.setTimeHr(timeHr);
                newBooking.setTotalFare(totalFare);

                // Use the transactional service method to insert user, customer, and booking together.
                String bookingNumber = bookingService.createBookingTransaction(newBooking, user, customer);
                jsonResponse.put("status", "success");
                jsonResponse.put("bookingNumber", bookingNumber);
            } else {
                // If the customer already exists, only create the booking.
//                int customerId = Integer.parseInt(customerIdStr);
                int customerId = customerService.getCustomerIdByNumber(customerIdStr);
                Booking newBooking = new Booking();
                newBooking.setBookingNumber(bookingNum);
                newBooking.setCustomerId(customerId);
                newBooking.setDriverId(driverId);
                newBooking.setCarId(carId);
                newBooking.setDestination(destination);
                newBooking.setPickupTime(pickupTime);
                newBooking.setPriceForHr(priceForHr);
                newBooking.setTimeHr(timeHr);
                newBooking.setTotalFare(totalFare);

                String bookingNumber = bookingService.createBooking(newBooking);
                jsonResponse.put("status", "success");
                jsonResponse.put("bookingNumber", bookingNumber);
            }
        } catch (IllegalArgumentException | ValidationException e) {
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

    private void updateBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            // Extract parameters from request
            String bookingNum = request.getParameter("bookingNumber");
            if (bookingNum == null || bookingNum.trim().isEmpty()) {
                throw new IllegalArgumentException("Booking number is required for update.");
            }

            // Fetch existing booking
            Booking existingBooking = bookingService.getBookingByNumber(bookingNum);
            if (existingBooking == null) {
                throw new IllegalArgumentException("Booking not found.");
            }

            // Extract and validate new values
            String driverId = request.getParameter("driver"); // From dropdown
            String carId = request.getParameter("carId");
            String destination = request.getParameter("destination");

            Timestamp pickupTime = Timestamp.valueOf(
                    request.getParameter("pickupTime").replace("T", " ") + ":00"
            );
            Timestamp dropOffTime = Timestamp.valueOf(
                    request.getParameter("dropOffTime").replace("T", " ") + ":00"
            );

            double priceForHr = Double.parseDouble(request.getParameter("priceForHr"));
            double timeHr = Double.parseDouble(request.getParameter("timeHr"));
            double totalFare = bookingService.calculateTotalFare(priceForHr, timeHr);

            // Update booking object
            existingBooking.setDriverId(driverId);
            existingBooking.setCarId(carId);
            existingBooking.setDestination(destination);
            existingBooking.setPickupTime(pickupTime);
            existingBooking.setDropOffTime(dropOffTime);
            existingBooking.setPriceForHr(priceForHr);
            existingBooking.setTimeHr(timeHr);
            existingBooking.setTotalFare(totalFare);

            // Perform update
            bookingService.updateBooking(existingBooking);

            // Return success response
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Booking updated successfully.");
            jsonResponse.put("bookingNumber", bookingNum);

        } catch (IllegalArgumentException | ValidationException e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Database error while updating booking.");
        }

        response.getWriter().write(gson.toJson(jsonResponse));
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

    private void getBookingNumbers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            List<String> bookingNumbers = bookingService.getBookingByNumbers(); // Fix: Use List<String>
            jsonResponse.put("status", "success");
            jsonResponse.put("bookingNumbers", bookingNumbers);
        } catch (SQLException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Database error while fetching booking numbers.");
            e.printStackTrace();
        }

        response.getWriter().write(gson.toJson(jsonResponse)); // Fix: Send response back
    }


    private void getBookingDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String bookingNumber = request.getParameter("bookingNumber");

            // Check if bookingNumber is present
            if (bookingNumber == null || bookingNumber.isEmpty()) {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Booking number is required.");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
            } else {
                Booking booking = bookingService.getBookingByNumber(bookingNumber);
                if (booking != null) {
                    jsonResponse.put("status", "success");
                    jsonResponse.put("booking", booking);
                    response.setStatus(HttpServletResponse.SC_OK); // 200 OK
                } else {
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Booking not found.");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 Not Found
                }
            }
        } catch (SQLException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Database error while fetching booking details.");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            e.printStackTrace();
        } catch (ValidationException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
        }

        // Convert the map to a JSON string and send it in the response
        String jsonResponseString = gson.toJson(jsonResponse);
        response.getWriter().write(jsonResponseString);
    }


}