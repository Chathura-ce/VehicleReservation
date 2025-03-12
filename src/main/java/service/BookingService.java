package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import dao.BookingDAO;
import dao.CarDAO;
import dao.CustomerDAO;
import dao.UserDAO;
import exception.ValidationException;
import model.Booking;
import model.Car;
import model.Customer;
import model.User;
import util.DatabaseUtil;
import util.EmailSender;
import validator.BookingValidator;
import validator.CustomerValidator;
import validator.UserValidator;

public class BookingService {
    private BookingDAO bookingDAO;

    private static final double DEFAULT_TAX_RATE = 0.10;       // 10% tax
    private static final double DEFAULT_DISCOUNT_RATE = 0.05;    // 5% discount

    public BookingService() {
        this.bookingDAO = new BookingDAO();
    }

    public List<Booking> getAllBookings() throws SQLException {
        return bookingDAO.selectAllBookings();
    }

    // Non-transactional version: used in the servlet for existing customers.
    public String createBooking(Booking booking) throws SQLException, ValidationException {
        try (Connection connection = DatabaseUtil.getConnection()) {
            return createBooking(booking, connection);
        }
    }

    public String createBooking(Booking booking,Connection connection) throws SQLException {
        double totalFare = booking.getPriceForKm() * booking.getDistance();
        booking.setTotalFare(totalFare);

        booking.setStatusId(1);
        booking.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

        return bookingDAO.insertBooking(booking,connection);
    }

    public String createBookingTransaction(Booking booking, User user, Customer customer)
            throws SQLException, ValidationException {
        Connection connection = null;
        try {
            connection = DatabaseUtil.getConnection();
            connection.setAutoCommit(false); // Start transaction

            // Validate the user and customer before inserting
            UserValidator userValidator = new UserValidator(new UserDAO());
            userValidator.validateUser(user);
            CustomerValidator customerValidator = new CustomerValidator(new CustomerDAO());
            customerValidator.validateCustomer(customer);

            // Insert the user using the connection-aware DAO method
            UserService userService = new UserService();
            int userId = userService.insertUser(user, connection);  // Overloaded to accept Connection
            user.setUserId(userId);

            // Insert the customer using the connection-aware DAO method
            customer.setUserId(userId);
            CustomerService customerService = new CustomerService();
            String customerId = customerService.insertCustomer(customer, connection);  // Overloaded to accept Connection
            booking.setCustomerId(customerId);

            BookingValidator bookingValidator = new BookingValidator();
            bookingValidator.validateBooking(booking);

            // Insert the booking using the connection-aware method on this instance
            String bookingNumber = this.createBooking(booking, connection);  // Overloaded to accept Connection

            connection.commit(); // Commit the transaction

            EmailSender.sendEmail(user.getEmail(), "Your Mega City Cab Booking Confirmation - #", generateEmailTemplate(booking));
            return bookingNumber;
        } catch (SQLException | ValidationException e) {
            if (connection != null) {
                connection.rollback(); // Roll back on error
            }
            throw e;
        } finally {
            if (connection != null) {
                connection.setAutoCommit(true);
                connection.close();
            }
        }
    }


    public Booking getBookingById(int id) throws SQLException {
        Booking booking = bookingDAO.selectBooking(String.valueOf(id));
        if (booking == null) {
            throw new IllegalArgumentException("Booking not found with ID: " + id);
        }
        return booking;
    }

    public Booking getBookingByNumber(String no) throws ValidationException, SQLException {
        Booking booking = bookingDAO.getBookingByNumber(no);
        if (booking == null) {
            throw new IllegalArgumentException("Booking not found with no: " + no);
        }
        return booking;
    }

    public boolean deleteBooking(int id) throws SQLException {
        Booking existingBooking = getBookingById(id);
        if (existingBooking.getStatusId() != 1) { // Assuming 1 is 'Pending'
            throw new IllegalStateException("Cannot delete booking that is not in Pending status");
        }
        return bookingDAO.deleteBooking(String.valueOf(id));
    }

    public boolean updateBooking(Booking booking) throws SQLException {

//        Booking existingBooking = getBookingById(booking.getBookingId());
//        if (existingBooking.getStatusId() != 1) { // Assuming 1 is 'Pending'
//            throw new IllegalStateException("Cannot update booking that is not in Pending status");
//        }
//
        if (bookingDAO.updateBooking(booking))
        {
            EmailSender.sendEmail(booking.getUser().getEmail(), "Your Mega City Cab Booking Updated - #", generateEmailTemplate(booking));
            return true;
        }
        return false;
    }

    public double calculateTotalFare(double priceForKm, double distance, double taxRate, double discountRate) {
        double subtotal = priceForKm * distance;
        double taxAmount = subtotal * taxRate;
        double discountAmount = subtotal * discountRate;
        return subtotal + taxAmount - discountAmount;
    }

    // Overloaded version using default tax and discount rates
    public double calculateTotalFare(double priceForKm, double distance) {
        return calculateTotalFare(priceForKm, distance, DEFAULT_TAX_RATE, DEFAULT_DISCOUNT_RATE);
    }


    public List<String> getBookingByNumbers() throws SQLException {
        return bookingDAO.fetchAllBookingNumbers();
    }


    private String generateEmailTemplate(Booking booking) {
        CarDAO  carDAO = new CarDAO();
        String carModel = "";
        try {
            Car car = carDAO.getCarById(booking.getCarId());
            carModel = car.getCarModel().getModelName();
        } catch (Exception e) {

        }

        return "<div class='bill-container' style='font-family: Arial, sans-serif; border: 1px solid #ddd; padding: 20px;'>"
                + "<div class='bill-header' style='text-align: center; background-color: #007bff; color: white; padding: 10px;'>"
                + "<h1>MEGA CITY CAB</h1><p>Booking Confirmation</p></div>"
                + "<div class='bill-details' style='margin-top: 20px;'>"
                + "<p><strong>Booking Number:</strong> " + booking.getBookingNumber() + "</p>"
                + "<p><strong>Customer Name:</strong> " + booking.getUser().getFullName() + "</p>"
                + "<p><strong>Destination:</strong> " + booking.getDestination() + "</p>"
                + "<p><strong>Distance:</strong> " + booking.getDistance() + " km</p>"
                + "<p><strong>Driver:</strong> " + booking.getDriver().getDriverName() + "</p>"
                + "<p><strong>Vehicle:</strong> " + carModel + "</p>"
                + "<p><strong>Booking Date:</strong> " + booking.getFormattedDate() + "</p>"
                + "<p><strong>Total:</strong> " + booking.getTotalAmount() + "</p>"
                + "</div><div class='bill-footer' style='text-align: center; margin-top: 20px;'>"
                + "<p>Thank you for choosing Mega City Cab!</p>"
                + "<p>© 2024 Mega City Cab. All Rights Reserved.</p></div></div>";
    }

    public List<Booking> getAssignedBookings(int userId) throws SQLException {
        return bookingDAO.getAssignedBookings(userId);
    }
    public List<Booking> getCustomerRelatedBookings(String customerId) throws SQLException {
        return bookingDAO.getCustomerRelatedBookings(customerId);
    }

}