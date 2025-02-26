package dao;

import model.Booking;
import util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    public int insertBooking(Booking booking) throws SQLException {
        String sql = "INSERT INTO bookings (booking_number, customer_id, driver_id, car_id, destination, booking_time, amount, status_id, price_for_hr, time_hr, total_fare, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, booking.getBookingNumber());
            stmt.setInt(2, booking.getCustomerId());
            stmt.setObject(3, booking.getDriverId());
            stmt.setString(4, booking.getCarId());
            stmt.setString(5, booking.getDestination());
            stmt.setTimestamp(6, booking.getBookingTime());
            stmt.setDouble(7, booking.getTotalFare()); // we can store total fare in amount
            stmt.setInt(8, booking.getStatusId());
            stmt.setDouble(9, booking.getPriceForHr());
            stmt.setInt(10, booking.getTimeHr());
            stmt.setDouble(11, booking.getTotalFare());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    public Booking selectBooking(String id) throws SQLException {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractBookingFromResultSet(rs);
            }
        }
        return null;
    }

    public List<Booking> selectAllBookings() throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY booking_time DESC";

        try (Connection connection = DatabaseUtil.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        }
        return bookings;
    }

    public boolean updateBooking(Booking booking) throws SQLException {
        String sql = "UPDATE bookings SET booking_number = ?, customer_id = ?, driver_id = ?, car_id = ?, destination = ?, booking_time = ?, amount = ?, status_id = ?, price_for_hr = ?, time_hr = ?, total_fare = ? " +
                "WHERE booking_id = ?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, booking.getBookingNumber());
            stmt.setInt(2, booking.getCustomerId());
            stmt.setObject(3, booking.getDriverId());
            stmt.setString(4, booking.getCarId());
            stmt.setString(5, booking.getDestination());
            stmt.setTimestamp(6, booking.getBookingTime());
            stmt.setDouble(7, booking.getTotalFare());
            stmt.setInt(8, booking.getStatusId());
            stmt.setDouble(9, booking.getPriceForHr());
            stmt.setInt(10, booking.getTimeHr());
            stmt.setDouble(11, booking.getTotalFare());
            stmt.setInt(12, booking.getBookingId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteBooking(String id) throws SQLException {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(id));
            return stmt.executeUpdate() > 0;
        }
    }

    private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setBookingNumber(rs.getString("booking_number"));
        booking.setCustomerId(rs.getInt("customer_id"));
        booking.setDriverId(rs.getString("driver_id"));
        booking.setCarId(rs.getString("car_id"));
        booking.setDestination(rs.getString("destination"));
        booking.setBookingTime(rs.getTimestamp("booking_time"));
        booking.setAmount(rs.getDouble("amount"));
        booking.setStatusId(rs.getInt("status_id"));
        booking.setPriceForHr(rs.getDouble("price_for_hr"));
        booking.setTimeHr(rs.getInt("time_hr"));
        booking.setTotalFare(rs.getDouble("total_fare"));
        booking.setCreatedAt(rs.getTimestamp("created_at"));
        return booking;
    }
}
