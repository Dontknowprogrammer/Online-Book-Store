
package com.user.servlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;
import com.entity.User;
import com.DAO.UserDAO;
import com.DAO.UserDAOImpl;
import com.DB.DBConnect;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phno = request.getParameter("phno");
        String password = request.getParameter("password");

        // Check if user with the same email already exists
        try {
            UserDAO userDao = new UserDAOImpl(DBConnect.getConn());
            User existingUser = userDao.getUserByEmail(email);

            if (existingUser != null) {
                // User with the same email already exists
                HttpSession session = request.getSession();
                session.setAttribute("failedMsg", "User with this email already exists!");
                response.sendRedirect("register.jsp");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle database connection error
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Database connection error. Please try again later.");
            response.sendRedirect("register.jsp");
            return;
        }

        // Create User object
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhno(phno);
        user.setPassword(password);

        // Establish database connection
        try {
            UserDAO userDao = new UserDAOImpl(DBConnect.getConn());

            // Register user
            boolean success = userDao.userRegister(user);

            // Get session object
            HttpSession session = request.getSession();

            if (success) {
                // Registration successful
                session.setAttribute("successMsg", "Registration successful!");
            } else {
                // Registration failed
                session.setAttribute("failedMsg", "Registration failed! Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle database connection error
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Database connection error. Please try again later.");
            response.sendRedirect("register.jsp");
            return;
        } finally {
            // Redirect to register.jsp
            response.sendRedirect("register.jsp");
        }
    }
}