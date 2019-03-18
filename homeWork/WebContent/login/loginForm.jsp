<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<%

	
%>
<body>
	<!--form의 주소는 절대방식, -->
	<form action ="<%=request.getContextPath() %>/login/loginCheck.jsp" method="post">
		<ul><!--VALUE> 초기값 설정, 널값이면 화이트스페이스로 바꿔주기-->
			<%
				//String mem_id = request.getParameter("mem_id");
				String mem_id = (String)session.getAttribute("failedId");
				//꺼낸다음엔 바로 지울수 있어야해 
				session.removeAttribute("faliedId");
			%><!--Objects.toString(mem_id,"") 널문자 대신에 ""사용 할수 있음 이 메소드는 -->
			<li>ID : <input type="text" name ="mem_id" value="<%=Objects.toString(mem_id,"")%>"/>
				<input type="checkbox" name="saveId" value="saved"/> 아이디기억하기 
			</li>	
			<li>PASS : <input type="text" name="mem_pass"/></li>
			<li><input type="submit" value ="로그인" /></li>	
<!-- 		일주일정도 기억해놓기 , 다시돌아왔을때 id값이 복원해야됨  -->
<!-- 		아이디, 체크박스 상태 두가지가 복원되야됨  -->
<!-- 		체크가 안되었다면 기억하지 않겠다는 거니까 저장된 아이디 지워져 maxAge=0  -->
<!-- 		인증에 성공한다는건 loginCheck 에서 확인 복원은 loginForm에서 해야됨 -->
		
		</ul>
	</form>

</body>
</html>