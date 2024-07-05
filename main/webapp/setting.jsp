<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.DAO.BookDAOImpl" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="com.DB.DBConnect" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Settings</title>
    <%@include file="all_component/allCss.jsp"%>
    <style type="text/css">
        a {
            text-decoration: none;
            color: black;
        }

        a:hover {
            text-decoration: none;
        }
    </style>
</head>
<body style="background-color: #f7f7f7;">

    <%@include file="all_component/navbar.jsp"%>
    <div class="container p-3">
        <div class="row justify-content-center"> <!-- Center the content horizontally -->
            <div class="col-md-4 text-center">
                <a href="edit_profile.jsp">
                    <div class="card">
                        <div class="card-body">
                            <div class="text-primary">
                                <i class="fas fa-edit fa-3x"></i>
                            </div>
                            <h4>Edit Profile</h4>
                            <p>Manage Your Account</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 text-center">
                <a href="order.jsp">
                    <div class="card">
                        <div class="card-body">
                            <div class="text-danger">
                                <i class="fas fa-box-open fa-3x"></i>
                            </div>
                            <h4>My Order</h4>
                            <p>Track Your Order</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 text-center">
                <a href="helpline.jsp">
                    <div class="card">
                        <div class="card-body">
                            <div class="text-primary">
                                <i class="fas fa-user-circle fa-3x"></i>
                            </div>
                            <h4>Help Center</h4>
                            <p>24 * 7 Service</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
