package util;

import dao.BookingDAO;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BookingUtil {
    public static String generateBookingId(Connection conn) {
        BookingDAO bookingDAO = new BookingDAO();
        int maxBookingId = bookingDAO.getMaxBookingId(conn) + 1;

        String datePart = new SimpleDateFormat("yyyyMMdd").format(new Date());

        return "BK" + datePart + "-" + String.format("%04d", maxBookingId);
    }
}

