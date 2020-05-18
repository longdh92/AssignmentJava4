<%@page import="Utils.ShareHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login or register</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/prettyPhoto.css" rel="stylesheet">
<link href="css/price-range.css" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<link href="css/responsive.css" rel="stylesheet">
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
<link rel="shortcut icon" href="images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="images/ico/apple-touch-icon-57-precomposed.png">
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.scrollUp.min.js"></script>
<script src="js/price-range.js"></script>
<script src="js/jquery.prettyPhoto.js"></script>
<script src="js/main.js"></script>
</head>
<body>

	<c:choose>
		<c:when test="<%=ShareHelper.USER == null%>">
			<jsp:include page="section/header.jsp"></jsp:include>
		</c:when>
		<c:when test="<%=ShareHelper.USER != null%>">
			<jsp:include page="section/header1.jsp"></jsp:include>
		</c:when>
	</c:choose>
	<section id="form">
		<!--form-->
		<div class="container">
			<div class="row">
				<div class="col-sm-4 col-sm-offset-1">
					<div class="login-form">
						<!--login form-->
						<h2>Login to your account</h2>
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
						<form action="${pageContext.request.contextPath}/login"
							method="post">
							<input type="text" placeholder="Name" name="username"
								required="required"
								value="<%="1".equals(remember) ? username : ""%>" /> <input
								type="password" placeholder="Password" name="password"
								required="required"
								value="<%="1".equals(remember) ? password : ""%>" /> <span>
								<input type="checkbox" class="checkbox" name="remember"
								value="1" <%="1".equals(remember) ? "checked='checked'" : ""%> />
								Keep me signed in
							</span>
							<button type="submit" class="btn btn-default" name="command"
								value="login">Login</button>
							<br>
							<c:if test="${not empty message2}">
								<div class="alert alert-${alert2}">
									<strong>${message2}</strong>
								</div>
							</c:if>
						</form>
					</div>
					<!--/login form-->
				</div>
				<div class="col-sm-1">
					<h2 class="or">OR</h2>
				</div>
				<div class="col-sm-4">
					<div class="signup-form">
						<!--sign up form-->
						<h2>New User Signup!</h2>
						<form action="${pageContext.request.contextPath}/login"
							method="post">
							<input type="text" placeholder="Username" name="username1"
								required="required" /> <input type="email"
								placeholder="Email Address" name="email1" required="required" />
							<input type="password" placeholder="Password" name="password1"
								required="required" />
							<button type="submit" class="btn btn-default" name="command"
								value="register">Signup</button>
							<br>
							<c:if test="${not empty message1}">
								<div class="alert alert-${alert1}">
									<strong>${message1}</strong>
								</div>
							</c:if>
						</form>
					</div>
					<!--/sign up form-->
				</div>
			</div>
		</div>
	</section>
	<!--/form-->
	<jsp:include page="section/footer.jsp"></jsp:include>
	<%
		session.removeAttribute("message1");
		session.removeAttribute("alert1");
		session.removeAttribute("message2");
		session.removeAttribute("alert2");
	%>
</body>
</html>