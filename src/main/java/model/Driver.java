package model;

import java.time.LocalDateTime;

public class Driver {

    private int userId;
    private String driverId;
    private String licenseNumber;
//    private String fullName;
//    private String phone;
//    private String status;
    private User user;
    private String driverName;

    public Driver(int userId, String driverId, String licenseNumber) {
        this.licenseNumber = licenseNumber;
        this.userId = userId;
        this.driverId = driverId;
    }

    public Driver() {

    }


    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }
    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getDriverName() {return driverName;}

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }
}
