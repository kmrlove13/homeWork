<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@page import="javax.xml.crypto.Data"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
   <%--page language="java 자바라는 언어로 jsp가 이루어지고 있다.,pageEncoding="UTF-8 이페이지의 소스를 작성할때 이 방법으로--%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/standard.jsp</title>
</head>
<body>
	<h4>JSP Java Server Page</h4>
	<pre>
		:템플릿 기반의 자바 언어를 기초로 한 스크립트 언어 
		소스 구성 요소
		1. 정적 텍스트 : 텍스트, html, javascript, jquery 작성한 그대로 client로 표시
		2. 스크립트 구성 요소 : server side 실행 코드 
			1) 지시자(directive) : &lt;%@ 지시자명 속성들(이름=값) %&gt;
				- jsp페이지에 부가 설정이나 환경 설정에 사용됨, 실행코드 아닙니다.
				page (필수지시자)
				taglib(나중에)
				include(나중에)
			2) 스크립틀릿 : &lt;%자바코드%&gt;-지역코드화 (_JspService)
				<%
					String now  = new Date().toString();
				%>
			3) 표현식 : &lt;%=브라우저에 출력할 결과,%&gt; 지역코드화 됨
				<%= %>
			4) 선언부 :&lt;%! %&gt; 지역코드화가 되지 않는다., 메서드를 선언할려면 여기서 
				<%!
					String outter ="전역 변수의 값";
					public void test(){
						
						
					}
				%>
			톰캣이라는 컨테이너가 어떤 역할을 하느냐에 따라 개발자가 불편하냐 편하냐 
			수정이 발생할때 마다 자동으로 반복
			5) 주석 : <%-- --%> JSP는 여러 언어들이 섞인곳이라 잘써야됨
				클라이언트사이드 주석: Html, javaScript, 주석을 사용하다가 어떤 코드중에 일부가 포함되어서 나가버릴수 잇어, 클라이언트 응답데이터에 
				실려서 나가 버림, 보안때문에 사용 안하는것이 좋아
				<!-- html comment-->
				<SCRIPT type="text/javascript">
				//javaScript comment
				</SCRIPT>
				서버사이드 주석: java, jsp 응답데이터에 포함 안되서
				<%
				//java comment
				%>
				<%--
				jsp comment
				--%>
				
				
		3. 기본 객체
		4. 액션 태그
		5. EL(표현언어)
		6. JSTL
	</pre>	
	
</body>
</html>