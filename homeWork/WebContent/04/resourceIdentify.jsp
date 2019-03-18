<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/resourceIdentify</title>
</head>
<body>
	<h3>자원의 식별</h3>
	<pre>
	<!--상대경로: 브라우저 주소가 기준-->
	<!-- <img src="../images/koala.jpg">-> 이방법은상대경로 -->
	통칭 같은 의미(uri=url): 사실은 조금 다름
	
	URI(Unified Resource Identifier): 밑의 3가지를 통칭, 여러가지 방식중 현실적인 방식이 url이라서, 가상의 주소를 생성해서 자원에 접근 
	URL(Unified Resource Locator): 위치를 기준으로 식별, 절대 경로를 기준으로 자원의 식별
	URN(Unified Resource Naming): 자원의 이름으로 찾는것, 명칭을 등록하고 식별, 단점은 명칭을 등록 안하면 식별 못함
	URC(Unified Resource Content) : 자원의 특징을 이용해 식별, 중복을 해결 못함, 너무 포괄적, 등록해야함
	
	URL표기방법 
	http://www.naver.com 
	1. 정석방법
	프로토콜(shcema)
	:// 루트 여기부터 주소라는 얘기 
	www : 여러 서버들이 존재하는데, 하나의 서버를 식별할때 사용, 서버의 종류를 의미(host)
	naver: 기관에 대한 식별자 domain
	depth01/...../resource_name[확장자포함] 확장자는 생략가능
<!--서버의 자원의 출처를 src 작성--><img src="출처"/>
	
	2. 상대경로 : 현재 기준위치를 상대적으로 판별해서 자원을 식별,/webStudy01/04 -> ../images/koala.jpg
	
	3. 절대경로 : ://루트에서부터 시작 http://localhost/webStudy01/04/images/Koala.jpg
			http: > 생략가능, 브라우저에선 http를 사용하니까
			/webStudy/04/images/Koala.jpg : 컨텍스트 path부터 등록, ip로 매칭되는건 도메인까지만 이라서 
			개발할때랑 배포할때의 context명이 달라질수있음, 자원을 식별할수 없는 상황이 올수 있음, 그래서 절대 하드코딩하지말고 
			<%=request.getContextPath() %>
			하드코딩부분에 구멍을 뚫어놔서 표현식으로 getContextPath()을 이용*****많이 사용함
			/imageForm.do > /있으면 절대 경로 
			
			서버사이드 방식:
				서버상에서는 자기 위치를 알고있기때문에 이미 알고있는 경로를 작성안하고, contextPath를 제외한 나머지 경로만 작성
			클라이언트 방식 :  getContextPath()이용
			
			어떤방식을 사용: 이 기술을 사용해서 자원을 식별하는 주체가 서버에 있다면 서버 방식, 식별하는 주체가 클라이언트가 있다면 클라이언트 방식
			자원이 어디에 있는지를 보는게 아니라 자원을 식별하는 주체(클라이언트, 서버)
			</images/koala.jpg>-> localhost/images.. 잘못된 방법> 절대경로로 하지말자  images의 주소이동은 클라이언트가 하니까 
			브라우저는 자기가 알고있는 도메인값이 있음. 그래서 도메인값 뒤에 절대경로를 붙임
			<<%=request.getContextPath() %>>images/koala.jpg> 이렇게 contextPath가 필요함, 브라우저가 이 주소를 사용
			
			<%
			//현재 우리는 코알라 사진의 url밖에 모름 
				//서버방식 서버상의 실제 자원 위치 String realpath =getServletContext().getRealPath("/images/Koala.jpg"); //=> url값을 넘겨주면 파일시스템의 경로를 리턴함, 이 주소는 서버가 사용
				//서버방식인데 클라이언트방식으로 했을때 : String realpath2 =getServletContext().getRealPath(request.getContextPath()+"/images/Koala.jpg"); //=> 이 방법은 클라이언트주소, 잘못된 방법
				
			%>
			jsp > 개발자와 웹컨테이너의 역할로 구분
			컴파일안하는이유: jsp가 템플릿 기반이라서, 진짜 소스가 아니라서
			클라이언트 서버 시스템의 구조 : 3tier, 4tier..등
			
			client
			Line : method(요청의도, 목적) , 대부분은 get방식 
			Header: 이름과 값의 쌍으로 , 요청에 대한 메타데이터, accept(요청헤더 :데이터타입으로 구성, 응답헤더: contextType)
			Body: post방식에선 데이터가 %2E이런식으로 전달 
			톰캣이 
			객체를 request http방식으로 캡슣화 
			
			Http : 특성에 따라 한번 요청이 들어오고 1대1로 완료하면 다 연결을 끊어버림 connetless, 연결을 끊고 가지고 있던 정보들을 다 삭제stateLess,
				클라이언트와 서버와의 소통이 안됨
			
			response Header: content-type(이미지인지, 동영상인지..등을 설정하여 알려주는것),accept(클라이언트가 필요한것),
			accept(엑셀이 필요함), 서버가 accept를 보고 엑셀로 처리한 후 , content-type(엑셀타입)이라는걸 안내문을 작성하여 응답 그래서 둘이 짝
			refresh 주기적으로 요청을 날릴수있음, 서버사이드 방식, 클라이언트방식
			
			모든언어에서 날짜 데이터는 밀리센터드로 관리가됨 
				
				
				
	</pre>		 
</body>
</html>