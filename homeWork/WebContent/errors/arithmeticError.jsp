<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
    <!--   isErrorPage="true" 이 화면은 에러처리 화면이라는 뜻-->
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title> isErrorPage</title>
</head>
<body>
	<%
		//추가적인 에러정보를 확인할때 사용하는 것들
		String exceptionMsg=exception!=null ? exception.getMessage():"";
		ErrorData errorD = pageContext.getErrorData();
		int sc = errorD.getStatusCode();
		String url =errorD.getRequestURI();
	%>
		<%=url %> 방향으로 발생한 요청에서 <%=exception %> 예외발생
		예외응답코드 <%=sc %>
		
	
</body>
</html>