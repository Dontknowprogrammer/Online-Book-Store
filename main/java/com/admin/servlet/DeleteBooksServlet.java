package com.admin.servlet;

import java.io.IOException;
import com.DAO.BookDAOImpl;
import com.DB.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete")
public class DeleteBooksServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Retrieve the book ID from the request parameter
            int bookId = Integer.parseInt(req.getParameter("id"));

            // Instantiate BookDAO implementation
            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());

            // Call the method to delete the book
            boolean isSuccess = dao.deleteBook(bookId);

            if (isSuccess) {
                // Set success message in session attribute
                req.getSession().setAttribute("succMsg", "Book Deleted Successfully");
            } else {
                // Set failure message in session attribute
                req.getSession().setAttribute("failedMsg", "Failed to delete book");
            }

            // Redirect back to the page where the deletion was initiated
            resp.sendRedirect("admin/all_books.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions here, e.g., set error message in session attribute
            req.getSession().setAttribute("failedMsg", "An error occurred while deleting the book");
            // Redirect back to the page where the deletion was initiated
            resp.sendRedirect("admin/all_books.jsp");
        }
    }
}
