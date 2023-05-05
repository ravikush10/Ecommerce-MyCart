<%@page import="mycart.helper.Helper"%>
<%@page import="java.util.Map"%>
<%@page import="mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="mycart.helper.FactoryProvider"%>
<%@page import="mycart.dao.CategoryDao"%>
<%@page import="mycart.entities.User"%>
<%
User user = (User) session.getAttribute("current-user");
if (user == null) {
	session.setAttribute("message", "You are not logged in !! Login first");
	response.sendRedirect("login.jsp");
	return;
} else {
	if (user.getUserType().equals("normal")) {
		session.setAttribute("message", "You are not normal user ! Do not access this page");
		response.sendRedirect("login.jsp");
		return;
	}
}
%>

<%
CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
List<Category> list = cdao.getCategories();

//getting count
Map<String, Long> m = Helper.getCounts(FactoryProvider.getFactory());
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Panel</title>
<%@include file="components/common_css_js.jsp"%>


</head>
<body>
	<%@include file="components/navbar.jsp"%>

	<div class="container admin">

		<div class="container-fluid mt-3">
			<%@include file="components/message.jsp"%>

		</div>

		<!-- First row -->

		<div class="row mt-3">

			<!-- First row : First column-->

			<div class="col-md-4">
				<div class="card" data-toggle="tooltip" data-placement="left" title="Number of users on this website">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 100px;" class="image-fluid"
								src="img/team.png" alt="user_icon">
						</div>

						<h1><%=m.get("userCount")%></h1>
						<h1 class="text-uppercase text-muted">Users</h1>
					</div>
				</div>
			</div>

			<!-- First row : Second column-->

			<div class="col-md-4">
				<div class="card" data-toggle="tooltip" data-placement="bottom" title="Total categories">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 100px;" class="image-fluid"
								src="img/note.png" alt="user_icon">
						</div>

						<h1><%=list.size()%></h1>
						<h1 class="text-uppercase text-muted">categories</h1>
					</div>
				</div>
			</div>

			<!-- First row : Third column-->

			<div class="col-md-4">
				<div class="card" data-toggle="tooltip" data-placement="right" title="Total number of products">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 100px;" class="image-fluid"
								src="img/product.png" alt="user_icon">
						</div>
						<h1><%=m.get("productCount")%></h1>
						<h1 class="text-uppercase text-muted">products</h1>
					</div>
				</div>
			</div>

		</div>

		<!-- Second row -->

		<div class="row mt-3">

			<!-- Second row : First column-->

			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-category-modal">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 100px;" class="image-fluid"
								src="img/addcategory.png" alt="user_icon">
						</div>

						<p class="mt-3">Click here to add category</p>
						<h1 class="text-uppercase text-muted">Add category</h1>
					</div>
				</div>
			</div>

			<!-- Second row : Second column-->

			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-product-modal">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 100px;" class="image-fluid"
								src="img/addproduct.png" alt="user_icon">
						</div>

						<p class="mt-3">Click here to add product</p>
						<h1 class="text-uppercase text-muted">Add Product</h1>
					</div>
				</div>
			</div>
		</div>
		
		<!-- view products row -->
		
		<div class="row mt-3 mb-3">
			<div class="col-md-12">
				<div onclick="window.location='ViewProducts.jsp'" class="card">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 100px;" class="image-fluid"
								src="img/ViewProduct.png" alt="user_icon">
						</div>

						<p class="mt-3">Click here to view all products</p>
						<h1 class="text-uppercase text-muted">View Products</h1>
					</div>
				</div>
			</div>
		</div>

	</div>


	<!-- add category modal -->


	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg">
					<h5 class="modal-title" id="exampleModalLabel">Fill category
						details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="ProductOperationServlet" method="post">

						<input type="hidden" name="operation" value="addcategory">

						<div class="form-group">
							<input type="text" class="form-control" name="catTitle"
								placeholder="Enter category title" required />
						</div>

						<div class="form-group">
							<textarea style="height: 200px;" class="form-control"
								placeholder="Enter category description" name="catDescription"></textarea>

						</div>

						<div class="container text-center">
							<button class="btn btn-outline-success">Add Category</button>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Close</button>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- End category modal -->

	<!-- add product modal -->


	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg">
					<h5 class="modal-title" id="exampleModalLabel">Product details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">


					<form action="ProductOperationServlet" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="operation" value="addproduct" />
						<div class="form-group">
							<input type="text" class="form-control" name="pName"
								placeholder="Enter product name" required />
						</div>

						<div class="form-group">
							<textarea style="height: 100px;" class="form-control"
								placeholder="Enter product description" name="pDesc"></textarea>
						</div>

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Enter product price" name="pPrice" required />
						</div>

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Enter product discount" name="pDiscount" required />
						</div>

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Enter product quantity" name="pQuantity" required />
						</div>


						<!-- Category -->




						<div class="form-group">
							<select class="form-control" name="catId" id="">
								<%
								for (Category c : list) {
								%>
								<option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>
								<%
								}
								%>
							</select>
						</div>

						<!-- Product photo -->

						<div class="form-group">
							<label for="pPic">Select picture of product</label> <br> <input
								type="file" id="pPic" name="pPic" required />
						</div>


						<div class="container text-center">
							<button class="btn btn-outline-success">Add Product</button>

						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Close</button>
						</div>

					</form>


				</div>
			</div>
		</div>
	</div>


	<!-- End product modal -->

	<%@include file="components/common_modals.jsp"%>

	<script>
		$(function() {
			$('[data-toggle="tooltip"]').tooltip()
		})
	</script>

</body>
</html>