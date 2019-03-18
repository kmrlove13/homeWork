<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
	<meta name="generator" content="Jekyll v3.8.5">
	<title>Dashboard Template · Bootstrap</title>

	<link rel="canonical" href="https://getbootstrap.com/docs/4.3/examples/dashboard/">

	<!-- Bootstrap core CSS -->
	<link
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		crossorigin="anonymous">

<style>
	.bd-placeholder-img {
		font-size: 1.125rem;
		text-anchor: middle;
		-webkit-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}

	@media ( min-width : 768px) {
		.bd-placeholder-img-lg {
			font-size: 3.5rem;
		}
	}
</style>
<!-- Custom styles for this template -->
	<link href="<%=request.getContextPath()%>/css/dashboard.css"rel="stylesheet">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>

</head>
<body>
	<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
		<a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">home</a>
		
		<!--상단메뉴바-->
		<jsp:include page="/includee/topMenu.jsp" />
		
		<ul class="navbar-nav px-3">
			<li class="nav-item text-nowrap">
			<%
				String authId = (String) session.getAttribute("authId");
				if (StringUtils.isNotBlank(authId)) {
					%>
					<a class="nav-link" href="<%=request.getContextPath()%>/login/logOut.jsp"> 로그아웃</a>
					<%
				} else {
					%>
					<a class="nav-link" href="<%=request.getContextPath()%>/login/loginForm.jsp">
						로그인하러가기</a>
					<%
				}
				%>
			</li>
		</ul>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<nav class="col-md-2 d-none d-md-block bg-light sidebar">
				<div class="sidebar-sticky">
					<!--좌측 메뉴-->
					<jsp:include page="/includee/leftMenu.jsp" />
				</div>
			</nav>
			
			<!--컨텐츠영역-->
			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
				<%
					String includePage = (String) request.getAttribute("includePage");
					
				if (StringUtils.isBlank(includePage)) {
				%>	
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">web.xml(Deployment Descriptor)에 등록된 웰컴 페이지</h1>
				</div>
				<% 
			} else {//leftMenu의 화면이 보여져야함
				pageContext.include(includePage);
			}
			%>

			</main>
		</div>
	</div>


	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o"
		crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
</body>
</html>
