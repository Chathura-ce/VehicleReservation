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
            User user = userDAO.authenticate(username, password);

            if (user != null) {
                // Store the user in the session
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                session.setAttribute("userId", user.getUserId());

                // Role-based redirection
                switch (user.getRole()) {
                    case "admin":  // Admin role
                        response.sendRedirect("index.jsp");
                        break;
                    case "customer":  // Customer role
                        response.sendRedirect("home.jsp");
                        break;
                    case "driver":  // Driver role
                        response.sendRedirect("index.jsp");
                        break;
                    default:  // Default path if no role matches
//                        response.sendRedirect("error.jsp");
                        // Invalid login
                        request.setAttribute("errorMessage", "Invalid user credentials");
                        request.getRequestDispatcher("/login.jsp").forward(request, response);
                        break;
                }
            } else {
                // Invalid login
                request.setAttribute("username", username);
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("error.jsp");
            // Invalid login
            request.setAttribute("username", username);
            request.setAttribute("errorMessage", "Internal server error. Please try again later.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
