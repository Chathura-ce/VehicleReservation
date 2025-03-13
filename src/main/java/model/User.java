package model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class User {
    private int userId;
    private String username;
    private String password;
    private String nic;
    private String fullName;
    private String email;
    private String role;
    private String phone;
    private int status;
    private String createdAt;

    public String getCreatedAt() {
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            // or whatever format your createdAt string is in

            Date date = inputFormat.parse(createdAt);

            // Then format to the desired pattern "d MMM. yyyy"
            SimpleDateFormat outputFormat = new SimpleDateFormat("d MMM. yyyy", Locale.ENGLISH);

            return outputFormat.format(date);
        } catch (Exception e) {
            // Handle parsing error
            return ""; // Return original if parsing fails
        }
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }



    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getStatus() {
        return status == 1 ? "Active" : "Inactive";
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }
}
