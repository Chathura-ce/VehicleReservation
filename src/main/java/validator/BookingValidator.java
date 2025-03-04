package validator;

import exception.ValidationException;
import model.Booking;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class BookingValidator {
    // DateTime format for the input strings
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public void validateBooking(Booking booking) throws ValidationException {
        if (booking == null) {
//            throw new ValidationException("Booking cannot be null.");
            throw new ValidationException("There was a internal error. Please try again.");
        }
        /*if (booking.getBookingNumber() == null || booking.getBookingNumber().trim().isEmpty()) {
            throw new ValidationException("Booking Number is required.");
        }*/
        if (booking.getCustomerId() == null || booking.getCustomerId().trim().isEmpty()) {
            throw new ValidationException("A valid Customer is required.");
        }
        if (booking.getCarId() == null || booking.getCarId().trim().isEmpty()) {
            throw new ValidationException("Car ID is required.");
        }
        if (booking.getDestination() == null || booking.getDestination().trim().isEmpty()) {
            throw new ValidationException("Destination is required.");
        }
        if (booking.getDistance() == 0 || booking.getDestination().trim().isEmpty()) {
            throw new ValidationException("Distance is required.");
        }
        /*if (booking.getPickupTime() == null || booking.getPickupTime().trim().isEmpty()) {
            throw new ValidationException("Pickup Time cannot be empty.");
        }
        LocalDateTime pickupTime = LocalDateTime.parse(booking.getPickupTime(), DATE_TIME_FORMATTER);
        if (pickupTime.isBefore(LocalDateTime.now())) {
            throw new ValidationException("Pickup Time cannot be in the past.");
        }
        if (booking.getDropOffTime() == null || booking.getDropOffTime().trim().isEmpty()) {
            throw new ValidationException("Drop off Time cannot be empty.");
        }
        LocalDateTime dropOffTime = LocalDateTime.parse(booking.getDropOffTime(), DATE_TIME_FORMATTER);
        if (dropOffTime.isBefore(LocalDateTime.now())) {
            throw new ValidationException("Drop off Time cannot be in the past.");
        }*/
    }

    // Helper method to validate the format of the date time string
    private boolean isValidDateTime(String dateTime) {
        try {
            LocalDateTime.parse(dateTime, DATE_TIME_FORMATTER);
            return true; // Return true if parsing succeeds
        } catch (Exception e) {
            return false; // Return false if parsing fails
        }
    }
}
