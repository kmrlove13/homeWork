<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.enumpkg.OperatorType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/calculate.jsp</title>
<!--네트워크 상에서 body태그를 가지고옴, 이주소를 가지고 주소를 날려서 응답데이터를 받야아함-->
<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></SCRIPT>
<SCRIPT type="text/javascript">
	$(function(){
		var resultArea = $('#resultArea'); 
		
		//동기요청을 가로채기 
		//submit 버튼 타입의 가로채기 타입은 form 
		$("#calForm").on("submit", function(event) {
			event.preventDefault();
			//동기요청이든 비동기요청이든 똑같아 요청 url, 방식, parameter
			//js - {}객체 표현
				//$('#resultArea')
			var action = $(this).attr("action");
			var method = $(this).attr("method");
			/*현재 form태그 중에서 직렬화한 값을 가져오는 함수 정보 : serialize()*/
			var queryString = $(this).serialize();
			$.ajax({
				url : action,//액션 정보의 값
				method : method,
				data :queryString,
				/* data:{
					leftOp: 5,
					rightOp: 7,
				} */
				dataType : "json",
				success : function(resp) {
					//$('#resultArea').html(resp); 이런 형식은 퍼포먼스가 길어지기에 밑 방법처럼 사용
					//resultArea.html(resp); html데이터타입
					resultArea.html(resp.result); 
					//특정조건에 맞는 하위 요소를 찾기 find()
				//	var result = $(resp).find("result"); //xml방식
					
				},
				error : function(errorResp) {//실패하였을때
					console.log(errorResp.status);
				}

			});
			
			return false;
		});
		
		
		
	});





</SCRIPT>
		<%
			String ptrn = "<option value='%s'>%s</option>\n";
			StringBuffer options = new StringBuffer();
			for(OperatorType type: OperatorType.values()){
				options.append(String.format(ptrn,type.name(),type.getSign()));
			}
		
		%>

</head>
<body>
	<h4>사칙연산기</h4>
	<!--.do 확장자는 없음,form 동기요청-->
	<form id ="calForm" action="<%=request.getContextPath()%>/calculator.do"><!-- client가 다음번 주소를 요청할때 사용하니까 client주소방식으로 사용 -->
		서버사이드 방식으로 해결
		<INPUT type="number" name="leftOp"/>
		<!--+이게 고정이 아니라 동적으로 할려면 -->
		<SELECT name="operator">
		<%=options %>
		</SELECT>
		<INPUT type="number" name="rightOp"/>
		<INPUT type="submit" value="="/>
		<SPAN id="resultArea"></SPAN>
	
	
	<br><br>
	<!-- //동기요청을 가로채고 
	//동기요청을 취소하고 eventDefault
	//비동기요청으로 변경하고  -->
	
	
	</form>

</body>
</html>