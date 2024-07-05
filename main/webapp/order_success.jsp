<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entity.User"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Success</title>
    <%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
<%@include file="all_component/navbar.jsp"%>
<div class="container text-center mt-3">
	<i class="fas fa-check-circle fa-5x text-success"></i>
	<h1>Thank You</h1>
    <h2>Order Placed Successfully!</h2>
    <p>With in 7 days your product will be delivered to your address</p>
    <%
        HttpSession sessionCheck = request.getSession(false);
        User loggedInUser = null;
        if (sessionCheck != null) {
            loggedInUser = (User) sessionCheck.getAttribute("user");
        }
        if (loggedInUser == null) {
            %>
            <div class="alert alert-warning" role="alert">
                Please <a href="login.jsp" class="alert-link">log in</a> again to view your orders or navigate to the home page.
            </div>
            <%
        } else {
    %>
    <p>
        <a href="index.jsp" class="btn btn-primary mt-3">Home</a>
        <a href="order.jsp" class="btn btn-danger mt-3">View Order</a>
    </p>
    <% } %>
</div>
</body>
</html>
