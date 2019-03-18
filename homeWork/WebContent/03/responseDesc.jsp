<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 

<%
	//java 1.8 이상은 기본 캐릭터셋이 UTF-8
//	response.setContentType("text/plain");
//	response.setHeader("Content-Type", "text/plain"); 키값은 대소문자 구분안함
// header의 이름을 모르는경우, 오타가 날경우을 대비해서 setContentType 가 존재함

	// 이건 꼭 넣는건 아님 그래서 위에 직접 세팅하면 이건 무시가됨
	//<meta content="text/html; charset=UTF-8" />

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>

	<h4>Http 프로토콜에 따른 응답 패키징 방식</h4>
	
	<pre>
	HttpServletRespone 객체를 통해 정보 기록 
	1. Response Line : Protocol/ver. Status Code(응답상태코드)
		응답상태코드
		1) 100번대
		2) 200번대 : OK(Success) <%=HttpServletResponse.SC_OK%>
		3) 300번대
			클라이언트의 추가 액션을 요구
			302, 307 moved, 304 (서버에서 보내는 정보가 클라이언트의 캐시에 저장되어있다 캐시정보 사용해라)
		
		처리실패
		4) 400번대(Client side) 
			404(Not Found), 400(Bad Request, 형식이 잘못되었을때), 401/403(인가처리, Forbidden/UnAutorized)
			405(Method not allowed, do메서드가 잘못되었을때), 415(unsupported media type)
		5) 500번대		
			500(Internal sever )
	2. Response Header : 서버와 응답데이터 부가정보 (이름 값)
		response.setHeader(이름, 값), response.setIntHeader(이름, 숫자-int)
		response.setDateHeader(이름,날짜-long) millian 기준이라서 long 타입으로 
	3. Response Body(content Body): 서비스할 응답 컨텐츠
		response.getWriter/response.getOutputStream() -출력 스트림에 기록
		
			 
	응답 헤더의 기록 
	1. Mime 설정 : Content-Type(jsp맨위)
	2. 캐시 제어 : Pragma(http1.0), Cache-control(http1.1), Expires(공통)
	- 캐시가 잘못 저장되면 서버에서 갱신된 정보를 주어도 브라우저에서 캐시에 저장된 내용만 보여줨
	- 캐시데이터가 남는다는건 파일을 저장한다는것, 보안목적으로 하지말것
	- 캐시데이터를 안남길려면
		<%
		//불특정 다수의 서버사이드 어플리케이션은 특정 타겟을 만들면 안된다.
		//웹 표준화 : 어떤 브라우저, 어떤 프로토콜 이든 같은 내용이 적용되어야 한다.
		//
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-control", "no-cache");//파이어폭스는 nocahe를 인식못함, 캐시를 남길려면 public
			response.addHeader("Cache-control", "no-store");//no-store는 파이어폭스를 위해, set을 두번쓰면 덮어쓰니까 add로 작성
			//현재 시간 저장할 변수
			Calendar cal =Calendar.getInstance();
			cal.add(Calendar.DATE,7);
			
			long date = cal.getTimeInMillis();
			response.setDateHeader("Expires", date);//7일 보관하고 삭제 
			response.setDateHeader("Expires", 0);//즉시 삭제  
		%>
		
	3. 자동 요청 : Refresh
		클라이언트 사이드 방법 
		서버사이드 방법
		-->autoRequest.jsp참고
	
	4. 페이지이동 : Location(다음주 수업 주제)**********명확히 이해 하고 있어야해 
	Location(302,307) - response.sendRedirect(url-클라이언트 방식의 절대 경로 )
		- 흐름을 제어하거나 이동하는것이 언제 필요한가?
		하나의 요청-> 판단결과에 따라 페이지가 여러개가 나옴  
		
		->04/flowControl.jsp참고
	
	
	</pre>


</body>
</html>