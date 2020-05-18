<%@page import="Utils.ShareHelper"%>
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
<title>Products</title>
<link href="${pageContext.request.contextPath}/admin/css/styles.css"
	rel="stylesheet" />
<link
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" crossorigin="anonymous" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<c:if test="<%=ShareHelper.ADMIN == null%>">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>
	<%
		ProductDAO dao = new ProductDAO();
		List<Product> list = dao.getAllProducts();
	%>
	<jsp:include page="section/header.jsp"></jsp:include>
	<div id="layoutSidenav">
		<jsp:include page="section/menu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
			<div class="container-fluid">
				<h1 class="mt-4">Products</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a href="#">Dashboard</a></li>
					<li class="breadcrumb-item active">Products</li>
				</ol>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-table mr-1"></i>Products Detail
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<br>
							<c:if test="${not empty message}">
								<div class="alert alert-${alert}">
									<strong>${message}</strong>
								</div>
							</c:if>
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th>ID</th>
										<th>Name</th>
										<th>Price ($)</th>
										<th>Image</th>
										<th>Category</th>
										<th>Edit</th>
										<th>Remove</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>ID</th>
										<th>Name</th>
										<th>Price ($)</th>
										<th>Image</th>
										<th>Category</th>
										<th>Edit</th>
										<th>Remove</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="product" items="<%=list%>">
										<tr>
											<td>${product.idProduct}</td>
											<td>${product.productName}</td>
											<td>$${product.price}</td>
											<td><img
												src="${pageContext.request.contextPath}/admin/images/home/${product.image}"
												width="180" height="180" /></td>
											<td>${product.idCategory}</td>
											<td><a
												href="${pageContext.request.contextPath}/ProductController?command=editProduct&idProduct=${product.idProduct}">Edit</a></td>
											<td><a
												href="${pageContext.request.contextPath}/ProductController?command=removeProduct&idProduct=${product.idProduct}">Remove</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			</main>
			<jsp:include page="section/footer.jsp"></jsp:include>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/admin/assets/demo/datatables-demo.js"></script>
	<%
		session.removeAttribute("message");
		session.removeAttribute("alert");
	%>
</body>
</html>