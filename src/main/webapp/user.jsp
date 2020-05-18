<%@page import="Utils.ShareHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update your profile</title>
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
					<!--/edit form-->
				</div>
				<div class="col-sm-4">
					<div class="signup-form">
						<!--sign up form-->
						<h2>Edit Profile!</h2>
						<form action="login" method="post">
							<label>Username</label> <input type="text" placeholder="Username"
								name="username2" required="required"
								value="<%=ShareHelper.USER.getUsername()%>" disabled="disabled" />
							<label>Email</label><input type="email"
								placeholder="Email Address" name="email2" required="required"
								value="<%=ShareHelper.USER.getEmail()%>" /> <label>Password</label><input
								type="password" placeholder="Password" name="password2"
								required="required" value="<%=ShareHelper.USER.getPassword()%>" />
							<button type="submit" class="btn btn-default" name="command"
								value="update">Update</button>
							<br>
							<c:if test="${not empty message3}">
								<div class="alert alert-${alert3}">
									<strong>${message3}</strong>
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
		session.removeAttribute("message3");
		session.removeAttribute("alert3");
	%>
</body>
</html>