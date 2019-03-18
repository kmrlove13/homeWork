<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.enumpkg.serviceEnum"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<%
 	String includePage = (String)request.getAttribute("includePage");

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>index.jsp</title>
<LINK rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css"/>

<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></SCRIPT>
</head>

<body>
	<div id="top">
		<jsp:include page="/includee/topMenu.jsp" />
	</div>
	
	<div id="left">
		<jsp:include page="/includee/leftMenu.jsp" />
	</div>
	
	<div id="content">
	<%
	/* 출발지에서 도착지로 데이터를 전달하는 방법엔 스코프라는것이 필요함 
	dispatch든, redirect이든 데이터를 공유하진 못해 
	String id = request.getParameter("mem_id");
	if(StringUtils.isNotBlank(id)){
	<h4><%=id%님 로그인</h4> 보안취약,ㅡ 쿼리스트링을 조작할 수 있음
	 */		
	 
	if(StringUtils.isBlank(includePage)){
		String authId = (String)session.getAttribute("authId");
		if(StringUtils.isNotBlank(authId)){
			%>
			<h4><%=authId%>님 <a href="<%=request.getContextPath()%>/login/logOut.jsp"> 로그아웃</a></h4>
			<% 
		}else{
			%>
			<h4><a href="<%=request.getContextPath()%>/login/loginForm.jsp"> 로그인하러가기</a></h4>
			<%
		}
	}else{//leftMenu의 화면이 보여져야함
		pageContext.include(includePage);
	}
	%>
	<h4>web.xml(Deployment Descriptor)에 등록된 웰컴 페이지</h4>
	</div>
	
	<div id="footer">
		<jsp:include page="/includee/footerMenu.jsp" />
	</div>
	
</body>
</html>