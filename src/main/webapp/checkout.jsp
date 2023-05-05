
<%
User user = (User) session.getAttribute("current-user");
if (user == null) {
	session.setAttribute("message", "You are not logged in !! Login first to access checkout page");
	response.sendRedirect("login.jsp");
	return;
}
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>

	<div class="container">
		<div class="row mt-5">
			<div class="col-md-6">
				<!-- card -->
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-4">Your selected items</h3>
						<div class="cart-body"></div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<!-- from details -->
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-4">Details for order</h3>
						<form action="#!">
							<div class="form-group">
								<label for="exampleInputName">Enter name</label> <input
									value="<%=user.getUserName()%>" type="text"
									class="form-control" id="name" aria-describedby="nameHelp"
									placeholder="Enter your name">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									value="<%=user.getUserEmail()%>" type="email"
									class="form-control" id="email" aria-describedby="emailHelp"
									placeholder="Enter your email address">
							</div>
							<div class="form-group">
								<label for="exampleInputNumber">Enter contact number</label> <input
									value="<%=user.getUserPhone()%>" type="number"
									class="form-control" id="phone" aria-describedby="phoneHelp"
									placeholder="Enter your contact number">
							</div>
							<div class="form-group">
								<label for="exampleFormControlTextarea1">Your shipping
									address</label>
								<textarea value="<%=user.getUserAddress()%>"
									class="form-control" id="exampleFormControlTextarea1"
									placeholder="Enter your address" rows="3"></textarea>
							</div>
							<div class="container text-center">
								<button class="btn btn-outline-success">Order now</button>
								<button class="btn btn-outline-primary">Continue
									shopping</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="components/common_modals.jsp"%>
</body>
</html>