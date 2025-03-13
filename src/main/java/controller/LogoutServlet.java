package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the session
        HttpSession session = request.getSession(false); // Get session if exists, don't create a new one
        if (session != null) {
            session.invalidate(); // Destroy the session
        }

        // Clear the cookies by setting their max age to 0
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName()) ||
                        "userId".equals(cookie.getName()) ||
                        "userRole".equals(cookie.getName())) {

                    cookie.setMaxAge(0);  // This effectively deletes the cookie
                    cookie.setPath("/");  // Must match the path used when creating
                    response.addCookie(cookie);
                }
            }
        }

        response.sendRedirect("/home.jsp"); // Redirect to home page
    }
}
