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
    <title>Ebook: Index</title>
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
<div class="container-fluid back-img">
    <h2 class="text-center text-danger">E-Book Management System</h2>
</div>

<!-- Success and failure modals -->
<%
    String successMsg = (String) session.getAttribute("succMsg");
    String failedMsg = (String) session.getAttribute("failedMsg");
    if (successMsg != null || failedMsg != null) {
%>
<div id="messageModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Message</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <% if (successMsg != null) { %>
                <p><%= successMsg %></p>
                <% } else if (failedMsg != null) { %>
                <p><%= failedMsg %></p>
                <% } %>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<%
    session.removeAttribute("succMsg");
    session.removeAttribute("failedMsg");
}
%>

<div class="container">
    <h3 class="text-center">Available Books</h3>
    <div class="row">
        <%
            // Get book details from the database
            BookDAOImpl bookDAO = new BookDAOImpl(DBConnect.getConn());
            List<BookDtls> books = bookDAO.getAllActiveBooks(); // Modify to fetch only active books

            for (BookDtls book : books) {
        %>
        <div class="col-md-4 mb-3">
            <div class="card crd-ho">
                <div class="card-body text-center">
                    <img alt=""
                         src="<%=request.getContextPath() + "/book/" + book.getPhotoName()%>"
                         style="width: 150px; height: 200px" class="img-thumblin">
                    <p><%=book.getBookName()%></p>
                    <p><%=book.getAuthor()%></p>
                    <p>Category: <%=book.getBookCategory()%></p>
                    <div class="row justify-content-center">
                        <%if (u==null){ %>
                            <a href="login.jsp" class="btn btn-danger btn-sm mr-2"><i
                                    class="fas fa-cart-plus"></i> Add Cart</a>
                        <% } else { %>
                            <a href="cart?bid=<%=book.getBookId()%>&uid=<%=u.getId()%>"
                               class="btn btn-danger btn-sm mr-2"><i class="fas fa-cart-plus"></i> Add Cart</a>
                        <% } %>
                        <a href="view_books.jsp?bid=<%=book.getBookId()%>"
                           class="btn btn-success btn-sm mr-2">View Details</a>
                        <a href="#" class="btn btn-danger btn-sm"><i class="fas fa-rupee-sign"></i>
                            <%=book.getPrice()%></a>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

<%-- JavaScript to display success message in the modal if success parameter is present in the URL --%>
<script>
    $(document).ready(function(){
        const urlParams = new URLSearchParams(window.location.search);
        const successParam = urlParams.get('success');
        if (successParam === 'true') {
            $('#messageModal').modal('show');
        }
    });
</script>

</body>
</html>
