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
	<h4>기본객체(내장객체)</h4>

	<pre>
		: 선언, 생성하지 않아도 서블릿 소스 파싱 단계에서 기본 제공되는 객체 
		
		PageContext pageContext: 하나의 jsp에 대한 모든 , 가장 먼저 성생, 나머지 기본 객체를 포함하고 있는 객체 
			->제일 먼저 만들어지고, 나머지 기본객체에 대한 포괄적인 객체 , 나머지 기본객체를 생성할때 얘를 사용
			1) 나머지 기본 객체의 확보 
			2) 페이지 이동 -dispatch 방식 사용
				dispatch방식을 pageContext에서도 비슷하게 사용가능함
				<%
					RequestDispatcher rd =request.getRequestDispatcher("/05/idolForm.jsp");
					//rd.forward(request, response);//이걸 넘겨주기 때문에 분기 방식이라고 함
					//rd.include(request, response); 
					//pageContext.forward("/05/idolForm.jsp");//일종의 유틸리티, 맨위에 jsp페이지 그밑에 요청을 했었던 페이지
					pageContext.include("/05/idolForm.jsp");//이 코드가 작성된 공간에 jsp페이지가 들어옴, page를 모듈화 할때 사용 
					//모듈화: 하나의 완성된 응답데이터를 만드는 과정에서 역할을 분담해서 페이지를 쪼갤수있음
					//서버사이드 모듈화가 가능함 
					//세개이상의 jsp과정을 쪼개서 가능함 
					
					 
				%>
			
			3) 속성 데이터 확보 -next
			4) 에러 데이터 확보- next
			5) 
		
		HttpServletRequest request: 응답 정보를 가진 객체 
		
		HttpSession session: 한 세션과 관련된 정보를 가진 객체
			-> sessionDesc.jsp 참고
		
		ServletContext application: 웹어플리케이션과 서버에 대한 정보를 가진 객체 
			>06/servletContext
		JspWriter out: 출력스트림과 관련된 정보를 가진 객체 버퍼
		
		ServletConfig config: 서블릿의 설정 정보를 가진 객체 
		
		Object page :JSP 페이지의 인스턴스 
		
		Throwable exception : 예외가 발생했다면, 해당 예외에 대한 참조 객체 .
			-에러를 처리하기 위해 isErrorPage속성을 설정한 페이지에서 활성화 
			
		
		<%=	pageContext.getRequest() == request%>
		<%=	pageContext.getServletContext().hashCode()%>
		<%=	application.hashCode()%>
		
		
		db세션 : 커넥션이 생성된 순간부터 끊어질대까지의 기간
		세션: 어플리케이션을 사용한 순간부터 종료전까지의 기간 
		application: 나를둘러싼 환경을 통칭 context라고 부름, 서블릿을 가지고 있는 정보와, 서블릿에 대한 정보, 어플리케이션 하나당 서블릿에대한 정보 하나, 싱글톤
			
		
		pageContext: 둘러싼 jsp정보
		매핑했던 정보들로 서블릿객체가 만들어짐, 그렇게 만들어진 서블릿객체가 이닛을 통해 서블릿에 전해짐 
		page : 톰캣이 만들어진 객체 정보를 확인 내안에서 접근할때 사용, 제대로 써먹을려면 다운캐스팅 해야됨, 하지만 클래스 모르니까 사용 못함 차라리 this를 사용해 ==this랑 비슷()
		exception:  Throwable: 모든에러와 모든 예외의 최상위  익셉션을 생성해서 흐름을 끊어야 될때가 있음, 나만의 커스텀 익셉션을 만들려면 언체크, 체크를 알아야함
			
		

	</pre>


</body>
</html>