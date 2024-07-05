<%@ page import="com.DAO.CartDAOImpl"%>
<%@ page import="com.entity.User"%>
<%@ page import="java.util.*"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.entity.Cart"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if the user is logged in
    HttpSession sessionCheck = request.getSession();
    User loggedInUser = (User) sessionCheck.getAttribute("user");
    if (loggedInUser == null) {
        // User is not logged in, redirect to the login page
        response.sendRedirect("login.jsp"); // Replace 'login.jsp' with your actual login page URL
        return; // Stop further execution of the page
    }

    // Get success and failure messages from session
    String succsMsg = (String) session.getAttribute("succsMsg");
    String failedMsg = (String) session.getAttribute("failedMsg");

    // Clear success and failure messages from session after retrieving them
    session.removeAttribute("succsMsg");
    session.removeAttribute("failedMsg");

    // Initialize variables
    List<Cart> cart = new ArrayList<>();
    Double totalPrice = 0.00;
    String errorMsg = "";

    // Fetch user's cart items
    try {
        User u = (User) session.getAttribute("user");
        CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
        cart = dao.getBookByUser(u.getId());
        for (Cart c : cart) {
            totalPrice += c.getPrice();
        }
    } catch (Exception e) {
        errorMsg = "Error fetching cart items: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart Page</title>
    <%@include file="all_component/allCss.jsp"%>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <div class="card-body">
                    <h3 class="text-center text-success">Your Selected Item</h3>
                    <table class="table table-striped">
                        <thead class="bg-primary text-white">
                            <tr>
                                <th scope="col">BookName</th>
                                <th scope="col">Author</th>
                                <th scope="col">Price</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Cart c : cart) { %>
                                <tr>
                                    <td><%= c.getBookName() %></td>
                                    <td><%= c.getAuthor() %></td>
                                    <td><%= c.getPrice() %></td>
                                    <td><a href="remove_book?bid=<%= c.getBid() %>&&uid=<%=c.getUserId() %>" class="btn btn-sm btn-danger">Remove</a></td>
                                </tr>
                            <% } %>
                            <tr>
                                <td>Total Price</td>
                                <td></td>
                                <td></td>
                                <td><%= totalPrice %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center text-success">Your Details for Order</h3>
                        <% if (!errorMsg.isEmpty()) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= errorMsg %>
                            </div>
                        <% } %>
                        <form action="order" method="post">
                            <!-- Hidden input to include full address -->
                            <input type="hidden" name="id" value="<%= loggedInUser.getId() %>">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" id="name" name="name" value="<%= loggedInUser.getName() %>" readonly>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="<%= loggedInUser.getEmail()%>" readonly>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="mobile">Mobile Number</label>
                                    <input type="text" class="form-control" id="mobile" name="mobile" value="<%= loggedInUser.getPhno() %>" readonly>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="landmark">Landmark</label>
                                    <input type="text" class="form-control" id="landmark" name="landmark" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="city">City</label>
                                    <input type="text" class="form-control" id="city" name="city" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="state">State</label>
                                    <input type="text" class="form-control" id="state" name="state" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="zip">ZIP Code</label>
                                    <input type="text" class="form-control" id="zip" name="zip" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="payment">Payment Type</label>
                                <select class="form-control" id="payment" name="payment" required>
                                    <option value="noselect">Select Payment Type</option>
                                    <option value="Credit Card">Credit Card</option>
                                    <option value="Debit Card">Debit Card</option>
                                    <option value="PayPal">PayPal</option>
                                    <option value="Cash on Delievery">Cash on Delivery</option>
                                </select>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6">
                                    <button type="submit" class="btn btn-warning btn-block">Order Now</button>
                                </div>
                                <div class="col-md-6">
                                    <a href="index.jsp" class="btn btn-success btn-block">Continue Shopping</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
