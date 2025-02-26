package service;

import dao.CarDAO;
import model.Car;
import java.sql.SQLException;
import java.util.List;

public class CarService {
    private CarDAO carDAO;

    public CarService() {
        this.carDAO = new CarDAO();
    }

    public List<Car> selectAllCars() throws SQLException {
        return carDAO.getAllCars();
    }

    public Car selectCar(String id) throws SQLException {
        return carDAO.getCarById(id);
    }

    public void insertCar(Car car) throws SQLException {
        carDAO.addCar(car);
    }

    public void updateCar(Car car) throws SQLException {
        carDAO.updateCar(car);
    }

    public boolean deleteCar(String id) throws SQLException {
        return carDAO.deleteCar(id);
    }

    public List<Car> searchCars(String query) throws SQLException {
        return carDAO.searchCars(query);
    }
}