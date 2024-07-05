<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>E-Book:Register</title>
    <%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
    <%@include file="all_component/navbar.jsp"%>
    <div class="container p-2">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body">
                        <h4 class="text-center">Registration Page</h4>
                        <form id="registerForm" action="register" method="post" onsubmit="return validateForm()">
                            <div class="form-group">
                                <label for="name">Name</label> 
                                <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name">
                            </div>
                            <div class="form-group">
                                <label for="email">Email address</label> 
                                <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Enter email">
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone number</label> 
                                <input type="text" class="form-control" id="phone" name="phno" placeholder="Enter phone number">
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label> 
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                            </div>
                            <button type="submit" class="btn btn-primary">Register</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

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

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- JavaScript to display success or failure message in the modal -->
    <%
    String currentPage = request.getRequestURI(); // Get the current page URI
    if (currentPage.endsWith("register.jsp")) { // Check if the current page is register.jsp
        String successMsg = (String) session.getAttribute("successMsg");
        String failedMsg = (String) session.getAttribute("failedMsg");
        if (successMsg != null && !successMsg.isEmpty()) {
    %>
    <script>
        $(document).ready(function(){
            $("#messageModalTitle").text("Success");
            $("#messageModalBody").text("<%=successMsg%>");
            $("#messageModal").modal('show');
            // Clear session attribute after displaying modal
            <% session.removeAttribute("successMsg"); %>
        });
    </script>
    <% } else if (failedMsg != null && !failedMsg.isEmpty()) { %>
    <script>
        $(document).ready(function(){
            $("#messageModalTitle").text("Failure");
            $("#messageModalBody").text("<%=failedMsg%>");
            $("#messageModal").modal('show');
            // Clear session attribute after displaying modal
            <% session.removeAttribute("failedMsg"); %>
        });
    </script>
    <% }
    } %>

    <!-- Client-side form validation -->
    <script>
        function validateForm() {
            var name = $("#name").val();
            var email = $("#email").val();
            var phone = $("#phone").val();
            var password = $("#password").val();

            if (name.trim() === '' || email.trim() === '' || phone.trim() === '' || password.trim() === '') {
                alert("Please fill in all fields.");
                return false; // Prevent form submission
            }
            return true; // Allow form submission
        }
    </script>
</body>
</html>
