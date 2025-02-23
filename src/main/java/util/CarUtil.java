package util;

import dao.CarDAO;

public class CarUtil {

    public static String generateCarId() {
        CarDAO car = new CarDAO();
        int nextCarId = car.getNextCarId();
        return "C" + String.format("%04d", nextCarId);
    }


}
