<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/requestHeader.jsp</title>
</head>
<body>
	
	<h4>요청 헤더의 종류</h4>
	
<%
	String headerName = request.getParameter("headerName");

	Enumeration<String> names = request.getHeaderNames();
	String pattern ="<tr><th>%s</th><td>%s</td></tr>";
	String opPatt = "<option selected>%s</option>\n";
	StringBuffer trTags = new StringBuffer();
	StringBuffer options = new StringBuffer();
	
	while (names.hasMoreElements()) {
		String name = (String)names.nextElement();
		String value = request.getHeader(name);
		String selected = "";
		
		if(name.equals(headerName)){
			selected ="selected";
		}
		
		options.append(String.format(opPatt,selected,name));
		
		//매개변수에 따라서
		//값이 확실히 있는 것을 대상으로 호출 headerName.equals(name)이렇게 하면 널값
		if(StringUtils.isNotBlank(headerName) && name.equals(headerName)){
			trTags.append(String.format(pattern,name,value));
		}else if(StringUtils.isBlank(headerName)){
			trTags.append(String.format(pattern,name,value));
		}
	}
%>
<!--폼에 네임의 속성을 주면 도큐먼트에 반영이됨-->
<form name="headerForm">
	<SELECT name="headerName" onchange="document.headerForm.submit();">
		<option value="">헤더명선택</option>
		<%=options %>
	</SELECT>

</form>

<table>
	<%=trTags%>
</table>	
	
	
	

</body>
</html>

<%-- <% 
	String headNm = "host";
	param = request.getParameter("head");
	
	if(!StringUtils.isBlank(param)){
		headNm = param;
	}
	
	headerNames= request.getHeaderNames();
	value = request.getHeader(param);
	
	%>
	
	
	
	
	
	<%!
	StringBuffer buff = new StringBuffer();
	Enumeration<String> headerNames=null;
	String value=null;
	String param = null;
	
	public StringBuffer nameList(){
		
		String patt = "<option name='head' value='%s'>%s</option>";
		while (headerNames.hasMoreElements()) {
			String name = (String) headerNames.nextElement();
			buff.append(String.format(patt, name, name));
		}
		return buff; 
	}
	
	public StringBuffer valueList(param){
		StringBuffer buff2 = new StringBuffer();
		String patt = "<td>%s</td>";
		buff2.append()
		
		
	}
	
	%>
	
	<h4>헤더요청</h4>
	<form>
		<SELECT><%=nameList()%></SELECT>
		<input type="submit" value="상세정보보기"/>
	</form>
	
	<table>
		
	</table>		
	 --%>