<%@page import="javax.xml.ws.Response"%>
<%@page import="kr.or.ddit.enumpkg.DataType"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java"
    pageEncoding="UTF-8"%>

<%
	String accept = request.getHeader("Accept");
	String content = String.format("%tc", Calendar.getInstance());
	String res = "";
		
	DataType dataType = DataType.dataMatch(accept);
	res = dataType.getText();
	
	if(dataType.equals("OTHER")){
		response.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE,"res");
		return;
	}
	
	response.setContentType(res);

	if(res.contains("html")){
	%>	
		<span><%=content%></span>
	<% 
	}else if(res.contains("plain")){
	%>
		<%=content %>
	<%	
	}else if(res.contains("json")){
	%>
		{
			"time" : "<%=content%>"
		}
	<%
}
%>


<%-- <%
	String accept = request.getHeader("Accept");
	String content = String.format("%tc", Calendar.getInstance());
	
	if(accept.contains("html")){
		response.setContentType("text/html;charset=UTF-8");
		%>
		<span><%=content%></span>
		<%
	}else if(accept.contains("plain")){
		response.setContentType("text/plain;charset=UTF-8");
		%>
		<%=content%>
		<%
	}else if(accept.contains("json")){
		response.setContentType("application/json;charset=UTF-8");
	%>	
		{
		 	"time" : "<%=String.format("%tc", Calendar.getInstance()) %>"
		 }
	<%	 
	}else{
		response.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE,"지원하지 않는 타입입니다.");
	}
%> --%>

 <%--서버사이드 방법으로 서버 시간을 설정, ajax가 보내는 방식에 따라 contentType바꿔--%>   
 <%-- <span><%=String.format("%tc", Calendar.getInstance()) %></span>  --%>
 
 
    