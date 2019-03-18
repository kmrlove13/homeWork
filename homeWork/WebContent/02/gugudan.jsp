<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>02/gugudan.jsp</title>
<script src="/webStudy01/js/jquery-3.3.1.min.js"></script>

<STYLE type="text/css">
.yellow {
	background-color: yellow;
}
</STYLE>



</head>
<body>

<%
	int minDan = 2;
	int maxDan = 9;
	String minStr = request.getParameter("minDan");
	String maxStr = request.getParameter("maxDan");
	
	if((StringUtils.isNotBlank(minStr) && !StringUtils.isNumeric(minStr))
			||(StringUtils.isNotBlank(maxStr) && !StringUtils.isNumeric(maxStr))
			){
		response.sendError(400);
		return;		
	}
	
	if(StringUtils.isNumeric(minStr)&&StringUtils.isNumeric(maxStr)){
		minDan = Integer.parseInt(minStr);
		maxDan = Integer.parseInt(maxStr);
	}

%>

<!--  -->
	
	<form>
		<INPUT type="hidden" name="includePage" value="gugudan"/>
		<ul>
			<li>최소단 : <input type="number" min="2" max="9" name="minDan" value="<%=minDan%>"></li>
			<li>최대단 : <input type="number" min="2" max="9" name="maxDan" value="<%=maxDan%>"></li>
		</ul>
	</form>

	<h3>1부터 10까지의 숫자 출력(제어문을 이용)</h3>
	<ul>
		<%
			for (int number = 1; number <= 10; number++) {
				out.println(String.format("<li>%d</li>", number));
			}
		%>
	</ul>

	<TABLE border="1">

		<%
			for (int i = minDan; i < maxDan; i++) {
				String clz = "normal";
				if (i == 3)
					clz = "yellow";
		%>
		<tr class="<%=clz%>">
			<%
				for (int j = 1; j < 10; j++) {
			%>
			<td><%=i + "*" + j + "=" + (i * j)%></td>

			<%
				}
			%>
		</tr>
		<%
			}
		%>

	</TABLE>
	<br>
	
	<%!
	public StringBuffer gugudan(int minDan, int maxDan ) {
		StringBuffer buff = new StringBuffer();
		String pattern = "<td>%d*%d=%d</td>";
		
		for(int i=minDan; i<=maxDan; i++){
			String clz ="normal";
			
			if(i==3){clz="yellow";}
				buff.append(String.format("<tr class='%s'>",clz));
			
			for(int j=1; j<10; j++){
				buff.append(String.format(pattern, i, j, (i*j)));
			}
			buff.append("</tr>");
		}
		
		return buff;
	}
	%>
	
	<TABLE border="1">

		<%= gugudan(minDan, maxDan) %>

	</TABLE>
	
	
	
</body>
</html>