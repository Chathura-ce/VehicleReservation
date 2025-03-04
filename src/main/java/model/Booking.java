package model;

import java.sql.Timestamp;

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
    private double priceForHr;
    private double timeHr;
    private double totalFare;
    private User user;
    private Customer customer;
    private Car car;

    public Booking() {
    }

    public Booking(String customerId, String driverId, String carId, String destination,
                   String pickupTime, String dropOffTime,   int statusId,
                   double priceForHr, double timeHr, double totalFare) {
        this.customerId = customerId;
        this.driverId = driverId;
        this.carId = carId;
        this.destination = destination;
        this.pickupTime = pickupTime;
        this.dropOffTime = dropOffTime;
        this.statusId = statusId;
        this.priceForHr = priceForHr;
        this.timeHr = timeHr;
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
        this.destination = pickupLocation;
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

    public double getPriceForHr() {
        return priceForHr;
    }
    public void setPriceForHr(double priceForHr) {
        this.priceForHr = priceForHr;
    }

    public double getTimeHr() {
        return timeHr;
    }
    public void setTimeHr(double timeHr) {
        this.timeHr = timeHr;
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
}
