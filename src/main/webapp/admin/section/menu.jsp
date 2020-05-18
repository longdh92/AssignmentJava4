<%@page import="Utils.ShareHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="layoutSidenav_nav">
		<nav class="sb-sidenav accordion sb-sidenav-dark"
			id="sidenavAccordion">
			<div class="sb-sidenav-menu">
				<div class="nav">
					<div class="sb-sidenav-menu-heading">Core</div>
					<a class="nav-link"
						href="${pageContext.request.contextPath}/admin/admin.jsp"><div
							class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> Dashboard</a>
					<div class="sb-sidenav-menu-heading">Interface</div>
					<a class="nav-link collapsed" href="#" data-toggle="collapse"
						data-target="#collapsePages" aria-expanded="false"
						aria-controls="collapsePages"><div class="sb-nav-link-icon">
							<i class="fas fa-book-open"></i>
						</div> Pages
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div></a>
					<div class="collapse" id="collapsePages"
						aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav accordion"
							id="sidenavAccordionPages">
							<a class="nav-link collapsed" href="#" data-toggle="collapse"
								data-target="#pagesCollapseAuth" aria-expanded="false"
								aria-controls="pagesCollapseAuth">Authentication
								<div class="sb-sidenav-collapse-arrow">
									<i class="fas fa-angle-down"></i>
								</div>
							</a>
							<div class="collapse" id="pagesCollapseAuth"
								aria-labelledby="headingOne"
								data-parent="#sidenavAccordionPages">
								<nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link"
										href="${pageContext.request.contextPath}/admin/login.jsp">Login</a><a
										class="nav-link"
										href="${pageContext.request.contextPath}/admin/register.jsp">Register</a>
								</nav>
							</div>
						</nav>
					</div>
					<div class="sb-sidenav-menu-heading">Addons</div>
					<a class="nav-link"
						href="${pageContext.request.contextPath}/admin/table.jsp"><div
							class="sb-nav-link-icon">
							<i class="fas fa-table"></i>
						</div> Products</a> <a class="nav-link"
						href="${pageContext.request.contextPath}/admin/tableUser.jsp"><div
							class="sb-nav-link-icon">
							<i class="fas fa-table"></i>
						</div> Users</a>
				</div>
			</div>
			<div class="sb-sidenav-footer">
				<div class="small">Online:</div>
				<%=ShareHelper.ADMIN.getUsername()%>
			</div>
		</nav>
	</div>
</body>
</html>