<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.entity.User"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ebook: Book Details</title>
    <%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f7f7f7;">
    <%@include file="all_component/navbar.jsp"%>
    <%
    // Check if the user is logged in
    HttpSession sessionCheck = request.getSession();
    User loggedInUser = (User) sessionCheck.getAttribute("user");
    if (loggedInUser == null) {
        // User is not logged in, redirect to the login page
        response.sendRedirect("login.jsp"); // Replace 'login.jsp' with your actual login page URL
        return; // Stop further execution of the page
    }
    
    // Get the user ID from the logged-in user
    int uid = loggedInUser.getId();

    int bid=Integer.parseInt(request.getParameter("bid"));

    BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
    BookDtls book = dao.getBookById(bid);
    %>
    <div class="container p-3">
        <div class="row">
            <div class="col-md-6 text-center p-5 border bg-white">
                <img src="book/<%= book.getPhotoName() %>" style="max-width: 150px;height:150px;"><br>
                <h4 class="mt-3">
                    Book Name:<span class="text-success"> <%=book.getBookName()%></span>
                </h4>
                <h4>
                    Author Name: <span class="text-success"> <%=book.getAuthor()%></span>
                </h4>
                <h4>
                    Category:<span class="text-success"> <%=book.getBookCategory()%></span>
                </h4>
            </div>
            <div class="col-md-6 text-center p-5 border bg-white">
                <h2><%=book.getBookName()%></h2>
                <div class="row mt-2">
                    <div class="col-md-4 text-danger text-center p-2">
                        <i class="fas fa-money-bill-wave fa-2x"></i>
                        <p>Cash On Delivery</p>
                    </div>
                    <div class="col-md-4 text-danger text-center p-2">
                        <i class="fas fa-undo-alt fa-2x"></i>
                        <p>Return Available</p>
                    </div>
                    <div class="col-md-4 text-danger text-center p-2">
                        <i class="fas fa-truck-moving fa-2x"></i>
                        <p>Free Shipping</p>
                    </div>
                </div>

                <div class="text-center p-3">
                    <a href="cart?bid=<%= book.getBookId() %>&uid=<%= uid %>" class="btn btn-primary">
                        <i class="fas fa-cart-plus"></i> Add Cart
                    </a>
                    <a href="#" class="btn btn-danger">
                        <i class="fas fa-rupee-sign"></i> <%= book.getPrice() %>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Success modal -->
    <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successModalLabel">Success</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Book added to cart successfully!
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Failure modal -->
    <div class="modal fade" id="failureModal" tabindex="-1" role="dialog" aria-labelledby="failureModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="failureModalLabel">Error</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Failed to add book to cart. Please try again later.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Bootstrap JS for modal -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function() {
            <%-- Display success modal if success message is present --%>
            <% if (session.getAttribute("viewBooksSuccMsg") != null) { %>
                $("#successModal").modal("show");
                <% session.removeAttribute("viewBooksSuccMsg"); %>
            <% } %>
            <%-- Display failure modal if failure message is present --%>
            <% if (session.getAttribute("viewBooksFailedMsg") != null) { %>
                $("#failureModal").modal("show");
                <% session.removeAttribute("viewBooksFailedMsg"); %>
            <% } %>
        });
    </script>
</body>
</html>
