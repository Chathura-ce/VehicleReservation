package model;

import java.util.Objects;

public class Car {


    private String type;
    private String carId;
    private String model;
    private String regNumber;
    private int seatingCapacity;
    private String available; // Values: "Available", "Booked", "Under Maintenance"
    private String driverId;

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    private String imagePath;

    public Car() {
    }

    public Car(String carId, String model, String type, String regNumber, int seatingCapacity, String available) {
        this.carId = carId;
        this.model = model;
        this.type = type;
        this.regNumber = regNumber;
        this.seatingCapacity = seatingCapacity;
        this.available = available;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getCarModel() {
        return model;
    }

    public void setCarModel(String model) {
        this.model = model;
    }

    public String getRegNumber() {
        return regNumber;
    }

    public void setRegNumber(String regNumber) {
        this.regNumber = regNumber;
    }

    public int getSeatingCapacity() {
        return seatingCapacity;
    }

    public void setSeatingCapacity(int seatingCapacity) {
        this.seatingCapacity = seatingCapacity;
    }

    public String getAvailable() {
        if(Objects.equals(available, "1")){return "Available";}
        return "Booked";

    }
    public String getAvailableId() {
        return available;

    }

    public void setAvailable(String available) {
        this.available = available;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }
    public String getDriverId() {
        return  this.driverId;
    }
}
