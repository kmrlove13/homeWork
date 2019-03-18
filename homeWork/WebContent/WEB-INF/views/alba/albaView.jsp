<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.AlbaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<!--한명의 알바생의 정보를 table태그로 ui구성 -->
<jsp:useBean id="alba" class="kr.or.ddit.vo.AlbaVO" scope="request"></jsp:useBean>	
<jsp:useBean id="licMap" class="java.util.LinkedHashMap" scope="application"></jsp:useBean>	
<%
	String[] lic = alba.getLic();
	StringBuffer buff = new StringBuffer();
	for(int i=0; i<lic.length; i++){
		String licNm = licMap.get(lic[i]).toString();
		buff.append(licNm+", \n");
	}

	String licName = buff.toString();
%>


<table>
		<tr>
			<th>ID</th>		
			<td><%=alba.getId()%></td>
		</tr>
		<tr>
			<th>이름</th>		
			<td><%=alba.getName()%></td>
		</tr>
		<tr>
			<th>나이</th>	
			<td><%=alba.getAge()%></td>
		</tr>
		<tr>
			<th>주소</th>		
			<td><%=alba.getAddr()%></td>
		</tr>
		<tr>
			<th>휴대폰</th>		
			<td><%=alba.getHp()%></td>
		</tr>
		<tr>
			<th>이메일</th>		
			<td><%=alba.getMail()%></td>
		</tr>
		<tr>
			<th>성별</th>		
			<td><%=alba.getGen()%></td>
		</tr>
		<tr>
			<th>혈액형</th>		
			<td><%=alba.getBtype()%></td>
		</tr>
		<tr>
			<th>최종학력</th>		
			<td><%=alba.getGrade()%></td>
		</tr>
		<tr>
			<th>자격증</th>		
			<td><%=licName %></td>
		</tr>
		<tr>
			<th>경력사항</th>		
			<td>
				<textarea><%=alba.getCareer()%></textarea>
			</td>
		</tr>
		<tr>
			<th>특기사항</th>		
			<td>
				<textarea ><%=alba.getSpec()%></textarea>
			</td>
		</tr>
		<tr>
			<th>자기소개</th>		
			<td>
				<textarea><%=alba.getDesc()%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<INPUT type="button" value="수정" onclick="location.href='albaUpdate.do?who=<%=alba.getId()%>'"/><!--다시 알바폼으로, 값을 가진채로-->
							
				<INPUT type="button" value="삭제" onclick="location.href='albaDelete.do?who=<%=alba.getId()%>'"/><!-- -->			
			</td>
		
		</tr>
		
	
	</table>

</body>
</html>