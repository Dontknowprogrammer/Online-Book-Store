<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entity.User"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
<%@include file="all_component/allCss.jsp"%>
<style type="text/css">
        .back-img {
            background: url("img/b.jpg");
            height: 50vh;
            width: 100%;
            background-repeat: no-repeat;
            background-size: cover;
        }

        .crd-ho:hover {
            background-color: #fcf7f7;
        }
</style>
</head>
<body style="background-color: #f7f7f7;">
<%
    User u = (User) session.getAttribute("user");
%>
<%@include file="all_component/navbar.jsp"%>
<%
    String searchQuery = request.getParameter("ch");
    if (searchQuery != null && !searchQuery.isEmpty()) {
        // Perform search and display results
        BookDAOImpl bookDAO = new BookDAOImpl(DBConnect.getConn());
        List<BookDtls> searchResults = bookDAO.getBookBySearch(searchQuery);
%>
<% if (!searchResults.isEmpty()) { %>
    <h2>Search Results for "<%= searchQuery %>"</h2>
    <div class="container">
        <div class="row">
            <% for (BookDtls book : searchResults) { %>
            <div class="col-md-4 mb-3">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <img alt=""
                            src="<%= request.getContextPath() + "/book/" + book.getPhotoName() %>"
                            style="width: 150px; height: 200px" class="img-thumblin">
                        <p><%= book.getBookName() %></p>
                        <p><%= book.getAuthor() %></p>
                        <p>Category: <%= book.getBookCategory() %></p>
                        <div class="row justify-content-center">
                            <% if (u == null) { %>
                            <a href="login.jsp" class="btn btn-danger btn-sm mr-2"><i
                                class="fas fa-cart-plus"></i> Add Cart</a>
                            <% } else { %>
                            <a href="cart?bid=<%= book.getBookId() %>&&uid=<%= u.getId() %>"
                                class="btn btn-danger btn-sm mr-2"><i class="fas fa-cart-plus"></i> Add Cart</a>
                            <% } %>
                            <a href="view_books.jsp?bid=<%= book.getBookId() %>"
                                class="btn btn-success btn-sm mr-2">View Details</a>
                            <a href="#" class="btn btn-danger btn-sm"><i class="fas fa-rupee-sign"></i>
                                <%= book.getPrice() %></a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
<% } else { %>
    <h2>No books found for "<%= searchQuery %>".</h2>
<% } %>
<% } else { %>
<h2>No search query provided.</h2>
<% } %>

</body>
</html>
