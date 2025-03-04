package model;

import java.util.Objects;

public class Car {


    private CarType type;
    private String carId;
    private CarModel model;
    private String regNumber;
    private int seatingCapacity;
    private String available; // Values: "Available", "Booked", "Under Maintenance"
    private String driverId;
    private Driver driver;
    public Car() {
    }
    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public CarModel getModel() {
        return model;
    }

    public void setModel(CarModel model) {
        this.model = model;
    }

    public void setDriver(Driver driver) {
        this.driver = driver;
    }
    public Driver getDriver() {return driver;}

    private String imagePath;



    public Car(String carId, CarModel model, CarType type, String regNumber, int seatingCapacity, String available) {
        this.carId = carId;
        this.model = model;
        this.type = type;
        this.regNumber = regNumber;
        this.seatingCapacity = seatingCapacity;
        this.available = available;
    }

    public CarType getType() {
        return type;
    }

    public void setType(CarType type) {
        this.type = type;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public CarModel getCarModel() {
        return model;
    }

    public void setCarModel(CarModel model) {
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
