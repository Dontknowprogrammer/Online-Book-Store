package com.user.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.DAO.BookOrderImpl;
import com.DAO.CartDAOImpl;
import com.DB.DBConnect;
import com.entity.Book_Order;
import com.entity.Cart;
import com.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            int id = user.getId();
            String name = user.getName();
            String email = user.getEmail();
            String phno = user.getPhno();
            String address = req.getParameter("address");
            String landmark = req.getParameter("landmark");
            String city = req.getParameter("city");
            String state = req.getParameter("state");
            String pincode = req.getParameter("zip");
            String paymentType = req.getParameter("payment");

            String fullAddress = address + ", " + landmark + ", " + city + ", " + state + " , " + pincode;

            CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
            List<Cart> cartList = dao.getBookByUser(id);
            BookOrderImpl orderDao = new BookOrderImpl(DBConnect.getConn());

            ArrayList<Book_Order> orderList = new ArrayList<>();
            Random random = new Random();
            for (Cart cartItem : cartList) {
                Book_Order order = new Book_Order();
                order.setOrderId("BOOK-ORD-00" + random.nextInt(1000));
                order.setUserName(name);
                order.setEmail(email);
                order.setPhno(phno);
                order.setFullAddress(fullAddress);
                order.setBookName(cartItem.getBookName());
                order.setAuthor(cartItem.getAuthor());
                order.setPrice(String.valueOf(cartItem.getPrice()));
                order.setPaymentType(paymentType);
                orderList.add(order);
            }

            if ("noselect".equals(paymentType)) {
                session.setAttribute("failedMsg", "Choose Payment Method");
                resp.sendRedirect("checkout.jsp");
            } else {
                boolean isSuccess = orderDao.saveOrder(orderList);
                if (isSuccess) {
                    session.setAttribute("succsMsg", "Order has been placed");
                    resp.sendRedirect("order_success.jsp");
                } else {
                    session.setAttribute("failedMsg", "Your Order Failed");
                    resp.sendRedirect("checkout.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions here
        }
    }
}
