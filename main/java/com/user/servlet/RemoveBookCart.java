package com.user.servlet;

import java.io.IOException;

import com.DAO.CartDAOImpl;
import com.DB.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/remove_book")
public class RemoveBookCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bid = Integer.parseInt(req.getParameter("bid"));
        int uid = Integer.parseInt(req.getParameter("uid"));
        CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
        boolean f = dao.deleteBook(bid,uid);
        HttpSession session = req.getSession();

        if (f) {
            session.setAttribute("succsMsg", "Book Removed from Cart");
        } else {
            session.setAttribute("failedMsg", "Failed to remove book from cart");
        }
        resp.sendRedirect("checkout.jsp");
    }
}
