<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
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
					<div class="col-lg-7">
						<div class="card shadow-lg border-0 rounded-lg mt-5">
							<div class="card-header">
								<h3 class="text-center font-weight-light my-4">Create
									Account</h3>
							</div>
							<div class="card-body">
								<form method="post"
									action="${pageContext.request.contextPath}/AdminController" />
								<div class="form-group">
									<label class="small mb-1">Username</label><input
										class="form-control py-4" aria-describedby="emailHelp"
										placeholder="Enter Username" name="username1"
										required="required" />
								</div>
								<div class="form-group">
									<label class="small mb-1" for="inputEmailAddress">Email</label><input
										class="form-control py-4" id="inputEmailAddress" type="email"
										aria-describedby="emailHelp" placeholder="Enter email address"
										name="email1" required="required" />
								</div>
								<div class="form-row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="small mb-1" for="inputPassword">Password</label><input
												class="form-control py-4" id="inputPassword" type="password"
												placeholder="Enter password" name="password1"
												required="required" />
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="small mb-1" for="inputConfirmPassword">Confirm
												Password</label><input class="form-control py-4"
												id="inputConfirmPassword" type="password"
												placeholder="Confirm password" name="confirm1"
												required="required" />
										</div>
									</div>
								</div>
								<div class="form-group mt-4 mb-0">
									<button class="btn btn-primary btn-block" name="command"
										value="create">Create Account</button>
								</div>
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
									<a href="${pageContext.request.contextPath}/admin/login.jsp">Have
										an account? Go to login</a>
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