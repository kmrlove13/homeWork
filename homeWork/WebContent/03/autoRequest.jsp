<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 주소를 동적으로 배포이름을 다르게 할수도 있으니까 그때 마다 절대경로 찾아서 바꿔여함..-->
<SCRIPT src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></SCRIPT>


<%
	int second = 5;
	String goPage = "http://www.naver.com";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- <meta http-equiv="Refresh" content="<%=second%>;url=<%=goPage%>" />-->
<!--Meta 응답데이터가능 5초뒤에 카운팅-->
<!--5초뒤에 다른 페이지로 넘어감-->

<title>Insert title here</title>
</head>
<body>
	<h4>Auto Request</h4>
	-왜 필요한가? ex)주가 화면

	<pre>
		1)시간이 흘러갈때 마다 카운트 
		2)5초뒤에 네이버로 간다 
		3)기다리는 대상이 클라이언트 이기 때문에 클라이언트 방식으로 
		4)자바스크립트에서 반복 timeOut 한번수행, interval 일정한 주기로 반복
		5)전체페이지가 아니라 시간부분만 새로고침
		6)동기요청: 화면전체를 새로고침- 브라우저에다가 주소를 쓰고 엔터, a태그 클릭, form의 제출
			화면에 대한 제어권을 가지고, 응답이 오면 바꿀수있어 
		7)Ajax비동기 처리 방식 Asyncronus(화면자체는 변경안하고 시간만 변경)
			제이쿼리 없을때 : XMLHttpRequest 이건 옛날 방식, 지금은 xml로 데이터를 주고받지 않음
		
		
		<span id="secondArea"></span>초 뒤에 네이버로 갑니다.<%=goPage%>
	
		<!-- 서버의 현재 시간: %=String.format("%tc", Calendar.getInstance())%> -->
		<!--시간을 의미하는 캘린더 문자 t, c시간을의미하는-->
		서버의 현재 시각: <span id="serverWatch"></span>
		클라이언트의 현재 시각 : <span id="clientWatch"></span>
	
	</pre>
	<SCRIPT type="text/javascript">
		var clientWatch = document.querySelector("#clientWatch");
		var serverWatch = document.querySelector("#serverWatch");
		
		setInterval(function(){//클라이언트 시간 
			var now = new Date();
		//클라이언트 시간
			clientWatch.innerHTML = now;
		
		//동기요청이든 비동기요청이든 똑같아 요청 url, 방식, parameter
		//js - {}객체 표현 \가 없을땐, 상대주소방식, 그러면 브라우저주소가 기준
		//응답형태가 문자일때 사용 text/plain, text/html...	
		$.ajax({
			url : "getServerTime.jsp",
			method : "get",
			//data : "", //여기까지는 요청 정보, get이니까 필요없음
			dataType : "json", //응답데이터의 타입을 결정, 이부분의 값이 응답데이터의 contextType값과 같음
			//request header(Accept), response header(content-type)
			//정상적으로 전송 되었을때 로직
			//content-type의 값이 resp로 들어감
			
			success : function(resp) {//resp엔 dataType이 들어가잇음
				//$(serverWatch).innerHTML(resp); js방식
				//$(serverWatch).html(resp);jquery html방식
				$(serverWatch).html(resp.time);
			},
			error : function(errorResp) {//실패하였을때
				console.log(errorResp.status);
			}
		});
		
		},1000);
	
		//contentType이 서버랑 클라이언트가 다를때
		//서버쪽에서는 잘보내서 200이 나오지만, 클라이언트에선 에러 function을 표시함
		
	
		
		
	</SCRIPT>
</body>
</html>
		<%
			//response.setIntHeader("Refresh", 1);//1초 서버사이드 방법
		%>
			
	<%-- 	var spanTag = document.querySelector("#secondArea");
		var iniSecond = <%=second%>
		//1초마다 한번씩 값 변경, 람
		/* setInterval(function(){
			
		},1000); */
		
		setInterval(() => {
			spanTag.innerHTML = iniSecond--;
		}, 1000); --%>
		
