<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//세션만료시간을 가져오기
	int time = session.getMaxInactiveInterval();
	//SimpleDateFormat df = new SimpleDateFormat("hh:mm:ss");
	//String timeStr =df.format(new Date(time));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>06/sessionTimer.jsp</title>
<!-- sessionTimer플러그인이 돌아가긴 위해서 jquery가 필요함, 스크립트 순서 잘 해야함! -->
<SCRIPT src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></SCRIPT>
<SCRIPT src="<%=request.getContextPath()%>/js/jquery_sessiontimer.js"></SCRIPT>
<!--이 형태는 제이쿼리가 없으면 사용못함, 즉 플러그인 형태-->
<SCRIPT type="text/javascript">
//만약에 html이거나 다른곳은 표현식을 사용못하니까
	$.getContextPath=function(){
		return "<%=request.getContextPath()%>";
	}
	
	/*제이쿼리 안에 들어있는 함수*/
	$.fn.sampleFunc = function(text) {
		//얘는엘리멘트가 호출하니까 그 엘s리멘트를 뜻하는 this를 사용	
		this.html(text);
		return this;
	}

	$.fn.sessionTimer = function(timeOut, ajaxUrl) {
		//timeOut이 넘어왔나 안넘어왔나 판단하는법
		if (!timeOut) {
			console.error("세션 타임아웃 값이 전달되지 않았음");
			return this;
		}//타임아웃이 비어있으면 여기서 리턴

		function lpad(text, size, padding) {
			//원본문자열, 사이즈, 패딩문자열
			text = text + ""; //text가 분, 초 인데 숫자니까 문자로 우선 만드릭
			if (text.lengh < size) {
				//공을 한번 넣으려면 한번 돌리면 되고 두번 넣으려면 두번 돌리면 되고,
				var paddingCnt = size - text.length;
				for (var num = 0; num < paddingCnt; num++) {
					//text의 왼쪽에 0을 채워주기, 혹시 아직까지도 타입이 문자열이 아닐수도 있으니 안전빵으로""넣기 
					text = padding + "" + text;
				}
			}
			return text;
		}	

			/*js에선 function도 객체라서 이런식으로 사용할 수 있음
			이 함수 안에서만 사용하는 함수를 하나 더 만듬*/
			function makeTimeString(time) {
				//소수점 아래자리를 버릴때 trunc를 주로 사용 
				var min = Math.trunc(time / 60);
				var sec = time % 60;

				return lpad(min, 2, '0') + ":" + lpad(sec, 2, '0');
			}

			function showMessage() {
				/* <div id="msgArea">
				<span id="timeInfo"></span><br>
				<span id="info">만료시간이 1분 남았는데 연장 할래?</span> <br />
				<input type="button" value="연 장" class="btn" id="yesBtn" /> 
				<input type="button" value="취 소" class="btn" id="noBtn" />
				</div> */
				//append는 가변형 파라미터라서 여러 형태를 넘길수있음
				//jquery객체로 배열에 넣어줌
				var btnArray = [
						$('<input type="button" value="연 장" class="btn" id="yesBtn" />'),
						$('<input type="button" value="취 소" class="btn" id="noBtn" />') 
					];
				//콜백형태가 인덱스가 들어오고 그 인덱스에 해당하는 arrayElement가 들어옴
				$(btnArray).each(function(index, arrayElement) {
					arrayElement.on("click", function() {
						var btnId = $(this).prop("id");

						if (btnId == "yesBtn") {//연장한다고 하면, 타이머 리셋, 
							//이 서버시간 자체를 플러그인으로 사용해야 하기에 하드 코딩은 안됨
							$.ajax({ //url이 안넘어왔기에 이런 형식으로 안넘어왔으면 현재 브라우저의 주소값을 사용해서 비동기 요청, 넘어왔으면 동기
								url : !ajaxUrl ? "" : ajaxUrl,
								method : "head",
								success : function() {
									//일단 success가 떠야 연장한다는것 
									timer = timeOut;

								},
								error : function(errorResp) {//실패하였을때
									console.log(errorResp.status);
								}
							});
						}

						$(this).parents("#msgArea").remove();
					});
				});
				var msgTag =
					$("<div id='msgArea'/>").append(
						$("<div>").text("만료시간이 1분 남았는데, 연장 할래?"),
						$("<div>").append(
								btnArray[0], 
								"&nbsp;", 
								btnArray[1]

						));
				$("body").append(msgTag);
				return msgTag;
			}

			var timer = timeOut;
			var element = this;
			var msgArea = null;
			/* this.text(makeTimeString(timer)) */

			var timerJob = setInterval(function() {
				if (timer == 0) {
					ClearInterval(timerJob);
					if (msgArea) msgArea.remove();
					location.reload();
					return;
				} else if (timer == 2) {
					msgArea = showMessage();
				}
				element.text(makeTimeString(timer--));
			}, 1000);

			return this;
		}
	
	//함수 사용방법 :사용하기 위해선 타이머라는 엘리멘트에서 호출, 이런 구조를 함수의 체인형 구조
	$(function() {
		$("#timeArea").sessionTimer(5);

	});
</SCRIPT>

</head>
<body>

	<div id="timeArea"></div>
	<pre>
	1. 세션의 만료 시간을 출력 02:00 서버사이드 , 나머지는 클라이언트에서 사용
	2. 초 단위로 시간을 discount
	3. 만료시간이 1분이 남은 경우 "연장하시겠습니까 "메세지, 연장 여부 결정 메시지 출력 
	4. 연장을 하는 경우 -타이머 리셋, 단순히 클라이언트 사이드에서 변경이 아니라, 서버사이드에서 변경되야됨 요청을 다시 날려야함 
		서버의 세션을 연장하기 위해 새로운 요청 발생 비동기 요청으로 발생
 	5. 연장을 안하는 경우 -타이머 그대로 disCount
		0초가 남으면 자동으로 로그아웃 상태로 바꿔야됨 새로고침만 하면 로그아웃 상태로 되어있을꺼얌 
		0초가 되는 순간, 현재 페이지가 refresh가 되도록 
	매 1초마다 새로고침 -> interval 함수 
	1분 남아서 새로고침 -> callback 함수
	</pre>
	<!-- 이건 하드코딩방법 , 이 서버시간코딩 자체를 플러그인으로 생성할 것이기 때문에 이거 지워주지
	<div id="msgArea">
		/hide, /show
		<span id="timeInfo"></span><br>
		<span id="info">만료시간이 1분 남았는데 연장 할래?</span> <br /> <input
			type="button" value="연 장" class="btn" id="yesBtn" /> <input
			type="button" value="취 소" class="btn" id="noBtn" />
	</div> -->

</body>
</html>