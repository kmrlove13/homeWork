<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
Calendar calendar = Calendar.getInstance(); // 현재 년월일시분초로 Calendar객체 초기화

// int year = 2019; // 년도
// for(int month = 1; month <= 12; month++){
	calendar.clear(); // 캘린더 객체를 빈 값으로 초기화
	
	String yyyyMM = request.getParameter("yyyyMM");
	
	if(StringUtils.isBlank(yyyyMM)) // 파라미터가 없으면 이번 달 설정
		yyyyMM = new SimpleDateFormat("yyyyMM").format(new Date());
	
	String stryyyy = yyyyMM.substring(0, 4); // 파라미터의 년도만 추출 
	String strmm = yyyyMM.substring(4); // 파라미터의 달만 추출
	int yyyy = Integer.parseInt(stryyyy); 
	int mm = Integer.parseInt(strmm); 
	
	//매개변수값
	String yStr =request.getParameter("yy");
	String mStr =request.getParameter("mm");
	if(!StringUtils.isBlank(yStr)||!StringUtils.isBlank(yStr)){
		yyyy=Integer.parseInt(yStr);
		mm=Integer.parseInt(mStr);
	}
	
	
// 	int year = calendar.get(Calendar.YEAR);	// Calendar.YEAR 는 해당 년도를 넣는다.
	calendar.set(Calendar.YEAR, yyyy);
	calendar.set(Calendar.MONTH, mm -1); // January는 0이다. 0부터 시작
	calendar.set(Calendar.DAY_OF_MONTH, 1); // 첫날을 넣는다.
	int firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/calendar.jsp</title>
<style>
    div#calendar-content {
        border : 1px solid white; /* 외곽선: 1px 실선 red색 */
        width: 30px; /* 가로 폭: 30px */
        float: left; /* 왼쪽 객체에 붙도록 함 */
        text-align: right; /* 안에 글 오른쪽 정렬 */
    }
    br#calendar-enter {
        clear: both; /* 붙는 설정 풀고 줄바꿈*/
    }
	.titWrap{
		overflow: hidden;
		width:100%;
	}
	.title{
		padding : 0 50px;
		display: block;
		float: left;
	}
	.btn{
		display: block;
		float: left;
		margin-top: 15px;
	}
	input{
		width: 100px;
	}
	#okBtn{
		width: 50px;
	}
	
	
</style>

<script src="/webStudy01/js/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		$("#leftBtn").on("click", function(){	/* 이전 달 설정 */
			var now = new Date();
// 			var yyyy = now.getFullYear().toString(); // 현재 년도 추출
			var yyyy = (<%= calendar.get(Calendar.YEAR)%>).toString();
			var mm = (<%= calendar.get(Calendar.MONTH)%> + 1 - 1).toString(); // 현재 달 추출
			if(mm < 1 ){
				yyyy = (<%= calendar.get(Calendar.YEAR)-1 %>) + "";
				mm = "12";
			}
			
			var yyyyMM = yyyy + mm;
			$("[name='yyyyMM']").val(yyyyMM); 
			$("#calFrm").submit();
		});
		
		$("#rightBtn").on("click", function(){	/* 다음 달 설정 */
// 			$("[name='yyyyMM']").val("201904");
			var now = new Date();
			var yyyy = (<%=calendar.get(Calendar.YEAR)%>).toString(); // 현재 년도 추출
			var mm = (<%= calendar.get(Calendar.MONTH)%> + 1 + 1).toString(); // 현재 달 추출
			if(mm > 12){
				yyyy = (<%=calendar.get(Calendar.YEAR)%> + 1).toString();
				mm ="1";
			}
			var yyyyMM = yyyy + mm;
			$("[name='yyyyMM']").val(yyyyMM); 
			
			$("#calFrm").submit();
		});
		
	});
</script>
</head>
<body>

<form id="calFrm" method="post">
	<h4>원하시는 날짜를 선택하세요 </h4>
	년: <input type="number" name="yy" value="" placeholder="1930년부터" min="1930"/>
	월: <input type="number" name="mm" value="" min="1" max="12" />
	<input type="submit" value="확 인" id="okBtn"/>
	
	<input type="hidden" name="yyyyMM" value="">
	<br>
	<br>
	<div class="wrap">
	<div class="titWrap">
		<button id="leftBtn" type="button" class="btn">&lt;</button>
		<p class="title"><%=yyyy %>년 <%=mm %>월</p> <!-- 1월은 0 -->
		<button id="rightBtn" type="button" class="btn">&gt;</button>
	</div>
	<div id="calendar-content">일</div>
	<div id="calendar-content">월</div>
	<div id="calendar-content">화</div>
	<div id="calendar-content">수</div>
	<div id="calendar-content">목</div>
	<div id="calendar-content">금</div>
	<div id="calendar-content">토</div>
	<br id="calendar-enter">
	
	<%
	int dayOfWeek = 1; // 해당 주 중에 몇 번째 칸인지 저장
	for(int blankDay = 1; blankDay < firstDayOfWeek; blankDay++){
		// 여기는 띄워야할 칸을 작성하는 구간입니다.
		// firstDayOfWeek 이 첫날의 요일(일:1, 월:2, ...토:7)을 제시하므로
		// 그 전까지만 채워야 한다.
		%> <div id="calendar-content"></div><%
		dayOfWeek++;
	}
	
	int daysPerMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH); //해당 월의 일 수
	for(int day =1; day <= daysPerMonth; day++){
		%><div id="calendar-content"><%=day %></div><%
		if(dayOfWeek >= 7){
			%><br id="calendar-enter"><%
			dayOfWeek = 1;
		} else {
			dayOfWeek++;
		}
	}
	%> <br id="calendar-enter"><br>
	</div>
	<%
// }			
%>
	<!-- https://msm8994.tistory.com/26 참고 -->
</form>
</body>
</html>



















