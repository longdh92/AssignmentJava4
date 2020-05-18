<%@page import="Entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="DAO.CategoryDAO"%>
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
	<%
		CategoryDAO dao = new CategoryDAO();
		List<Category> list = dao.getAllCategories();
	%>
	<div class="col-sm-3">
		<div class="left-sidebar">
			<h2>Category</h2>
			<div class="panel-group category-products" id="accordian">
				<!--category-productsr-->
				<c:forEach var="category" items="<%=list%>">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a href="#">${category}</a>
							</h4>
						</div>
					</div>
				</c:forEach>
			</div>
			<!--/category-products-->
		</div>
	</div>

</body>
</html>