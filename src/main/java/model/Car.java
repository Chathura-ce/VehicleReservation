package model;

import java.util.Objects;

public class Car {


    private CarType type;
    private String carId;
    private CarModel model;
    private String regNumber;
    private int seatingCapacity;
    private double priceForKm;
    private int available;
    private String driverId;
    private Driver driver;

    public double getPriceForKm() {
        return priceForKm;
    }

    public void setPriceForKm(double priceForKm) {
        this.priceForKm = priceForKm;
    }


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



    public Car(String carId, CarModel model, CarType type, String regNumber, int seatingCapacity, int available) {
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

    public int getAvailable() {
        return available;
    }
    public String getAvailableStr() {
        if(Objects.equals(available, "1")){return "Available";}
        return "Booked";
    }
    public int getAvailableId() {
        return available;

    }

    public void setAvailable(int available) {
        this.available = available;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }
    public String getDriverId() {
        return  this.driverId;
    }
}
