<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: All Books</title>
<%@include file="allCss.jsp"%>
</head>
<body style="background-color: #f0f2f2;">

<!-- Navbar -->
<%@include file="navbar.jsp"%>

<!-- Modal for Success and Failure Messages -->
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="messageModalTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="messageModalBody">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <h1>All Books</h1>

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
    $(document).ready(function(){
        <%-- JavaScript to display success or failure message in the modal --%>
        <% if (session.getAttribute("succMsg") != null && !((String) session.getAttribute("succMsg")).isEmpty()) { %>
            $("#messageModalTitle").text("Success");
            $("#messageModalBody").text("<%= session.getAttribute("succMsg") %>");
            $("#messageModal").modal('show');
            // Clear the success message after displaying
            <% session.removeAttribute("succMsg"); %>
        <% } else if (session.getAttribute("failedMsg") != null && !((String) session.getAttribute("failedMsg")).isEmpty()) { %>
            $("#messageModalTitle").text("Failure");
            $("#messageModalBody").text("<%= session.getAttribute("failedMsg") %>");
            $("#messageModal").modal('show');
            // Clear the failed message after displaying
            <% session.removeAttribute("failedMsg"); %>
        <% } %>

    });
    </script>

    <table class="table table-striped">
        <thead class="bg-primary text-white">
            <tr>
                <th>BookId</th>
                <th>Image</th>
                <th>Book Name</th>
                <th>Author Name</th>
                <th>Price</th>
                <th>Category</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            // Fetch data from database
            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
            List<BookDtls> list = dao.getAllBooks();

            // Loop through each book and display its details
            for (BookDtls book : list) {
            %>
            <tr>
                <td><%= book.getBookId() %></td>
                <td><img src="../book/<%= book.getPhotoName() %>" alt="Book Image" style="max-width: 100px;height:100px;"></td>
                <td><%= book.getBookName() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getPrice() %></td>
                <td><%= book.getBookCategory() %></td>
                <td><%= book.getStatus() %></td>
                <td>
                    <%-- Check if it's not the "Add Books" section before displaying the edit and delete buttons --%>
                    <% if (!request.getRequestURI().contains("add_books.jsp")) { %>
                        <a href="edit_books.jsp?id=<%= book.getBookId() %>" class="btn btn-sm btn-primary"><i class="fas fa-edit"></i> Edit</a>
                        <a href="../delete?id=<%= book.getBookId() %>" class="btn btn-sm btn-danger deleteBtn"><i class="fas fa-trash-alt"></i> Delete</a>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
