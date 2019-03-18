

<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.AlbaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
   //보통이자리에서 인코딩을 한당
    request.setCharacterEncoding("UTF-8");
   %> 
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>actionTagDesc</title>
</head>
<body>

<h4> jsp 액션태그 ActionTag</h4>
<pre>

	:JSP스펙에 따라 기본 제공되는 커스텀 태그의 일종으로 서버사이드에서 동작하는 태그의 형태 
	커스텀태그는 뭔지? 일반 태그와 어떤식으로 다르게 사용하나?
	나만의 커스텀태그를 만들때 종종 쓰이고 거의 쓰이진 않음 
	
	커스텀태그 : 개발자에 의해 새롭게 만든 태그 
		&lt;prefix:tagname 속성들..&gt; prefix를 nameSpace라고도 부름 
	
	일반태그 : 거의 안쓰임 , 자바소스로 만들어놓은것뿐 ,
	 
		&lt;jsp:attribute name="".&gt;
	자바빈에 따라 만들어지는건 모두 빈이라고 부름 
	자바코드를 만들지않고 객체를 생성할때 jsp: useBean 사용 
	<%-- <jsp:forward page="/05/sessionDesc.jsp"/> --%>
	<%-- <jsp:include page="/05/sessionDesc.jsp" />	==pageContext의 include와 결과가 같다. --%>
	<%--객체를 생성할 클래스를 작성하면 저절로 객체 생성, --%>
	
	<jsp:useBean id="albaVO" class="kr.or.ddit.vo.AlbaVO" scope="request"></jsp:useBean>
	<%-- <jsp:setProperty property="age" name="albaVO" value="34 "/> setter역할 --%>
	<%-- <jsp:setProperty property="age" name="albaVO"  param="age"/> setter역할 --%>
	<jsp:setProperty property="*" name="albaVO"/> <%-- 파라미터명과 vo의 프로퍼티를 전체를 살펴봐서 같은 프로퍼티에 값을 넣는다.setter역할--%>
	<jsp:getProperty property="age" name="albaVO"/> <%-- setter역할--%>
	<jsp:getProperty property="name" name="albaVO"/> <%-- setter역할--%>
	
	<%--
		/* AlbaVO albaVO=(AlbaVO) request.getAttribute("albaVO");
		if(albaVO==null){
			albaVO  = new AlbaVO();
			request.setAttribute("albaVO", albaVO);
		}
		albaVO.setAge(19);  */
		albaVO.setAge(new Integer(request.getParameter("age")));
		albaVO.setAge(34);
		
	--%>	
	

</pre>
</body>
</html>