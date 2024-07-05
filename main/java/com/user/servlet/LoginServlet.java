package com.user.servlet;

import java.io.IOException;
import java.util.Objects;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.entity.User;
import com.DAO.UserDAO;
import com.DAO.UserDAOImpl;
import com.DB.DBConnect;

import jakarta.servlet.annotation.WebServlet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Check if admin credentials
            if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
                User adminUser = new User();
                adminUser.setName("Admin");
                HttpSession session = request.getSession();
                session.setAttribute("user", adminUser);
                session.setAttribute("successMsg", "Login successful!");
                response.sendRedirect("admin/home.jsp");
                return;
            }

            UserDAO userDao = new UserDAOImpl(DBConnect.getConn());
            User user = userDao.authenticateUser(email, password);
            HttpSession session = request.getSession();

            if (user != null) {
                session.setAttribute("user", user);
                session.setAttribute("successMsg", "Login successful!");
                session.removeAttribute("failedMsg");
                response.sendRedirect("index.jsp");
            } else {
                session.setAttribute("failedMsg", "Invalid email or password. Please try again.");
                session.removeAttribute("successMsg");
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Internal server error. Please try again later.");
            response.sendRedirect("login.jsp");
        }
    }
}
