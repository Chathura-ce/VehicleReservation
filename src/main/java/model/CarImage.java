package model;

public class CarImage {
    private String carId;

    public CarImage(String carId, String imagePath) {
        this.carId = carId;
        this.imagePath = imagePath;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    private String imagePath;

}
