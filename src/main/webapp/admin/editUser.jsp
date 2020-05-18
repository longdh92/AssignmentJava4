<%@page import="Entities.User"%>
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
<title>Update User</title>
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
		User user = (User) session.getAttribute("user");
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
							<label class="small mb-1" for="inputFirstName">User ID</label><input
								class="form-control py-4" type="text" value="${user.idUser}"
								readonly="readonly" name="idUser" />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1" for="inputLastName">Username</label><input
								class="form-control py-4" type="text" value="${user.username}"
								name="username" readonly="readonly" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="small mb-1" for="inputEmailAddress">Email</label><input
						class="form-control py-4" type="email"
						aria-describedby="emailHelp" value="${user.email}" name="email"
						required="required" />
				</div>
				<div class="form-row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1" for="inputFirstName">Password</label><input
								class="form-control py-4" type="password"
								value="${user.password}" name="password" required="required" />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="small mb-1" for="inputLastName">Confirm
								password</label><input class="form-control py-4" type="password"
								value="${user.password}" name="confirm" required="required" />
						</div>
					</div>
				</div>
				<div class="form-group mt-4 mb-0">
					<button class="btn btn-primary btn-block" name="command"
						value="updateUser">Update</button>
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
	<%
		session.removeAttribute("message");
		session.removeAttribute("alert");
	%>
</body>
</html>