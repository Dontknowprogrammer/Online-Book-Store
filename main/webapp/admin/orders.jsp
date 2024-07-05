<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.entity.User"%>
<%@ page import="java.util.*"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.entity.Cart"%>
<%@ page import="com.DAO.*"%>
<%@ page import="com.entity.Book_Order" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Orders</title>
    <%@include file="allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
    <%@include file="navbar.jsp"%>
    <div class="container">
        <h2 class="text-center text-success">Orders</h2>
        <table class="table table-striped">
            <thead class="bg-primary text-white">
                <tr>
                    <th>Order ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Ph No</th>
                    <th>Book Name</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Payment Type</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        BookOrderImpl dao = new BookOrderImpl(DBConnect.getConn());
                        List<Book_Order> orderList = dao.getAllOrder();
                        for (Book_Order order : orderList) {
                %>
                    <tr>
                        <td><%= order.getOrderId() %></td>
                        <td><%= order.getUserName() %></td>
                        <td><%= order.getEmail() %></td>
                        <td><%= order.getFullAddress() %></td>
                        <td><%= order.getPhno() %></td>
                        <td><%= order.getBookName() %></td>
                        <td><%= order.getAuthor() %></td>
                        <td><%= order.getPrice() %></td>
                        <td><%= order.getPaymentType() %></td>
                    </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        // Handle exception
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
