package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {

    // Generate a random salt
    public static String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16]; // 16-byte salt
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    // Hash password using SHA-256 with salt and multiple iterations
    public static String hashPassword(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256"); // SHA-2 (256-bit)

            // Combine password + salt
            String saltedPassword = password + salt;
            byte[] hashedBytes = md.digest(saltedPassword.getBytes());

            // Perform multiple hashing iterations (1000 rounds)
            for (int i = 0; i < 1000; i++) {
                hashedBytes = md.digest(hashedBytes);
            }

            return Base64.getEncoder().encodeToString(hashedBytes); // Convert hash to Base64 string

        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }
}
