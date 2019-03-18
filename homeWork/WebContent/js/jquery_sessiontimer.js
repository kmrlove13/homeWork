/**
 * 타이머
 * $("#sample").sessionTimer(120, "moveURL");
 */
	$.fn.sessionTimer = function(timeOut) {
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
						$('<input type="button" value="취 소" class="btn" id="noBtn" />') ];
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
								error : function() {//실패하였을때
									console.log(errorResp.status);
								}
							});
						}

						$(this).parents("#msgArea").remove();
					});
				});
				var msgTag = $("<div id='msgArea'/>").append(
						$("<div>").text("만료시간이 1분 남았는데, 연장 할래?"),
						$("<div>").append(btnArray[0], "&nbsp;", btnArray[1]

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
					if (msgArea)
						msgArea.remove();
					location.reload();
					return;
				} else if (timer == 2) {
					msgArea = showMessage();
				}
				element.text(makeTimeString(timer--));
			}, 1000);

			return this;

		}