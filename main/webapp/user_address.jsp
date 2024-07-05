<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Address</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
<%@include file="all_component/navbar.jsp"%>
  <div class="container p-2"> <!-- Center the container -->
    <div class="col-md-6 offset-md-3 text-center"> <!-- Center the form within the container -->
      <div class="card">
        <div class="card-body">
          <h3 class="text-center text-success">Your Details for Order</h3>
          <form action="place_order.jsp" method="post"> <!-- Replace 'place_order.jsp' with your actual action URL -->
            <div class="form-row">
              <div class="form-group col-md-6">
                <label for="address">Address</label>
                <input type="text" class="form-control" id="address" name="address" required>
              </div>
              <div class="form-group col-md-6">
                <label for="landmark">Landmark</label>
                <input type="text" class="form-control" id="landmark" name="landmark">
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-4">
                <label for="city">City</label>
                <input type="text" class="form-control" id="city" name="city" required>
              </div>
              <div class="form-group col-md-4">
                <label for="state">State</label>
                <input type="text" class="form-control" id="state" name="state" required>
              </div>
              <div class="form-group col-md-4">
                <label for="zip">ZIP Code</label>
                <input type="text" class="form-control" id="zip" name="zip" required>
              </div>
            </div>
            <button type="submit" class="btn btn-warning">Add Address</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
