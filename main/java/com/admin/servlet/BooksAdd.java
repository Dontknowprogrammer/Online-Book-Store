package com.admin.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletContext;

import com.DAO.BookDAOImpl;
import com.DB.DBConnect;
import com.entity.BookDtls;

@WebServlet("/add_books")
@MultipartConfig
public class BooksAdd extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// Retrieve form data
			String bookName = req.getParameter("bookName");
			String author = req.getParameter("authorName");
			String price = req.getParameter("price");
			String bookCategory = req.getParameter("categories");
			String status = req.getParameter("status");

			// Retrieve uploaded file
			Part filePart = req.getPart("photo");
			String photoName = filePart.getSubmittedFileName();
			InputStream photoStream = filePart.getInputStream();

			// Create BookDtls object
			BookDtls book = new BookDtls(bookName, author, price, bookCategory, status, photoName, "admin@gmail.com");

			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());

			// Get the upload directory path
			ServletContext context = getServletContext();
			String path = context.getRealPath("") + File.separator + "book";

			// Create the directory if it doesn't exist
			File directory = new File(path);
			if (!directory.exists()) {
				directory.mkdirs();
			}

			// Write the uploaded file to the specified directory
			filePart.write(path + File.separator + photoName);

			// Add book to database
			boolean f = dao.addBooks(book);

			HttpSession session = req.getSession();

			if (f) {
				session.setAttribute("succMsg", "Book Added Successfully");
				resp.sendRedirect("admin/add_books.jsp");
			} else {
				session.setAttribute("failedMsg", "Something went wrong on the server");
				resp.sendRedirect("admin/add_books.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
