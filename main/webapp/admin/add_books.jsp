<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: Add Books</title>
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
    <div class="row">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="text-center">Add Books</h4>
                    <!-- jQuery -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                    <!-- Bootstrap JS -->
                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                    <script>
                    $(document).ready(function(){
                        <% if (session.getAttribute("succMsg") != null && !((String) session.getAttribute("succMsg")).isEmpty()) { %>
                            $("#messageModalTitle").text("Success");
                            $("#messageModalBody").text("<%= session.getAttribute("succMsg") %>");
                            $("#messageModal").modal('show');
                            <% session.removeAttribute("succMsg"); %> // Clear session attribute
                        <% } else if (session.getAttribute("failedMsg") != null && !((String) session.getAttribute("failedMsg")).isEmpty()) { %>
                            $("#messageModalTitle").text("Failure");
                            $("#messageModalBody").text("<%= session.getAttribute("failedMsg") %>");
                            $("#messageModal").modal('show');
                            <% session.removeAttribute("failedMsg"); %> // Clear session attribute
                        <% } %>
                    });
                    </script>
                    <form action="../add_books" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="bookName">Book Name:</label>
                            <input type="text" id="bookName" name="bookName" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="authorName">Author Name:</label>
                            <input type="text" id="authorName" name="authorName" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="number" id="price" name="price" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="categories">Book Categories:</label>
                            <input type="text" id="categories" name="categories" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="status">Book Status:</label>
                            <select id="status" name="status" class="form-control" required>
                                <option selected>--select--</option>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                                <!-- Add more options as needed -->
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="photo">Upload Photo:</label>
                            <input type="file" id="photo" name="photo" class="form-control-file" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Book</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
