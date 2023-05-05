<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New User</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-5">
			<div class="col-md-4 offset-md-4">
				<div class="card">
				
				<%@include file="components/message.jsp" %>
				
					<div class="card-body px-5">
					<div class="container text-center">
					<img src="img/Sign-up.png" style="max-width: 150px;" class="img-fluid">
					</div>
						<h3 class="text-center">Sign Up Here!!</h3>
						<form action="RegisterServlet" method="post">

							<div class="form-group">
								<label for="name">Name</label> 
								<input type="text"  name="user_name"
									class="form-control" id="name" aria-describedby="name"
									placeholder="Enter yuor name">
							</div>

							<div class="form-group">
								<label for="email">Email</label>
								<input type="email" name="user_email"
									class="form-control" id="email" aria-describedby="email"
									placeholder="Enter your email">
							</div>

							<div class="form-group">
								<label for="password">Password</label>
								<input type="password" name="user_password"
									class="form-control" id="password" aria-describedby="password"
									placeholder="Enter your password">
							</div>

							<div class="form-group">
								<label for="phone">Phone</label> 
								<input type="number" name="user_phone"
									class="form-control" id="phone" aria-describedby="phone"
									placeholder="Enter your phone number">
							</div>

							<div class="form-group">
								<label for="address">Address</label>
								<textarea name="user_address" style="height: 100px;" class="form-control"
									placeholder="Enter your address"></textarea>
							</div>

							<div class="container text-center">
								<button type="submit" class="btn btn-outline-success">Sign Up</button>
								<button type="reset" class="btn btn-outline-warning">Reset</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>