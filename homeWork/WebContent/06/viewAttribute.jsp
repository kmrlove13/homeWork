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

	<pre>
		<%=pageContext.getAttribute("pageAttr") %>
		<%=request.getAttribute("requestAttr") %>
		<%=session.getAttribute("sessiontAttr") %>
		<%=application.getAttribute("applicationAttr") %>
	</pre>




</body>
</html>