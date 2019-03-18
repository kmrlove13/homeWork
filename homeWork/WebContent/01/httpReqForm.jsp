<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<!--메타데이터(header부분)utf-8로 작성되어 보내짐 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>01/httpReqForm.jsp</title>
</head>
<body><!--/webStudy01/ 대신에 밑에 처럼 할수있음-->
	<form action="<%=request.getContextPath() %>/httpReq.do" method="post">
		<!--쓴대로 그대로 나옴 WYSIWYG태그 What You See Is What You Get-->
		<pre>
			text : <input name="textParam" type="text"/>		
			checkbox : <input name="checkBoxParam" type="checkbox" value="Box1"/>		
			<input name="checkBoxParam" type="checkbox" value="Box2"/>		
			<input name="checkBoxParam" type="checkbox" value="Box3"/>
			radio : <input name="radioParam" type="radio" value="radioOn1"/>		
			<input name="radioParam" type="radio" value="radioOn2"/>		
			select : <select name="selectParam">
				<option>text1</option><!--얘를 선택하면 value가 없으니까  값이 넘어가고-->
				<option value="optValue2">text2</option><!--얘는 value가 있으니까 value가 넘어감-->
			</select>
			<input type="submit" value="전송"/>		
		</pre>
	
	
	
	</form>


</body>
</html>