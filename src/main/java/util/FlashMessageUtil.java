package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class FlashMessageUtil {

    // Store a message with a custom key (e.g., "successMessage" or "errorMessage")
    public static void setFlashMessage(String key, HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute(key, message);
    }

    // Retrieve and remove the message after reading it
    public static String getFlashMessage(String key, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String message = (String) session.getAttribute(key);
        session.removeAttribute(key); // Remove message after reading
        return message;
    }
}
