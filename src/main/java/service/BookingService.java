package service;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import dao.BookingDAO;
import model.Booking;

public class BookingService {
    private BookingDAO bookingDAO;

    public BookingService() {
        this.bookingDAO = new BookingDAO();
    }

    public List<Booking> getAllBookings() throws SQLException {
        return bookingDAO.selectAllBookings();
    }

    public int createBooking(Booking booking) throws SQLException {
        validateBooking(booking);
        validateBookingTime(booking.getBookingTime());
        validatePriceAndTime(booking.getPriceForHr(), booking.getTimeHr());
        // Calculate total fare if not provided or to ensure consistency
        double totalFare = booking.getPriceForHr() * booking.getTimeHr();
        booking.setTotalFare(totalFare);
        // Also store total fare in amount column if desired
        booking.setAmount(totalFare);

        // Set default status for new booking (e.g., 1 for 'Pending')
        booking.setStatusId(1);
        booking.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

        return bookingDAO.insertBooking(booking);
    }

    public Booking getBookingById(int id) throws SQLException {
        validateId(id);
        Booking booking = bookingDAO.selectBooking(String.valueOf(id));
        if (booking == null) {
            throw new IllegalArgumentException("Booking not found with ID: " + id);
        }
        return booking;
    }

    public boolean deleteBooking(int id) throws SQLException {
        validateId(id);
        Booking existingBooking = getBookingById(id);
        if (existingBooking.getStatusId() != 1) { // Assuming 1 is 'Pending'
            throw new IllegalStateException("Cannot delete booking that is not in Pending status");
        }
        return bookingDAO.deleteBooking(String.valueOf(id));
    }

    public boolean updateBooking(Booking booking) throws SQLException {
        validateBooking(booking);
        validateId(booking.getBookingId());
        validateBookingTime(booking.getBookingTime());
        validateAmount(booking.getAmount());

        Booking existingBooking = getBookingById(booking.getBookingId());
        if (existingBooking.getStatusId() != 1) { // Assuming 1 is 'Pending'
            throw new IllegalStateException("Cannot update booking that is not in Pending status");
        }

        return bookingDAO.updateBooking(booking);
    }

    private void validateBooking(Booking booking) {
        if (booking == null) {
            throw new IllegalArgumentException("Booking cannot be null.");
        }
        if (booking.getBookingNumber() == null || booking.getBookingNumber().trim().isEmpty()) {
            throw new IllegalArgumentException("Booking Number is required.");
        }
        if (booking.getCustomerId() <= 0) {
            throw new IllegalArgumentException("A valid Customer is required.");
        }
        if (booking.getCarId() == null || booking.getCarId().trim().isEmpty()) {
            throw new IllegalArgumentException("Car ID is required.");
        }
        if (booking.getDestination() == null || booking.getDestination().trim().isEmpty()) {
            throw new IllegalArgumentException("Destination is required.");
        }
    }

    private void validateId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("ID must be positive");
        }
    }

    private void validateBookingTime(Timestamp bookingTime) {
        if (bookingTime == null) {
            throw new IllegalArgumentException("Booking Time cannot be null.");
        }
        if (bookingTime.before(Timestamp.valueOf(LocalDateTime.now()))) {
            throw new IllegalArgumentException("Booking Time cannot be in the past.");
        }
    }

    private void validateAmount(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }
    }

    private void validatePriceAndTime(double priceForHr, int timeHr) {
        if (priceForHr <= 0) {
            throw new IllegalArgumentException("Price per hour must be positive.");
        }
        if (timeHr <= 0) {
            throw new IllegalArgumentException("Time (Hr) must be positive.");
        }
    }


}