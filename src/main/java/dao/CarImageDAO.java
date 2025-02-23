package dao;

import model.CarImage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import util.DatabaseUtil;

public class CarImageDAO {

    public void addCarImage(CarImage carImage) throws SQLException {
        String sql = "INSERT INTO car_image (car_id, image_path) VALUES (?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, carImage.getCarId());
            stmt.setString(2, carImage.getImagePath());
            stmt.executeUpdate();
        }
    }
}
