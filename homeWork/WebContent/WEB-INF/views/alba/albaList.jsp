<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Set"%>
<%@page import="kr.or.ddit.vo.AlbaVO"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>albaList.jsp</title>
<SCRIPT type="text/javascript">

	function clickHandler(albaId) {
		location.href ="<%=request.getContextPath()%>/albaView.do?who="+albaId;
	}



</SCRIPT>


</head>
<body>
	
<!--request 스코프에서 albaMap값을 찾고, 없으면 강제로 하나 만들어줌 객체를, 그래서 널포인트가 안생김 -->
<!--다시 알바폼으로 가야됨, -->

<a href="<%=request.getContextPath() %>/albaregist.do">신규등록</a>
<jsp:useBean id="albaMap" class="java.util.LinkedHashMap" scope="request"/>
<!--useBean은 linkedMap의 지네릭스를 설정한게 아니라서 entry로 받는게 아니라 Object로 받아야함 -->
<%
	String html = "";	
	StringBuffer buff= new StringBuffer();
	
	for(Object obj : albaMap.entrySet()){
		Entry<String, AlbaVO> entry =(Entry<String, AlbaVO>)obj;
		AlbaVO vo =entry.getValue();
		String patt = "<td><a href='javascript:clickHandler(\""+vo.getId
				
				()+"\")'>%s</a></td>";
			buff.append("<tr>");
			buff.append(String.format(patt,vo.getId()));
			buff.append(String.format(patt,vo.getName()));
			buff.append(String.format(patt,vo.getAddr()));
			buff.append(String.format(patt,vo.getHp()));
			buff.append("</tr>");
	}
	
	html=buff.toString();

%>


<TABLE>
	<THEAD>
		<tr>
		<th>알바생아이디</th>
		<th>이름</th>
		<th>나이</th>
		<th>주소</th>
		<th>휴대폰</th>
		</tr>
	</THEAD>
		<%=html %>
</TABLE>



</body>
</html>