<%@page import="Utils.ShareHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="${pageContext.request.contextPath}/admin/css/styles.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>
</head>
<body class="bg-primary">

	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-lg-5">
						<div class="card shadow-lg border-0 rounded-lg mt-5">
							<div class="card-header">
								<h3 class="text-center font-weight-light my-4">Login</h3>
							</div>
							<div class="card-body">
								<%
									String username = "", password = "", remember = "";
									Cookie[] cookies = request.getCookies();
									if (cookies != null) {
										for (Cookie cookie : cookies) {
											if (cookie.getName().equals("cookieUsername")) {
												username = cookie.getValue();
											} else if (cookie.getName().equals("cookiePassword")) {
												password = cookie.getValue();
											} else if (cookie.getName().equals("cookieRemember")) {
												remember = cookie.getValue();
											}
										}
									}
								%>
								<form method="post"
									action="${pageContext.request.contextPath}/AdminController">
									<div class="form-group">
										<label class="small mb-1" for="inputEmailAddress">Username</label><input
											class="form-control py-4" required="required"
											placeholder="Enter username" name="username"
											value="<%="1".equals(remember) ? username : ""%>" />
									</div>
									<div class="form-group">
										<label class="small mb-1" for="inputPassword">Password</label><input
											class="form-control py-4" type="password" required="required"
											placeholder="Enter password" name="password"
											value="<%="1".equals(remember) ? password : ""%>" />
									</div>
									<div class="form-group">
										<div class="custom-control custom-checkbox">
											<input class="custom-control-input"
												id="rememberPasswordCheck" type="checkbox" name="remember"
												value="1"
												<%="1".equals(remember) ? "checked='checked'" : ""%> /><label
												class="custom-control-label" for="rememberPasswordCheck">Remember
												password</label>
										</div>
									</div>
									<button class="btn btn-primary" name="command" value="login">Login</button>
									<br>
									<br>
									<c:if test="${not empty message}">
										<div class="alert alert-${alert}">
											<strong>${message}</strong>
										</div>
									</c:if>
								</form>
							</div>
							<div class="card-footer text-center">
								<div class="small">
									<a href="${pageContext.request.contextPath}/admin/register.jsp">Need
										an account? Sign up!</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</main>
		</div>
		<div id="layoutAuthentication_footer">
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2019</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/admin/js/scripts.js"></script>
	<%
		session.removeAttribute("message");
		session.removeAttribute("alert");
	%>
</body>
</html>