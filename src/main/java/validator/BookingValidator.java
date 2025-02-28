package validator;

import exception.ValidationException;
import model.Booking;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class BookingValidator {
    public void validateBooking(Booking booking) throws ValidationException {
        if (booking == null) {
            throw new ValidationException("Booking cannot be null.");
        }
        if (booking.getBookingNumber() == null || booking.getBookingNumber().trim().isEmpty()) {
            throw new ValidationException("Booking Number is required.");
        }
        if (booking.getCustomerId() <= 0) {
            throw new ValidationException("A valid Customer is required.");
        }
        if (booking.getCarId() == null || booking.getCarId().trim().isEmpty()) {
            throw new ValidationException("Car ID is required.");
        }
        if (booking.getDestination() == null || booking.getDestination().trim().isEmpty()) {
            throw new ValidationException("Destination is required.");
        }
        if (booking.getPickupTime() == null) {
            throw new ValidationException("Pickup Time cannot be null.");
        }
        if (booking.getPickupTime().before(Timestamp.valueOf(LocalDateTime.now()))) {
            throw new ValidationException("Pickup Time cannot be in the past.");
        }
        if (booking.getDropOffTime() == null) {
            throw new ValidationException("Drop off Time cannot be null.");
        }
        if (booking.getDropOffTime().before(Timestamp.valueOf(LocalDateTime.now()))) {
            throw new ValidationException("Drop off Time cannot be in the past.");
        }

    }
}
