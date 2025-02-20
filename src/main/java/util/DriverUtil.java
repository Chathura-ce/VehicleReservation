package util;

public class DriverUtil {

    public static String generateDriverId(int userId) {
        return "d" + String.format("%04d", userId);
    }

}
