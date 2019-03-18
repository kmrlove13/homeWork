<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- errorPage="/errors/localError.jsp" 지역적인 방법, 페이지 지시자 에러> web.xml>에러코드 순으로 확인 -->
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<h4>웹어플리케이션의 에러 처리 </h4>
<pre>
	에러 처리 방법 
	**에러페이지에 내용이 별로 없으면 브라우저별로 무시하는곳도 있음 
	그러니 좀 있어보이게 만들고, 모든 브라우저가 무시할수없게 만들어야함
	1. jsp페이지를 대상으로 한 지역적 처 ,리 > 귀찮음, 너무 많음 , page지시자의 errorPage속성을 통한 처리자 지정. 
	2. 어플리케이션을 대상으로 한 전역 처리. >web.xml(error-page).
	 	1)발생한 예외 타입 : exception-type/location
	 	2)발생한 에러 상태 코드: error-code/location
	 	
	예외나 에러발생시 에러처리자가 결정되는 우선 순위, 제일 많이 사용하는건 에러코드 
	커스텀예외에서 주로 처리 -exception-type(블로그전용)
	시스템관리자가 단독으로 사용할때 처리 - errorPage
		errorPage > exception-type > error-code	
</pre>

</body>
</html>
	
<%
		if(1==1){//데드코드 속이기위해 
			throw new NullPointerException("강제발생예외");
		}
		
int number=5;
		//int result=5/0;
		//0하고 0d는 달라, 
		double res = number/0d;
		BigDecimal numberBig = new BigDecimal(number);
		BigDecimal zeroBig = new BigDecimal(0);
		BigDecimal res1 = zeroBig.divide(zeroBig);
	%>
