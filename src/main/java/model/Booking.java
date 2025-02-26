package model;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private String bookingNumber; // new
    private int customerId;
    private String driverId;
    private String carId;
    private String destination;
    private Timestamp bookingTime;
    private double amount; // can hold total fare (or be redundant with totalFare)
    private int statusId;
    private Timestamp createdAt;
    private double priceForHr; // new
    private int timeHr;        // new
    private double totalFare;  // new

    public Booking() {
    }

    public Booking(int customerId, String driverId, String carId, String destination,
                   Timestamp bookingTime, double amount, int statusId,
                   double priceForHr, int timeHr, double totalFare) {
        this.customerId = customerId;
        this.driverId = driverId;
        this.carId = carId;
        this.destination = destination;
        this.bookingTime = bookingTime;
        this.amount = amount;
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

    public int getCustomerId() {
        return customerId;
    }
    public void setCustomerId(int customerId) {
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

    public Timestamp getBookingTime() {
        return bookingTime;
    }
    public void setBookingTime(Timestamp bookingTime) {
        this.bookingTime = bookingTime;
    }

    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
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

    public int getTimeHr() {
        return timeHr;
    }
    public void setTimeHr(int timeHr) {
        this.timeHr = timeHr;
    }

    public double getTotalFare() {
        return totalFare;
    }
    public void setTotalFare(double totalFare) {
        this.totalFare = totalFare;
    }
}
