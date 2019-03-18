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

	<h4> 영역scope</h4>
	<pre>
		: 속성데이터를 공유하기 위한 저장 공간 
		속성attribute : Scope를 통해 공유되는 데이터(이름: 값의 형태로 저장) 
		각 Scope에 대한 제어권을 가진 cx기본객체와 생명주기가 동일한 영역.
		기준: 어디까지 공유가 가능한가?
		
		page scope: pageContext를 통해 접근, 하나의 jsp페이지 내에서만 유효한 영역
		request scope : request를 통해 접근, 하나의 요청이 생존하는 동안만 유효한 영역
		session scope : session을 통해 접근, 한 세션 내에서만 유효한 영역
			한 세션 : 유저가 브라우저를 발생시키는 동안 생성, 시간이 만료되기까지
		application scope: servletContext를 통해 접근, 하나의 어플리케이션내에서 공유되는 영역 
			jsp, servlet(getter)에서도 접근 가능
			
		<%
			pageContext.setAttribute("pageAttr", "페이지 영역의 속성");
			request.setAttribute("requestAttr", "리퀘스트 영역의 속성");
			session.setAttribute("sessiontAttr", "세션 영역의 속성");
			application.setAttribute("applicationAttr", "어플리케이션 영역의 속성");
			
			//요청데이터 넘겼으니 리퀘스트 영역의 속성이 살아잇음 
			//어떤 이동을 하느냐에 따라 영역의 속성 가능 여부가 다름
			//pageContext.forward("/06/viewAttribute.jsp");
			//pageContext.include("/06/viewAttribute.jsp");
			
			response.sendRedirect(request.getContextPath()+"/06/viewAttribute.jsp");
			
		%>	
		여기서부터는 다시 돌아온 이후 
		<%=pageContext.getAttribute("pageAttr") %>
		<%=request.getAttribute("requestAttr") %>
		<%=session.getAttribute("sessiontAttr") %>
		<%=application.getAttribute("applicationAttr") %>
		
		<!--<a href="viewAttribute.jsp"> 속성 데이터 확인하러가기</a>  -->
	
	</pre>


</body>
</html>