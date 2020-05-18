<%@page import="Entities.CartBean"%>
<%@page import="Entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="DAO.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		ProductDAO dao = new ProductDAO();
		List<Product> list = dao.getAllProducts();
		CartBean cartBean = (CartBean) session.getAttribute("CartBean");
		if (cartBean == null) {
			cartBean = new CartBean();
			session.setAttribute("CartBean", cartBean);
		}
	%>
	<%
		int start = 0;
		int end = 6, a = 0, b = 0;
		if (list.size() < end) {
			end = list.size();
		}
		if (request.getParameter("start") != null) {
			start = Integer.parseInt(request.getParameter("start"));
		}
		if (request.getParameter("end") != null) {
			end = Integer.parseInt(request.getParameter("end"));
		}
		List<Product> list1 = dao.getListProductByPagination(list, start, end);
	%>
	<div class="col-sm-9 padding-right">
		<div class="features_items">
			<!--features_items-->
			<h2 class="title text-center">Products</h2>

			<c:forEach var="product" items="<%=list1%>">
				<div class="col-sm-4">
					<div class="product-image-wrapper">
						<div class="single-products">
							<div class="productinfo text-center">
								<img src="images/home/${product.image}" alt="" width="180"
									height="180" />
								<h2>$${product.price}</h2>
								<p>${product.productName}</p>
								<a
									href="CartBeanController?command=insertItem&idProduct=${product.idProduct}"
									class="btn btn-default add-to-cart"><i
									class="fa fa-shopping-cart"></i>Add to cart</a>
							</div>
							<div class="product-overlay">
								<div class="overlay-content">
									<h2>$${product.price}</h2>
									<p>${product.productName}</p>
									<a
										href="CartBeanController?command=insertItem&idProduct=${product.idProduct}"
										class="btn btn-default add-to-cart"><i
										class="fa fa-shopping-cart"></i>Add to cart</a>
								</div>
							</div>
						</div>
						<div class="choose">
							<ul class="nav nav-pills nav-justified">
								<li><a href="#"><i class="fa fa-plus-square"></i>Add to
										wishlist</a></li>
								<li><a href="#"><i class="fa fa-plus-square"></i>Add to
										compare</a></li>
							</ul>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<ul class="pagination">
			<%
				int limit = list.size() / 6;
				if (limit * 6 < list.size()) {
					limit += 1;
				}
				for (int i = 1; i <= limit; i++) {
					a = (i - 1) * 6;
					b = i * 6;
					if (b > list.size()) {
						b = list.size();
					}
			%>
			<li class="btn"><a href="index.jsp?start=<%=a%>&end=<%=b%>"><%=i%></a></li>
			<%
				}
			%>
			<li><a href="index.jsp?start=<%=a%>&end=<%=b%>">&raquo;</a></li>
		</ul>
		<!--features_items-->

	</div>

</body>
</html>