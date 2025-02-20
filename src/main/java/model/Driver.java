package model;

public class Driver {

    private int userId;
    private String driverId;
    private String licenseNumber;


    public Driver(int userId, String driverId, String licenseNumber) {
        this.licenseNumber = licenseNumber;
        this.userId = userId;
        this.driverId = driverId;
    }

    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

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
}
