package util;

public class CustomerUtil {
    public static String generateCustomerNumber(int id) {
        return String.format("CUST%04d", id);
    }
}
