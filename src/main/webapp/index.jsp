<%@page import="mycart.helper.Helper"%>
<%@page import="mycart.entities.Category"%>
<%@page import="mycart.dao.CategoryDao"%>
<%@page import="mycart.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="mycart.dao.ProductDao"%>
<%@page import="mycart.helper.FactoryProvider"%>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>MyCart - Home</title>
<%@include file="components/common_css_js.jsp"%>

</head>
<body>
	<%@include file="components/navbar.jsp"%>

	<div class="container-fluid">
		<div class="row mt-3 mx-2">

			<%
			String cat = request.getParameter("category");
			//out.print(cat);

			ProductDao dao = new ProductDao(FactoryProvider.getFactory());
			List<Product> list = null;
			if (cat == null || cat.trim().equals("all")) {
				list = dao.getAllProducts();
			} else {
				int cid = Integer.parseInt(cat.trim());
				list = dao.getAllProductsById(cid);
			}

			CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
			List<Category> clist = cdao.getCategories();
			%>

			<!--Show Categories-->
			<div class="col-md-2">

				<div class="list-group mt-4">
					<a href="index.jsp?category=all"
						class="list-group-item list-group-item-action active"> All
						Products </a>

					<%
					for (Category c : clist) {
					%>
					<a href="index.jsp?category=<%=c.getCategoryId()%>"
						class="list-group-item list-group-item-action"><%=c.getCategoryTitle()%></a>

					<%
					}
					%>

				</div>

			</div>

			<!--Show Products-->
			<div class="col-md-10">

				<!-- row -->
				<div class="row mt-4">

					<!-- column -->
					<div class="col-md-12">

						<div class="card-columns">
							<%
							for (Product p : list) {
							%>

						<!-- product card -->
						
							<div class="card product-card">

								<div class="container text-center">
									<img class="card-img-top m-2"
										src="img/Products/<%=p.getpPhoto()%>"
										style="max-height: 200px; max-width: 100%; width: auto;"
										alt="Card image cap">

								</div>

								<div class="card-body">

									<h5 class="card-title"><%=p.getpName()%>
									</h5>

									<p class="card-text"><%=Helper.get10Words(p.getpDesc())%>
									</p>

								</div>

								<div class="card-footer text-center">
									<button class="btn custom-bg" onclick="add_to_cart(<%= p.getpId()%>,'<%= p.getpName()%>',<%= p.getDiscountPrice()%>)">Add to cart</button>
									<button class="btn btn-outline-success">
										&#8377;
										<%=p.getDiscountPrice()%>/- <span class="text-secondary discount-label"> &#8377; <%=p.getpPrice() %> , <%= p.getpDiscount() %>% off</span></button>
								</div>

							</div>
							<%
							}

							if (list.size() == 0) {
							out.println("<h5>Sorry!No item available in this category.</h5>");
							}
							%>

						</div>

					</div>

				</div>
			</div>
			</div>
			</div>
			<%@include file="components/common_modals.jsp" %>
			
</body>
</html>
