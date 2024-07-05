package com.user.servlet;

import java.io.IOException;

import com.DAO.BookDAOImpl;
import com.DAO.CartDAOImpl;
import com.DB.DBConnect;
import com.entity.BookDtls;
import com.entity.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Retrieve parameters
            int bid = Integer.parseInt(req.getParameter("bid"));
            int uid = Integer.parseInt(req.getParameter("uid"));
            
            // Retrieve book details
            BookDAOImpl bookDAO = new BookDAOImpl(DBConnect.getConn());
            BookDtls book = bookDAO.getBookById(bid);
            
            // Create a cart item
            Cart cartItem = new Cart();
            cartItem.setBid(bid);
            cartItem.setUserId(uid);
            cartItem.setBookName(book.getBookName());
            cartItem.setAuthor(book.getAuthor());
            cartItem.setPrice(Double.parseDouble(book.getPrice()));
            cartItem.setTotal_price(Double.parseDouble(book.getPrice()));
            
            // Add item to cart
            CartDAOImpl cartDAO = new CartDAOImpl(DBConnect.getConn());
            boolean added = cartDAO.addCart(cartItem);
            
            // Set session attribute based on operation result
            HttpSession session = req.getSession();
            if (added) {
                session.setAttribute("succMsg", "Added to Cart Successfully");
            } else {
                session.setAttribute("failedMsg", "Failed to add to Cart");
            }
        } catch (NumberFormatException e) {
            // Handle NumberFormatException (e.g., if bid or uid is not a valid number)
            e.printStackTrace();
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
        } finally {
            // Redirect to index.jsp with a success message parameter
            resp.sendRedirect("index.jsp?success=true");
        }
    }
}
