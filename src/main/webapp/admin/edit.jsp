<%@page import="java.util.List"%>
<%@page import="DAO.CategoryDAO"%>
<%@page import="Entities.Category"%>
<%@page import="Entities.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update or Insert Product</title>
<link href="${pageContext.request.contextPath}/admin/css/styles.css"
	rel="stylesheet" />
<link
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" crossorigin="anonymous" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="js/jquery-3.4.1.min.js"></script>
</head>
<body>
	<%
		Product product = (Product) session.getAttribute("product");
		if (product == null) {
			product = new Product();
		}
		CategoryDAO dao = new CategoryDAO();
		List<Category> list = dao.getAllCategories();
	%>
	<jsp:include page="section/header.jsp"></jsp:include>
	<div id="layoutSidenav">
		<jsp:include page="section/menu.jsp"></jsp:include>
		<div class="card-body">
			<form method="post"
				action="${pageContext.request.contextPath}/InsertUpdateController"
				id="edit" enctype="multipart/form-data">
				<div class="form-row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1" for="inputFirstName">Product ID</label><input
								class="form-control py-4" type="text"
								value="${product.idProduct}" readonly="readonly"
								name="idProduct" />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1" for="inputLastName">Product
								Name</label><input class="form-control py-4" type="text"
								value="${product.productName}" name="productName" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="small mb-1" for="inputEmailAddress">Price</label><input
						class="form-control py-4" type="number"
						aria-describedby="emailHelp" value="${product.price}" name="price" />
				</div>
				<div class="form-row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1" for="inputPassword">Image</label>
						</div>
						<div class="form-group">
							<img src="images/home/${product.image}" id="avatar" alt="image"
								width="180" height="180" /> <input type="file" name="file"
								value="${product.image}" onchange="readURL(this)"> <input
								type="hidden" name="image" value="${product.image}">
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1">Category</label><br> <select
								id="category" class="form-control" name="category">
								<c:forEach var="category" items="<%=list%>">
									<option value="${category}"
										<c:if test="${product.idCategory.idCategory == category.idCategory}"> selected </c:if>>${category}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
				<div>
					<button class="btn btn-primary" name="command"
						value="insertProduct">Insert</button>
					<button class="btn btn-primary" name="command"
						value="updateProduct">Update</button>
				</div>
				<br>
				<c:if test="${not empty message}">
					<div class="alert alert-${alert}">
						<strong>${message}</strong>
					</div>
				</c:if>
			</form>
		</div>
	</div>
	<jsp:include page="section/footer.jsp"></jsp:include>
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

	<script type="text/javascript">
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#avatar').attr('src', e.target.result).width(180)
							.height(180);
				};

				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>
	<%
		session.removeAttribute("message");
		session.removeAttribute("alert");
	%>
</body>
</html>