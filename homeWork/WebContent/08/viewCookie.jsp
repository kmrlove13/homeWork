<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<h4>동일경로</h4>
	<TABLE>
		<THEAD>
			<tr>
				<th>쿠키명</th>
				<th>쿠키값</th>
			</tr>		
		</THEAD>
		<TBODY>
			<%
				Cookie[] cookies = request.getCookies();
			if(cookies!=null){		
				for(Cookie tmp: cookies){
				%>
					<tr>
						<td><%=tmp.getName()%></td>
						<td><%=URLDecoder.decode(tmp.getValue(), "UTF-8")%></td>
					</tr>	
				<%
				}
			}
			
			
			%>
		</TBODY>
		
	</TABLE>
	
	
	
</body>
</html>