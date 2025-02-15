package controller;


import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

//@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username is required.");
            request.setAttribute("password", password);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Password is required.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            // Authenticate the user
            UserDAO userDAO = new UserDAO();
            String passwordHash = password;  // Placeholder: Add password hashing here
            User user = userDAO.authenticate(username, passwordHash);

            if (user != null) {
                // Store the user in the session
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);

                // Role-based redirection
                switch (user.getRoleId()) {
                    case 1:  // Admin role
                        response.sendRedirect("index.jsp");
                        break;
                    case 2:  // Customer role
                        response.sendRedirect("home.jsp");
                        break;
                    case 3:  // Driver role
                        response.sendRedirect("driver-dashboard.jsp");
                        break;
                    default:  // Default path if no role matches
                        response.sendRedirect("error.jsp");
                        break;
                }
            } else {
                // Invalid login
                request.setAttribute("username", username);
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
