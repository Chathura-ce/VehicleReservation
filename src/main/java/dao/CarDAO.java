package dao;

import model.Car;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarDAO {

    public void addCar(Car car) throws SQLException {
        String sql = "INSERT INTO cars (car_id,model, capacity,type, reg_number,available,driver_id) VALUES (?, ?, ?, ?,?,?,?)";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, car.getCarId());
            stmt.setString(2, car.getCarModel());
            stmt.setInt(3, car.getSeatingCapacity());
            stmt.setString(4, car.getType());
            stmt.setString(5, car.getRegNumber());
            stmt.setString(6, car.getAvailable());
            stmt.setString(7, car.getDriverId());
            stmt.executeUpdate();
        }
    }

    public List<Car> getAllCars() throws SQLException {
        List<Car> carList = new ArrayList<>();
        String sql = "SELECT * FROM cars";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getString("car_id"));
                car.setType(rs.getString("type"));
                car.setCarModel(rs.getString("model"));
                car.setRegNumber(rs.getString("reg_number"));
                car.setSeatingCapacity(rs.getInt("capacity"));
                car.setAvailable(rs.getString("available"));
                carList.add(car);
            }
        }
        return carList;
    }

    public Car getCarById(String carId) throws SQLException {
        String sql = "SELECT * FROM cars WHERE car_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, carId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getString("car_id"));
                car.setType(rs.getString("type"));
                car.setCarModel(rs.getString("model"));
                car.setRegNumber(rs.getString("reg_number"));
                car.setSeatingCapacity(rs.getInt("capacity"));
                car.setAvailable(rs.getString("available"));
                car.setDriverId(rs.getString("driver_id"));
                return car;
            }
        }
        return null;
    }

    public void updateCar(Car car) throws SQLException {
        String sql = "UPDATE cars SET model = ?, type = ?, reg_number = ?,capacity= ? , available = ? WHERE car_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, car.getModel());
            stmt.setString(2, car.getType());
            stmt.setString(3, car.getRegNumber());
            stmt.setInt(4, car.getSeatingCapacity());
            stmt.setString(5, car.getAvailableId());
            stmt.setString(6, car.getCarId());
            stmt.executeUpdate();
        }
    }

    public int getNextCarId() {
        String sql = "SELECT (COALESCE(MAX(id),0)+1) as maxId FROM cars ";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("maxId");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public boolean isCarIdExists(String carId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM cars WHERE car_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, carId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCar(String carId) {
        String sql = "DELETE FROM cars WHERE car_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, carId);
            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0; // Returns true if at least one row was deleted
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
