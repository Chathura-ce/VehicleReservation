package dao;

import model.Car;
import model.Driver;
import model.CarModel;
import model.CarType;
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
            stmt.setInt(2, car.getCarModel().getModelId());
            stmt.setInt(3, car.getSeatingCapacity());
            stmt.setInt(4, car.getType().getTypeId());
            stmt.setString(5, car.getRegNumber());
            stmt.setInt(6, car.getAvailable());
            stmt.setString(7, car.getDriverId());
            stmt.executeUpdate();
        }
    }

    public List<Car> getAllCars() throws SQLException {
        List<Car> carList = new ArrayList<>();
        String sql = "SELECT\n" +
                "cars.id,\n" +
                "cars.car_id,\n" +
                "cars.model,\n" +
                "cars.type,\n" +
                "cars.reg_number,\n" +
                "cars.capacity,\n" +
                "cars.available,\n" +
                "cars.driver_id,\n" +
                "cars.image_path,\n" +
                "car_types.type_name,\n" +
                "car_models.model_name,\n" +
                "car_models.model_id,\n" +
                "car_models.type_id\n" +
                "FROM\n" +
                "cars\n" +
                "INNER JOIN car_types ON cars.type = car_types.type_id\n" +
                "INNER JOIN car_models ON car_models.type_id = car_types.type_id AND cars.model = car_models.model_id\n";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getString("car_id"));

                CarType carType = new CarType(rs.getInt("type"),rs.getString("type_name"));
                car.setType(carType);

                CarModel carModel = new CarModel(rs.getInt("model_id"),rs.getString("model_name"),rs.getInt("type_id"));
                car.setModel(carModel);

                car.setRegNumber(rs.getString("reg_number"));
                car.setSeatingCapacity(rs.getInt("capacity"));
                car.setAvailable(rs.getInt("available"));
                carList.add(car);
            }
        }
        return carList;
    }

    public Car getCarById(String carId) throws SQLException {
        String sql = "SELECT\n" +
                "cars.id,\n" +
                "cars.car_id,\n" +
                "cars.model,\n" +
                "cars.type,\n" +
                "cars.reg_number,\n" +
                "cars.capacity,\n" +
                "cars.available,\n" +
                "cars.driver_id,\n" +
                "cars.image_path,\n" +
                "car_types.type_name,\n" +
                "car_models.model_name,\n" +
                "car_models.model_id,\n" +
                "car_models.type_id\n" +
                "FROM\n" +
                "cars\n" +
                "INNER JOIN car_types ON cars.type = car_types.type_id\n" +
                "INNER JOIN car_models ON car_models.type_id = car_types.type_id AND cars.model = car_models.model_id WHERE car_id=? \n";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, carId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getString("car_id"));
                car.setDriverId(rs.getString("driver_id"));

                CarType carType = new CarType(rs.getInt("type"),rs.getString("type_name"));
                car.setType(carType);

                CarModel carModel = new CarModel(rs.getInt("model_id"),rs.getString("model_name"),rs.getInt("type_id"));
                car.setModel(carModel);

                car.setRegNumber(rs.getString("reg_number"));
                car.setSeatingCapacity(rs.getInt("capacity"));
                car.setAvailable(rs.getInt("available"));
                return car;
            }
        }
        return null;
    }

    public void updateCar(Car car) throws SQLException {
        String sql = "UPDATE cars SET model = ?, type = ?, reg_number = ?,capacity= ? , available = ?, driver_id = ? WHERE car_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, car.getModel().getModelId());
            stmt.setInt(2, car.getType().getTypeId());
            stmt.setString(3, car.getRegNumber());
            stmt.setInt(4, car.getSeatingCapacity());
            stmt.setInt(5, car.getAvailable());
            stmt.setString(6, car.getDriverId());
            stmt.setString(7, car.getCarId());
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

    public List<Car> searchCars(String query) throws SQLException {
        List<Car> cars = new ArrayList<>();
        String sql = "SELECT\n" +
                "cars.id,\n" +
                "cars.car_id,\n" +
                "cars.model,\n" +
                "cars.type,\n" +
                "cars.reg_number,\n" +
                "cars.capacity,\n" +
                "cars.available,\n" +
                "cars.driver_id,\n" +
                "cars.image_path,\n" +
                "car_types.type_name,\n" +
                "car_models.model_name,\n" +
                "car_models.model_id,\n" +
                "car_models.type_id,\n" +
                "users.username as driver_name\n" +
                "FROM\n" +
                "cars\n" +
                "INNER JOIN car_types ON cars.type = car_types.type_id\n" +
                "INNER JOIN car_models ON car_models.type_id = car_types.type_id AND cars.model = car_models.model_id\n" +
                "INNER JOIN drivers ON cars.driver_id = drivers.driver_id\n" +
                "INNER JOIN users ON drivers.user_id = users.user_id\n" +
                "WHERE  car_id LIKE ? OR reg_number LIKE ? OR model LIKE ? OR car_id LIKE ? OR type LIKE ?\n";
//        System.out.println(sql);
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            stmt.setString(4, searchTerm);
            stmt.setString(5, searchTerm);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {

                    Car car = new Car();
                    car.setCarId(rs.getString("car_id"));

                    Driver driver = new Driver();
                    driver.setDriverId(rs.getString("driver_id"));
                    driver.setDriverName(rs.getString("driver_name"));

                    CarType carType = new CarType(rs.getInt("type"),rs.getString("type_name"));

                    CarModel carModel = new CarModel(rs.getInt("model_id"),rs.getString("model_name"),rs.getInt("type_id"));

                    car.setType(carType);
                    car.setModel(carModel);
                    car.setDriver(driver);

                    car.setRegNumber(rs.getString("reg_number"));
                    car.setSeatingCapacity(rs.getInt("capacity"));
                    car.setAvailable(rs.getInt("available"));
                    cars.add(car);
                }
            }
        }
        return cars;
    }

    public List<CarModel> getCarModelsByTypeId(int typeId) throws SQLException {
        List<CarModel> models = new ArrayList<>();
        String sql = "SELECT model_id, model_name, type_id FROM car_models WHERE type_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, typeId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CarModel model = new CarModel();
                    model.setModelId(rs.getInt("model_id"));
                    model.setModelName(rs.getString("model_name"));
                    model.setTypeId(rs.getInt("type_id"));
                    models.add(model);
                }
            }
        }
        return models;
    }
}
