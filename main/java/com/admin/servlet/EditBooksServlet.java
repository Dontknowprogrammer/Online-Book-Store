package com.admin.servlet;
import java.io.IOException;
import com.DAO.BookDAOImpl;
import com.DB.DBConnect;
import com.entity.BookDtls;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/edit_books")
@MultipartConfig
public class EditBooksServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Retrieve updated book details from the form
            int bookId = Integer.parseInt(req.getParameter("id")); // Corrected parameter name
            String bookName = req.getParameter("bookName");
            String author = req.getParameter("authorName");
            String price = req.getParameter("price");
            String bookCategory = req.getParameter("categories");
            String status = req.getParameter("status");

            // Create a BookDtls object with updated details
            BookDtls updatedBook = new BookDtls();
            updatedBook.setBookId(bookId); // Set the correct bookId
            updatedBook.setBookName(bookName);
            updatedBook.setAuthor(author);
            updatedBook.setPrice(price);
            updatedBook.setBookCategory(bookCategory);
            updatedBook.setStatus(status);

            // Instantiate BookDAO implementation
            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());

            // Call the method to update book details
            boolean isSuccess = dao.updateEditBooks(updatedBook);

            // Check if the update was successful
            if (isSuccess) {
                // Set success message in session attribute
                req.getSession().setAttribute("succMsg", "Book Updated Successfully");
            } else {
                // Set failure message in session attribute
                req.getSession().setAttribute("failedMsg", "Failed to update book details");
            }

            // Clear session attributes if redirecting to add_book.jsp
            if (req.getRequestURI().contains("add_book.jsp")) {
                req.getSession().removeAttribute("succMsg");
                req.getSession().removeAttribute("failedMsg");
            }

            // Redirect back to the page where the update was initiated
            resp.sendRedirect("admin/all_books.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions here, e.g., set error message in session attribute
            req.getSession().setAttribute("failedMsg", "An error occurred while updating book details");
            // Redirect back to the page where the update was initiated
            resp.sendRedirect("admin/all_books.jsp");
        }
    }
}

	
    

