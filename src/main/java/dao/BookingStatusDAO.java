package dao;

import model.BookingStatus;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static util.DatabaseUtil.getConnection;

public class BookingStatusDAO {

    public BookingStatus selectBookingStatus(int statusId) {
        try {
            Connection connection = getConnection();
            String sql = "SELECT * FROM booking_status WHERE status_id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, statusId);
            ResultSet rs = stmt.executeQuery();

            BookingStatus bookingStatus = new BookingStatus();
            if (rs.next()) {
                bookingStatus.setStatusId(rs.getInt("status_id"));
                bookingStatus.setStatusName(rs.getString("status_name"));
                return bookingStatus;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
