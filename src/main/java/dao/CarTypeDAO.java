package dao;

import model.CarType;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarTypeDAO {

    public List<CarType> getAllCarTypes() throws SQLException {
        List<CarType> carTypes = new ArrayList<>();
        String sql = "SELECT type_id, type_name FROM car_types";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                CarType ct = new CarType();
                ct.setTypeId(rs.getInt("type_id"));
                ct.setTypeName(rs.getString("type_name"));
                carTypes.add(ct);
            }
        }
        return carTypes;
    }
}
