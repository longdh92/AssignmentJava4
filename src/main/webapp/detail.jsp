<%@page import="Entities.Product"%>
<%@page import="Utils.ShareHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product detail</title>
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
	<%
		Product product = (Product) request.getAttribute("ProductFound");
	%>
	<c:if test="<%=product == null%>">
		<c:redirect url="index.jsp"></c:redirect>
	</c:if>
	<c:if test="<%=product != null%>">
		<c:set var="product1" value="<%=product%>"></c:set>
	</c:if>
	<c:choose>
		<c:when test="<%=ShareHelper.USER == null%>">
			<jsp:include page="section/header.jsp"></jsp:include>
		</c:when>
		<c:when test="<%=ShareHelper.USER != null%>">
			<jsp:include page="section/header1.jsp"></jsp:include>
		</c:when>
	</c:choose>
	<jsp:include page="section/slider.jsp"></jsp:include>
	<section>
		<div class="container">
			<div class="row">
				<jsp:include page="section/category.jsp"></jsp:include>
				<div class="col-sm-9 padding-right">
					<div class="product-details">
						<!--product-details-->
						<div class="col-sm-5">
							<div class="view-product">
								<img src="images/home/${product1.image}" alt="" width="180"
									height="180" />
							</div>
							<div id="similar-product" class="carousel slide"
								data-ride="carousel">

								<!-- Wrapper for slides -->
								<div class="carousel-inner">
									<div class="item active">
										<a href=""><img src="images/product-details/similar1.jpg"
											alt=""></a> <a href=""><img
											src="images/product-details/similar2.jpg" alt=""></a> <a
											href=""><img src="images/product-details/similar3.jpg"
											alt=""></a>
									</div>
									<div class="item">
										<a href=""><img src="images/product-details/similar1.jpg"
											alt=""></a> <a href=""><img
											src="images/product-details/similar2.jpg" alt=""></a> <a
											href=""><img src="images/product-details/similar3.jpg"
											alt=""></a>
									</div>
									<div class="item">
										<a href=""><img src="images/product-details/similar1.jpg"
											alt=""></a> <a href=""><img
											src="images/product-details/similar2.jpg" alt=""></a> <a
											href=""><img src="images/product-details/similar3.jpg"
											alt=""></a>
									</div>

								</div>

								<!-- Controls -->
								<a class="left item-control" href="#similar-product"
									data-slide="prev"> <i class="fa fa-angle-left"></i>
								</a> <a class="right item-control" href="#similar-product"
									data-slide="next"> <i class="fa fa-angle-right"></i>
								</a>
							</div>

						</div>
						<div class="col-sm-7">
							<div class="product-information">
								<!--/product-information-->
								<img src="images/product-details/new.jpg" class="newarrival"
									alt="" />
								<h2>${product1.productName}</h2>
								<p>Web ID: ${product1.idProduct}</p>
								<img src="images/product-details/rating.png" alt="" /><br>
								<span> <span>US $${product1.price}</span> <a
									href="CartBeanController?command=insertItem&idProduct=${product1.idProduct}"
									class="btn btn-default add-to-cart"><i
										class="fa fa-shopping-cart"></i>Add to cart</a>
								</span>
								<p>
									<b>Availability:</b> In Stock
								</p>
								<p>
									<b>Condition:</b> New
								</p>
								<p>
									<b>Brand:</b> E-SHOPPER
								</p>
								<a href=""><img src="images/product-details/share.png"
									class="share img-responsive" alt="" /></a>
							</div>
							<!--/product-information-->
						</div>
					</div>
					<!--/product-details-->
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="section/footer.jsp"></jsp:include>

</body>
</html>