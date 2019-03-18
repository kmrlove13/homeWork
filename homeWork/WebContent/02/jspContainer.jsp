<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/jspContainer.jsp</title>
</head>
<body>
	<h4>JSP Container</h4>
		<pre>
		
			WAS/Servlet Container/MiddleWare/JSP Container
			: JSP에 대한 라이프사이클 관리 권한 및 운영에 대한 주체 
			
			최초의 요청에 대해 컨테이너의 동작 구조 
			1. 요청된 jsp페이지에 대해 서블릿 소스 파싱(.java).
			2. 컴파일>클래스 생성 
			3. 싱글톤 객체 생성
			(두번째 이후의 요청에 대해서는 4번부터 )
			4. _JSPService 메소드(요청 콜백)를 호출하여 요청 처리 
			
		
		</pre>



</body>
</html>