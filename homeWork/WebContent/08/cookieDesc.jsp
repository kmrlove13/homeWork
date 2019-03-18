<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>08/cookieDesc.jsp</title>
</head>
<body>
	<h4>Cookie</h4>
	<pre>
		:Http의 stateless 특성의 단점을 보완하기 위해 클라이언트 사이드에 저장하는 데이터 
		쿠키의 사용 단계 , header의 형태로 서버와 브라우저 사이에 오고감
		1,2,5번만 개발자가 다루고, 3,4번은 서버 
		
		1. 쿠키 생성 (javax.servlet.http.Cookie): 쿠키의 여러가지 속성들을 결정 
		2. 응답데이터를 통해 클라이언트쪽으로 전송
		
		3. 브라우저에 의해 자기 쿠키 저장소에 저장
		4.이후 요청에 저장되어 있던 쿠키가 서버로 다시 재전송

		5. 요청을 통해 재전송된 쿠키를 통해 상태 복원
		
		세션이 만료될때 쿠키도 같이 만료됨 
		<%
		//쿠키를 여러개씩 한번에 전송할수도 있고 여러개 한번에 받을수도 있음
		//쿠키를 생성한다는건 객체를 생성한다는것, 기본생성자가 없음
		//파라미터 두개를 받는 생성자만 있음, 쿠키의 네임과 밸류속성을 먼저 결정해야됨 
		//상태를 복원하기 위한 최소한의 정보를 브라우저로 보내고, 서버로 되돌아온다.
		//쿠키는 유일해야 하기때문에 이름과 값을 생성해야 한다,. 
		//1번 단계
		String cookieValue = URLEncoder.encode("한글쿠키값","UTF-8");
		Cookie sampleCookie = new Cookie("sampleCookie",cookieValue);
		//2번 단계 응답데이터로 넘겨
		response.addCookie(sampleCookie);
		//5번 단계, 디코딩 설정이 안되어있으면 외계어 나옴
		Cookie[] cookies =  request.getCookies();
		if(cookies!=null){//널검증 꼭!
			for(Cookie tmp: cookies){
				if(tmp.getName().equals("sampleCookie")){
					String tmpValue=	URLDecoder.decode(tmp.getValue(),"UTF-8");
					out.print(tmpValue);
				}
			}
		} 
		%>
		
		쿠키의 속성 종류
		1.name(생성자) : 유일성,널, 공백, 특수문자 허용안함(한글도)
		2.value(생성자) : String, 특수문자는 반드시 인코딩 필요함 (urlEncoder 활용)
		3.path : 다음번 요청이 발생시 쿠키의 재전송 여부를 결정하는 기준, 생략할 경우, 쿠키를 생성할 때의 경로가 반영됨
			<%
				Cookie diffCookie = new Cookie("diffCookie","diffCookieValue");
				diffCookie.setPath(request.getContentType()+"/09");
				response.addCookie(diffCookie);
				
				Cookie allPathCookie = new Cookie("allPathCookie","A11~path~");
				//allPathCookie.setPath(request.getContentType());//index.jsp로 의미
				allPathCookie.setPath("/");//서버에서 어떤 이벤트를 발생하든간에 계속 쿠키를 사용해야 한다면 이 설정
				response.addCookie(allPathCookie);
				
			%>
		4.domain/host: 다음번 요청이 발생시 쿠키의 재전송 여부를 결정하는 기준. 
		 	생략할 경우, 쿠키를 생성할 때의 도메인/호스트가 반영됨 
		 	도메인네임의 구조: www.naver.com : 3레벨구조  www는 호스트, 전세계 존재하는 회사중에서 네이버 라는 기관 하나를 지칭한거고, 
							GTLD : 글로벌적으로 사용이 된다고 하여
							www : world wide web 서버 호스트
							naver:
							com:	 	
		 					 
		 					www.naver.co.kr :4레벨 구조 , NTLD 지역적으로 사용 
		 					www:
		 					naver.
		 					co.kr : 한국에 소속되어 있는 회사
		 	쿠키라는 녀석을 식별할때는 
		 	1. 도메인
		 	2. 이름 
		 	3. path
		 	 이 3가지가 같아야 같은 쿠키				
		 	
		 	<%
		 	//domain 설정시 쿠키를 생성한 도메인과 depth구조의 연관성이 없다면 무시됨
		 	//내가 localhost로 실행했는데 setDomain이 다른거라면 localhost에선 안떰
		 		Cookie domainCookie = new Cookie("domainCooke","Domain~cookie");
				domainCookie.setDomain(".naver.com");//naver라는 도메인에서 다 사용할 수 있음 
				//현재 쿠키를 생성하고 있는 도메인과 레벨구조가 연관성이 있어야 한다.
				domainCookie.setPath("/"); //, 모든 경로에서 확인 가능
				response.addCookie(domainCookie);//> naver에 속한 모든 도메인, 모든 경로에서 확인 가능
		 	
		 	%>
		 	최종시연 : 조원 한명의 컴터를 운영서버, sempc에다가 운영서버ip와 도메인네임 하나 설정해놓기
		 	
		 	
		5.maxAge : 언제까지 살아 남길거냐, 쿠키의 만료시간(초단위)
			만료시간 설정 생략시 브라우저의 정책을 따라가나 일반적으로 세션의 만료시간을 따름
			경우에 따라서는 쿠키삭제에도 사용됨, 원칙적으로 쿠키는 클라이언트에 저장됨 
			클라이언트에 저장되어있는 쿠키를 서버사이드가 직접 삭제 할수 없음 
			직접 삭제하는 비슷한걸 만료시간으로 설정할수 있음 
			twoDaysCookie.setMaxAge(0); 거슬러 갈수 없기에 이렇게 설정하면 삭제됨
			name, domain, path 등의 설정이 동일해야 삭제 가능 
			
		
		<%
			//~이건 특수문자 아님, 아스키코드에서 해결 가능함
			Cookie twoDaysCookie = new Cookie("twoDaysCookie","Alive~for~two~days");
			//twoDaysCookie.setMaxAge(60*60*24*2);//세션시간과 별개로 시간을 설정하고 싶을때
			twoDaysCookie.setMaxAge(-1);//원래의 기본값으로 변경, 브라우저가 종료되면 같이 삭제하겠다.
			//시간을 설정할때 타입이 long이면 milisecond기준, int면 second기준
			//twoDaysCookie.setPath(request.getContextPath());
			
			response.addCookie(twoDaysCookie);
					
		%>
		
		
		<a href="viewCookie.jsp">같은 경로에서 쿠키 확인하기 </a>
		
		다른경로로 쿠키를 보낼건지 말건지 결정하는것을 path
		<a href="../09/viewCookie.jsp">다른 경로에서 쿠키 확인하기 </a>
		
		 		 
		<a href="../09/09_01/viewCookie.jsp">depth가 다른 경로에서 쿠키 확인하기 </a>
		
		쿠키 유틸리티 생성 하는 이유
		: 쿠키 생성하고, 꺼낼때도 너무 길어서  해결할수 있는 
		그리고 만들어서 jar파일로 만들기 
	
	</pre>
</body>
</html>