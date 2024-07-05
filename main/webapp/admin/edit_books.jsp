<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: Edit Books</title>
<%@include file="allCss.jsp"%>
<!-- Bootstrap CSS -->

</head>
<body style="background-color: #f0f2f2;">

	<!-- Navbar -->
	<%@include file="navbar.jsp"%>

	<%
	// Check if the ID parameter is present
	int id;
	if (request.getParameter("id") == null || request.getParameter("id").isEmpty()) {
		// Inform the user about the missing ID parameter
		out.println(
		"<div class='container'><div class='row'><div class='col-md-4 offset-md-4'><div class='alert alert-danger'>ID parameter is missing. Please provide the ID.</div></div></div></div>");
		return; // Stop further execution of the page
	} else {
		id = Integer.parseInt(request.getParameter("id"));
	}

	BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
	BookDtls book = dao.getBookById(id);
	%>

	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body">
						<h4 class="text-center">Edit Book</h4>

						<form action="../edit_books" method="post"
							enctype="multipart/form-data">
							<input type="hidden" name="id" value="<%=book.getBookId()%>">
						

							<div class="form-group">
								<label for="bookName">Book Name:</label> <input type="text"
									id="bookName" name="bookName" class="form-control" required
									value="<%=book.getBookName()%>">
							</div>
							<div class="form-group">
								<label for="authorName">Author Name:</label> <input type="text"
									id="authorName" name="authorName" class="form-control" required
									value="<%=book.getAuthor()%>">
							</div>
							<div class="form-group">
								<label for="price">Price:</label> <input type="number"
									id="price" name="price" class="form-control" required
									value="<%=book.getPrice()%>">
							</div>
							<div class="form-group">
								<label for="categories">Book Categories:</label> <input
									type="text" id="categories" name="categories"
									class="form-control" required
									value="<%=book.getBookCategory()%>">
							</div>
							<div class="form-group">
								<label for="status">Book Status:</label> <select id="status"
									name="status" class="form-control" required>
									<option value="Active"
										<%=book.getStatus().equals("Active") ? "selected" : ""%>>Active</option>
									<option value="Inactive"
										<%=book.getStatus().equals("Inactive") ? "selected" : ""%>>Inactive</option>
								</select>
							</div>

							<button type="submit" class="btn btn-primary">Update
								Book</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
