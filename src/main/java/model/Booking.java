package model;

import util.PricingConfig;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class Booking {
    private int bookingId;
    private String bookingNumber;
    private String customerId;
    private String driverId;
    private String carId;
    private String pickupLocation;
    private String destination;
    private String pickupTime;
    private String dropOffTime;
    private int statusId;
    private Timestamp createdAt;
    private double priceForKm;
    private double distance;
    private double totalFare;
    private User user;
    private Customer customer;
    private Driver driver;
    private String formattedDate;
    private Car car;
    private String pickupDate;

    public Booking() {
    }

    public Booking(String customerId, String driverId, String carId, String destination,
                   String pickupTime, String dropOffTime, int statusId,
                   double priceForKm, double distance, double totalFare) {
        this.customerId = customerId;
        this.driverId = driverId;
        this.carId = carId;
        this.destination = destination;
        this.pickupTime = pickupTime;
        this.dropOffTime = dropOffTime;
        this.statusId = statusId;
        this.priceForKm = priceForKm;
        this.distance = distance;
        this.totalFare = totalFare;
    }

    // Getters and Setters

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getBookingNumber() {
        return bookingNumber;
    }

    public void setBookingNumber(String bookingNumber) {
        this.bookingNumber = bookingNumber;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getPickupTime() {
        return pickupTime;
    }

    public void setPickupTime(String pickupTime) {
        this.pickupTime = pickupTime;
    }

    public String getDropOffTime() {
        return dropOffTime;
    }

    public void setDropOffTime(String dropOffTime) {
        this.dropOffTime = dropOffTime;
    }


    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public double getPriceForKm() {
        return priceForKm;
    }

    public void setPriceForKm(double priceForKm) {
        this.priceForKm = priceForKm;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }

    public double getTotalFare() {
        return totalFare;
    }

    public void setTotalFare(double totalFare) {
        this.totalFare = totalFare;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public Car getCar() {
        return car;
    }

    public User getUser() {
        return user;
    }

    public Customer getCustomer() {
        return customer;
    }

    public Driver getDriver() {
        return driver;
    }

    public void setDriver(Driver driver) {
        this.driver = driver;
    }

    public void setFormattedDate(Timestamp timestamp) {
        if (timestamp != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("MMMM d, yyyy | hh:mm a");
            this.formattedDate = sdf.format(timestamp);
        } else {
            this.formattedDate = "";
        }

    }

    public String getFormattedDate() {
        return formattedDate;
    }

    public double calculateTax() {
        double tax = (PricingConfig.TAX_PERCENTAGE / 100) * (distance * priceForKm);  // tax based on subtotal
        return Math.round(tax * 10.0) / 10.0;  // Rounds to one decimal place
    }

    public double calculateTotalAmount() {
        return (distance * priceForKm) + calculateTax();  // total includes subtotal + tax
    }

    public double getTotalAmount() {
        return calculateTotalAmount();  // get total amount when needed
    }

    public void setPickupDate(String pickupDate) {
        this.pickupDate = pickupDate;
    }

    public String getPickupDate() {
        return pickupDate;
    }

    public String getStatusLabel() {
        switch (statusId) {
            case 1:
                return "Pending";
            case 2:
                return "Approved";
            case 3:
                return "Cancelled";
            default:
                return "";
        }
    }

    public String getFormattedTime() {
        try {
            // Parse the input time
            LocalTime time = LocalTime.parse(pickupTime);

            // Format to desired output
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("h:mm a");
            String formattedTime = time.format(formatter);
            return formattedTime;
        } catch (Exception e) {
            return "00:00:00";
        }
    }
}
