<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.DAO.BookDAOImpl" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="com.DB.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">

<%
    // Get the user object from the session
    User u = (User) session.getAttribute("user");
    // Check if user object is null
    if (u == null) {
        // Redirect user to login page or handle appropriately
        response.sendRedirect("login.jsp");
        return; // Stop further execution
    }
%>

<%@include file="all_component/navbar.jsp"%>
<div class="container p-2">
    <div class="row">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="text-center">Edit Profile</h4>
                    <div class="edit-profile-form">
                        <form action="update_profile" method="post">
                            <input type="hidden" value="<%=u.getId() %>" name="id">
                            <div class="form-group">
                                <label for="name">Name</label>
                                <!-- Display user's name -->
                                <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" value="<%= u.getName() %>">
                            </div>
                            <div class="form-group">
                                <label for="email">Email address</label>
                                <!-- Display user's email -->
                                <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Enter email" value="<%= u.getEmail() %>">
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone number</label>
                                <!-- Display user's phone number -->
                                <input type="text" class="form-control" id="phone" name="phno" placeholder="Enter phone number" value="<%= u.getPhno() %>">
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                            </div>
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Success and failure modal messages -->
<%
    String successMsg = (String) session.getAttribute("succMsg");
    String failedMsg = (String) session.getAttribute("failedMsg");
    if (successMsg != null || failedMsg != null) {
%>
<script>
    $(document).ready(function(){
        $('#messageModal').modal('show');
    });
</script>
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

</body>
</html>
