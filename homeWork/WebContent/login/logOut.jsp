<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<%

	//session scope안의 모든 내용을 차례대로 지움 
	session.invalidate();
	
	//다시 인덱스 페이지로
	//모든 요청이 끝났으니 최초요청을 가져갈 필요가 없음 
	//인증을 처리하는 방식은 모두 redirect
	//만료가된 세션에 대해서는 새로운 식별자가 만들어져야 하고 만들어질려면 새로 요청을 받아야 하니까 
	//뒤에 아무것도 안쓰면 ㅇ잡혀잇는 웰컴페이지로 간다 web.xml에 설정되어 있는곳
	response.sendRedirect(request.getContextPath()+"/");

%>



</body>
</html>