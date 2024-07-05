<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.DAO.*"%>
<%@ page import="com.entity.User"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Report</title>
    <%@include file="allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
    <%@include file="navbar.jsp"%>
    <div class="container">
        <h2 class="text-center text-success">User Report</h2>
        <table class="table table-striped">
            <thead class="bg-primary text-white">
                <tr>
                    
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        UserDAO userDAO = new UserDAOImpl(DBConnect.getConn());
                        List<User> userList = userDAO.getAllUsers();
                        for (User user : userList) {
                %>
                    <tr>
                        <td><%= user.getName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getPhno() %></td>
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
