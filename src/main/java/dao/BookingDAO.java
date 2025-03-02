package dao;

import model.Booking;
import util.BookingUtil;
import util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static util.DatabaseUtil.getConnection;

public class BookingDAO {
    public String insertBooking(Booking booking,Connection connection) throws SQLException {
        String sql = "INSERT INTO bookings (booking_number, customer_id, driver_id, car_id, destination, pickup_time,dropoff_time, status_id, price_for_hr, time_hr, total_fare, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, CURRENT_TIMESTAMP)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            String bookingId = BookingUtil.generateBookingId(connection);
            stmt.setString(1, bookingId);
            stmt.setInt(2, booking.getCustomerId());
            stmt.setObject(3, booking.getDriverId());
            stmt.setString(4, booking.getCarId());
            stmt.setString(5, booking.getDestination());
            stmt.setTimestamp(6, booking.getPickupTime());
            stmt.setTimestamp(7, booking.getDropOffTime());
            stmt.setInt(8, booking.getStatusId());
            stmt.setDouble(9, booking.getPriceForHr());
            stmt.setDouble(10, booking.getTimeHr());
            stmt.setDouble(11, booking.getTotalFare());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return bookingId;
            }
        }
        return "";
    }

    public Booking selectBooking(String id) throws SQLException {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractBookingFromResultSet(rs);
            }
        }
        return null;
    }
    public Booking getBookingByNumber(String no) throws SQLException {
        String sql = "SELECT * FROM bookings WHERE booking_number = ?";
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, no);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractBookingFromResultSet(rs);
            }
        }
        return null;
    }

    public List<Booking> selectAllBookings() throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY pickup_time DESC";

        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        }
        return bookings;
    }

    public boolean updateBooking(Booking booking) throws SQLException {
        String sql = "UPDATE bookings SET booking_number = ?, customer_id = ?, driver_id = ?, car_id = ?, destination = ?, pickup_time = ?,  status_id = ?, price_for_hr = ?, time_hr = ?, total_fare = ?,dropoff_time=? " +
                "WHERE booking_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, booking.getBookingNumber());
            stmt.setInt(2, booking.getCustomerId());
            stmt.setObject(3, booking.getDriverId());
            stmt.setString(4, booking.getCarId());
            stmt.setString(5, booking.getDestination());
            stmt.setTimestamp(6, booking.getPickupTime());
            stmt.setInt(7, booking.getStatusId());
            stmt.setDouble(8, booking.getPriceForHr());
            stmt.setDouble(9, booking.getTimeHr());
            stmt.setDouble(10, booking.getTotalFare());
            stmt.setInt(11, booking.getBookingId());
            stmt.setTimestamp(12, booking.getDropOffTime());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteBooking(String id) throws SQLException {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";

        try (Connection connection = getConnection();
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
        booking.setPickupTime(rs.getTimestamp("pickup_time"));
        booking.setStatusId(rs.getInt("status_id"));
        booking.setPriceForHr(rs.getDouble("price_for_hr"));
        booking.setTimeHr(rs.getInt("time_hr"));
        booking.setTotalFare(rs.getDouble("total_fare"));
        booking.setCreatedAt(rs.getTimestamp("created_at"));
        return booking;
    }

    public int getMaxBookingId(Connection conn) {
        String sql = "SELECT COALESCE(MAX(booking_id), 0) FROM bookings";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0; // Start from 0 if no bookings exist
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<String> fetchAllBookingNumbers() throws SQLException {
        List<String> bookingNumbers = new ArrayList<>();
        String sql = "SELECT booking_number FROM bookings";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                bookingNumbers.add(rs.getString("booking_number"));
            }
        }
        return bookingNumbers;
    }

}
