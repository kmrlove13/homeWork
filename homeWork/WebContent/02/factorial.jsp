<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<h4>팩토리얼 연산</h4>
	
	<%
		int param = 1;	
		
		String paramStr = request.getParameter("number");
		if(StringUtils.isNumeric(paramStr)){
			param = Integer.parseInt(paramStr);
		}
		
	%>
	
	<form>
		<input type="number" name="number" value=<%=param%> />
		<input type="number" name="결과" value=<%=reCall(param)%> />
		<input type="submit" value="시~작"/>
	</form>

	<%!//일반 팩토리얼
		public int factorial(int param){
			int res = 1;
			for(int i = param; i > 1; i--){
				res *= i;
			}
			return res;
		}
		
		//재귀호출
		public int reCall(int param){
			int res = 1;
			if(param==1){
				res =1;
			}else{
				res = param*reCall(param-1); 
			}
			return res;
		}
	%>	
	
	<SPAN><%=param%>! = <%= factorial(param)%></SPAN>



</body>
</html>