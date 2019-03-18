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

	주의 : ***i프레임 사용하지 말 것 클라이언트 모듈화는 톰캣에 과부하게 걸림 서버에서 각 요청들이 따로따로 클라이언트로 보내는 거기 때문에 
		톰캣에 과부하가 걸릴수 잇음  
<%
	pageContext.include("/06/pagePart1.jsp");//상대경로를 판단할때는 최종적으로 브라우저가 사용하고 있는 주소가 기준 
%>
	<IFRAME src="<%=request.getContextPath()%>/06/pagePart1.jsp"></IFRAME>

<hr />
	<IFRAME src="<%=request.getContextPath()%>/06/pagePart2.jsp"></IFRAME>
<%
	pageContext.include("/06/pagePart2.jsp");

%>	

</body>
</html>