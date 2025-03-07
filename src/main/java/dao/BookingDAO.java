package dao;

import model.*;
import model.Driver;
import util.BookingUtil;
import util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static util.DatabaseUtil.getConnection;

public class BookingDAO {
    public String insertBooking(Booking booking,Connection connection) throws SQLException {
        String sql = "INSERT INTO bookings (booking_number, customer_id, driver_id, car_id, destination, status_id, price_for_km, distance, total_fare, created_at,pickup_location) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,  CURRENT_TIMESTAMP,?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            String bookingId = BookingUtil.generateBookingId(connection);
            stmt.setString(1, bookingId);
            stmt.setString(2, booking.getCustomerId());
            stmt.setObject(3, booking.getDriverId());
            stmt.setString(4, booking.getCarId());
            stmt.setString(5, booking.getDestination());
//            stmt.setString(6, booking.getPickupTime());
//            stmt.setString(7, booking.getDropOffTime());
            stmt.setInt(6, booking.getStatusId());
            stmt.setDouble(7, booking.getPriceForKm());
            stmt.setDouble(8, booking.getDistance());
            stmt.setDouble(9, booking.getTotalFare());
            stmt.setString(10, booking.getPickupLocation());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return bookingId;
            }
        }
        return "";
    }

    public Booking selectBooking(String id) throws SQLException {
//        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        String sql = "SELECT bookings.booking_id, bookings.booking_number, bookings.customer_id, bookings.driver_id, bookings.car_id," +
                "  pickup_location, bookings.destination,  bookings.status_id, bookings.price_for_km, bookings.distance, bookings.total_fare," +
                " bookings.created_at, users.full_name, users.nic, customers.address, users.email, users.phone,car_types.type_id, car_types.type_name, car_models.model_name," +
                " cars.capacity, cars.driver_id FROM bookings LEFT JOIN customers ON bookings.customer_id = customers.customer_number " +
                " LEFT JOIN users ON customers.user_id = users.user_id LEFT JOIN cars ON bookings.car_id = cars.car_id " +
                "LEFT JOIN car_models ON cars.model = car_models.model_id left JOIN car_types ON car_types.type_id = cars.type" +
                " WHERE booking_number = ? ";
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
        String sql = "SELECT bookings.booking_id, bookings.booking_number, bookings.customer_id, bookings.driver_id, bookings.car_id," +
                " pickup_location, bookings.destination,  bookings.status_id, bookings.price_for_km, bookings.distance, bookings.total_fare," +
                " bookings.created_at, users.full_name, users.nic, customers.address, users.email, users.phone,car_types.type_id, car_types.type_name, car_models.model_id,car_models.model_name," +
                " cars.capacity, cars.driver_id,du.full_name as driver_name " +
                "FROM bookings LEFT JOIN customers ON bookings.customer_id = customers.customer_number " +
                " LEFT JOIN users ON customers.user_id = users.user_id LEFT JOIN cars ON bookings.car_id = cars.car_id " +
                " LEFT JOIN car_models ON cars.model = car_models.model_id left JOIN car_types ON car_types.type_id = cars.type" +
                " LEFT JOIN drivers AS d ON bookings.driver_id = d.driver_id " +
                " LEFT JOIN users AS du ON d.user_id = du.user_id "+
                " WHERE booking_number = ? ";
//        System.out.println(sql);
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
//            System.out.println(sql);
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
        String sql = "SELECT bookings.booking_id, bookings.booking_number, bookings.customer_id, bookings.driver_id, bookings.car_id," +
                " pickup_location, bookings.destination,  bookings.status_id, bookings.price_for_km, bookings.distance, bookings.total_fare," +
                " bookings.created_at, users.full_name, users.nic, customers.address, users.email, users.phone,car_types.type_id, car_types.type_name, car_models.model_id,car_models.model_name," +
                " cars.capacity, cars.driver_id,du.full_name as driver_name " +
                "FROM bookings LEFT JOIN customers ON bookings.customer_id = customers.customer_number " +
                " LEFT JOIN users ON customers.user_id = users.user_id LEFT JOIN cars ON bookings.car_id = cars.car_id " +
                " LEFT JOIN car_models ON cars.model = car_models.model_id left JOIN car_types ON car_types.type_id = cars.type" +
                " LEFT JOIN drivers AS d ON bookings.driver_id = d.driver_id " +
                " LEFT JOIN users AS du ON d.user_id = du.user_id ORDER BY bookings.booking_id DESC " ;

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
        String sql = "UPDATE bookings SET customer_id = ?, driver_id = ?, car_id = ?, destination = ?,  status_id = ?, price_for_km = ?, distance = ?, total_fare = ? , pickup_location = ?" +
                "WHERE booking_number = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, booking.getCustomerId());
            stmt.setObject(2, booking.getDriverId());
            stmt.setString(3, booking.getCarId());
            stmt.setString(4, booking.getDestination());
            stmt.setInt(5, booking.getStatusId());
            stmt.setDouble(6, booking.getPriceForKm());
            stmt.setDouble(7, booking.getDistance());
            stmt.setDouble(8, booking.getTotalFare());
            stmt.setString(9, booking.getPickupLocation());
            stmt.setString(10, booking.getBookingNumber());
//            stmt.setString(5, booking.getPickupTime());

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
        booking.setCustomerId(rs.getString("customer_id"));
        booking.setDriverId(rs.getString("driver_id"));
        booking.setCarId(rs.getString("car_id"));
        booking.setPickupLocation(rs.getString("pickup_location"));
        booking.setDestination(rs.getString("destination"));
//        booking.setPickupTime(rs.getString("pickup_time"));
//        booking.setDropOffTime(rs.getString("dropoff_time"));
        booking.setStatusId(rs.getInt("status_id"));
        booking.setPriceForKm(rs.getDouble("price_for_km"));
        booking.setDistance(rs.getInt("distance"));
        booking.setTotalFare(rs.getDouble("total_fare"));
        booking.setCreatedAt(rs.getTimestamp("created_at"));
        booking.setFormattedDate(rs.getTimestamp("created_at"));

        User user = new User();
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setNic(rs.getString("nic"));

        Customer customer = new Customer();
        customer.setAddress(rs.getString("address"));

        Car car = new Car();
        CarType carType = new CarType(rs.getInt("type_id"),rs.getString("type_name"));
        car.setType(carType);

        CarModel carModel = new CarModel(rs.getInt("model_id"),rs.getString("model_name"),rs.getInt("type_id"));
        car.setModel(carModel);

        Driver driver = new Driver();
        driver.setDriverName(rs.getString("driver_name"));

        car.setSeatingCapacity(rs.getInt("capacity"));

        booking.setUser(user);
        booking.setCustomer(customer);
        booking.setCar(car);
        booking.setDriver(driver);

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
