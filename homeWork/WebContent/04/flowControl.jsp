<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<h4>웹어플리케이션에서 흐름 제어(페이지 이동)</h4>
	<pre>
		3가지의 이동방식이 있지만, 크게 나누면 2가지 방식이 존재 
		양사이드에서 서로에 대한 정보를 삭제 -http의 stateless 
		
		모델1: 역할분담이 안나눠져 잇음, 책임이 분담되어 있지 않다, JSP1에 요청, 응답을 모두 때려박을때, 요즘에 잘 사용하지 않음  
		
		모델1과 모델2의 차이점 : 역할분담
		
		밑의 기준으로 사용하는 방법을 모델2 방식이라고 한다.
		요청을 받는 역할과, 응답을 주는 역할이 나뉘어져 있을때
		모델2를 명확한 구조로 생성할때 보통 요청을 받는 역할을 서블렛으로 
		응답을 하는 역할을 JSP만 
		

		기준: 도착자의 위치가 어디냐, 
		
		A --> B로의 이동. 
		1. Request Dispatch(요청 분기) 서버사이드 위임 방식, 절대주소 : 서버사이드 방식
			사용이유: 원본요청데이터를 살려둬야 할때 
			한번의 요청(최초 요청)에 대해 서버내에서 이동하는 방식 
			Http의 Connectless/StateLess특성에 따라 요청에 대해 응답이 전송되기 까지는 ㅇ요청 정보가 생존함 
			a->b로 이동시 응답이 전송되지 않기때문에 b쪽으로 원본 요청이 전달됨 
			forword: a에서 생성된 모든 데이터는 삭제되고, 최종응답은 b에서만 전달 
			include: a에서 b로 이동시 기존 데이터가 삭제 되지 않고, b측에서 데이터를 생성하여 a로 복귀, 최종적으로 a와b의 모든데이터가 전송			
			<%
				//요청을 넘기기 위해 request를 사용 ,  getRequestDispatcher 요녀석을 통해서 방향을 결정할 수 있음
				//서버사이드 경로 서버는 자기가 어느 context에 있는줄 아니까 그 뒤만 작성
				//forword랑 include로 구분
				//RequestDispatcher rd =request.getRequestDispatcher("/04/resourceIdentify.jsp"); 
				//rd.forward(request, response); 서버는 다른곳에서 응답했다는 것을 모름 a결과는 다 사라지고, b결과만 응답
				//rd.include(request, response); //resourceIdentify내용과, 현재 페이지 내용도 같이 나옴
				//a에서 b로 갔다가 b가 a로 결과를보내고 a가 b의 결과까지 모두 합해서 응답함 			
			%>
		2. Redirect 
			사용이유: 원본요청데이터를 없애고 새로운 요청데이터를 받고 싶어서 ex/ a에 대한 모든 처리가 이루어졌을때
			a를 완전히 끝내기 위해서 
			Http의 Connectless/Statelsee 특성에 따라 
			요청에 대해 응답이 전송되기 전까지는 요청 정보가 생존함 
			a->b로 이동시 중간에 body가 없는 응답(302/location)이 클라이언트쪽으로 전송
			클라이언트측에서 location헤더의 방향으로 새로운 요청을 전송함
			<%
				//한번 상황에대해 응답해야 하니까 response를 사용
				//b의 주소를 보내, 코드는 직접 작성할 필요없고, 자동으로 307코드 보냄 
				//새로운 요청을 발생시킬때 브라우저가 사용해서 절대 경로는 클라이언트방식으로
				response.sendRedirect(request.getContextPath()+"/04/resourceIdentify.jsp");
			%>
			
		
		
		
		
		어떤 경우에 써야할까????
		원본요청 데이터를 전달 할거냐 말거냐고 구분 
		
		-요청을 분석하는 과정에 총 100개 중에서 50개만 할수 있고, 나머지 50개는 B에서 처리 하고 싶어 
			원본 리퀘스트 100을 b에 넘겨줘야됨  	>>1번방식
		
		-로그인 성공 후 인덱스 페이지 (원본 요청 데이터를 다 사용함 id, password)로 이동 
		>>2번방식 
		
		각 방식에 따른 코딩 방식
		
	
	
	
	</pre>

</body>
</html>