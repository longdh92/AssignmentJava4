<%@page import="java.util.Map"%>
<%@page import="Entities.Product"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Entities.CartBean"%>
<%@page import="Utils.ShareHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Out</title>
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
		CartBean cartBean = (CartBean) session.getAttribute("CartBean");
		if (cartBean == null) {
			cartBean = new CartBean();
			session.setAttribute("CartBean", cartBean);
		}
		DecimalFormat format = new DecimalFormat("#,###,###,##0.00");
		int total = cartBean.total();
		double tax = Double.parseDouble(format.format((total * 0.1)));
		TreeMap<Product, Integer> list = cartBean.getListProduct();
	%>
	<c:choose>
		<c:when test="<%=ShareHelper.USER == null%>">
			<jsp:include page="section/header.jsp"></jsp:include>
		</c:when>
		<c:when test="<%=ShareHelper.USER != null%>">
			<jsp:include page="section/header1.jsp"></jsp:include>
		</c:when>
	</c:choose>
	<section id="cart_items">
		<div class="container">
			<div class="breadcrumbs">
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li class="active">Check out</li>
				</ol>
			</div>

			<!--/register-req-->

			<div class="shopper-informations">
				<div class="row">
					<div class="col-sm-3">
						<div class="shopper-info">
							<p>Shopper Information</p>
							<form
								action="${pageContext.request.contextPath}/CheckOutController"
								method="post">
								<input type="text" placeholder="Your name" name="yourname"
									required="required"> <input type="text"
									placeholder="Phone Number" name="phone" required="required">
								<input type="email" placeholder="Email" name="email"
									required="required"> <input type="text"
									placeholder="Address" name="address" required="required">
								<input type="hidden" name="total" value="<%=total%>"> <a
									class="btn btn-primary"
									href="CartBeanController?command=removeCart&idProduct=1">Cancel
									Purchase</a>
								<button class="btn btn-primary" type="submit" name="command"
									value="checkOut">Payment Confirm</button>
								<br>
								<br>
								<c:if test="${not empty message}">
									<div class="alert alert-${alert}">
										<strong>${message}</strong>
									</div>
								</c:if>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="review-payment">
				<h2>Review & Payment</h2>
			</div>

			<div class="table-responsive cart_info">
				<table class="table table-condensed">
					<thead>
						<tr class="cart_menu">
							<td class="image">Item</td>
							<td class="description"></td>
							<td class="price">Price</td>
							<td class="quantity">Quantity</td>
							<td class="total">Total</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<%
							for (Map.Entry<Product, Integer> entry : list.entrySet()) {
						%>
						<tr>
							<td class="cart_product"><a href=""><img
									src="images/home/<%=entry.getKey().getImage()%>" alt=""></a></td>
							<td class="cart_description">
								<h4>
									<a href=""><%=entry.getKey().getProductName()%></a>
								</h4>
								<p>
									Web ID:
									<%=entry.getKey().getIdProduct()%></p>
							</td>
							<td class="cart_price">
								<p>
									$<%=entry.getKey().getPrice()%></p>
							</td>
							<td class="cart_quantity">
								<div class="cart_quantity_button">
									<a class="cart_quantity_up"
										href="CartBeanController?command=addItem&idProduct=<%=entry.getKey().getIdProduct()%>">
										+ </a> <input class="cart_quantity_input" type="text"
										name="quantity" value="<%=entry.getValue()%>"
										autocomplete="off" size="2" disabled="disabled"> <a
										class="cart_quantity_down"
										href="CartBeanController?command=subItem&idProduct=<%=entry.getKey().getIdProduct()%>">
										- </a>
								</div>
							</td>
							<td class="cart_total">
								<p class="cart_total_price"><%=entry.getValue() * entry.getKey().getPrice()%></p>
							</td>
							<td class="cart_delete"><a class="cart_quantity_delete"
								href="CartBeanController?command=removeItem&idProduct=<%=entry.getKey().getIdProduct()%>"><i
									class="fa fa-times"></i></a></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td colspan="4">&nbsp;</td>
							<td colspan="2">
								<table class="table table-condensed total-result">
									<tr>
										<td>Cart Sub Total</td>
										<td>$<%=total%></td>
									</tr>
									<tr>
										<td>Tax</td>
										<td>$<%=tax%></td>
									</tr>
									<tr class="shipping-cost">
										<td>Shipping Cost</td>
										<td>Free</td>
									</tr>
									<tr>
										<td>Total</td>
										<td><span>$<%=total + tax%></span></td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<!--/#cart_items-->
	<jsp:include page="section/footer.jsp"></jsp:include>
	<%
		session.removeAttribute("message");
		session.removeAttribute("alert");
	%>
</body>
</html>