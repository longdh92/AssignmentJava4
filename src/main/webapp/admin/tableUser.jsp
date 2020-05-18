<%@page import="Entities.User"%>
<%@page import="DAO.UserDao"%>
<%@page import="Utils.ShareHelper"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User</title>
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
		UserDao dao = new UserDao();
		List<User> list = dao.getAllUser();
	%>
	<jsp:include page="section/header.jsp"></jsp:include>
	<div id="layoutSidenav">
		<jsp:include page="section/menu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
			<div class="container-fluid">
				<h1 class="mt-4">Users</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a href="#">Dashboard</a></li>
					<li class="breadcrumb-item active">Users</li>
				</ol>
				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-table mr-1"></i>User Detail
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
										<th>Username</th>
										<th>Email</th>
										<th>Role</th>
										<th>Edit</th>
										<th>Remove</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>ID</th>
										<th>Username</th>
										<th>Email</th>
										<th>Role</th>
										<th>Edit</th>
										<th>Remove</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="user" items="<%=list%>">
										<tr>
											<td>${user.idUser}</td>
											<td>${user.username}</td>
											<td>${user.email}</td>
											<td><c:if test="${user.userRole}">Admin</c:if> <c:if
													test="${user.userRole == false}">Customer</c:if></td>
											<td><a
												href="${pageContext.request.contextPath}/AdminController?command=editUser&idUser=${user.idUser}">Edit</a></td>
											<td><a
												href="${pageContext.request.contextPath}/AdminController?command=removeUser&idUser=${user.idUser}">Remove</a></td>
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