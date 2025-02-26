package dao;

import model.CarModel;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarModelDAO {

    // Fetch car models by car type (using type_id)
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
