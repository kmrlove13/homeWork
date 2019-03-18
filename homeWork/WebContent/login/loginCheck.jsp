<%@page import="kr.or.ddit.utils.CookieUtil.TextType"%>
<%@page import="kr.or.ddit.utils.CookieUtil"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<%
	//이건 서블릿스펙으로 생성하는 것이 낫다 
	//왜냐하면 이동하는것 밖에 없음
	//중복된 코딩 제거 
	//공통된 속성 이동 
	String goPage=null;
	boolean redirect = false;
	//1. 파라미터 확보 
	String id = request.getParameter("mem_id");
	String pass = request.getParameter("mem_pass");
	//쿠키 사용 조건 , id기억하기 value값 가져오기
	String saveId = request.getParameter("saveId");
	//쿠키 만료시간 저장할 변수
	int cookieTime = 0;
	
	
	//2. 검증, 널값, 필수파라미터 전송했는지
	//내가 인증에 성공했다, 내가 인증에 실패했다 -> 유저랑 관련된 데이터 그래서 최소한의 영역은 session
	
	if(StringUtils.isBlank(id) || StringUtils.isBlank(pass)){
	//검증에 실패한 경우: 원본요청의 파라미터가 생존한채 전달 	
		redirect = true;
		goPage="/login/loginForm.jsp";
	//id기억하기 체크 안했음 체크가 안되었다면 기억하지 않겠다는 거니까 저장된 아이디 지워져 maxAge=0
	//만료시간 저장할 변수 기본값이 0이니까, 여기서는 그냥 넘어감
			
	}else{ 
		//3. 아이디 비번은 작성한 후  
		if(id.equals(pass)){//인증성공 : 인덱스 페이지로 이동 , 원본요청 전달할 필요 없음 redirect
			if(!StringUtils.isBlank(saveId) && "saved".equals(saveId)){//id기억하기 value값 비교
				cookieTime=60*60*24*7; //7일기억할수 있게
			}
			redirect = true;
			//goPage ="/index.jsp?mem_id="+id; 데이터가 노출됨
			session.setAttribute("authId",id);// 어트리뷰는 이름과 값으로 구성됨, 이 세션은 맵으로 이루어져 있는데 이 맵을 스코프라고 부럼
			goPage ="/";
			
		}else{
			//아이디 비번이 맞지않다면
			if(!StringUtils.isBlank(saveId) &&"saved".equals(saveId)){//id기억하기 value값 비교
				cookieTime=60*60*24*7; //7일기억할수 있게
			}
			redirect=true;
			session.setAttribute("failedId",id);
			goPage ="/login/loginForm.jsp";
		}
	}	
	
	Cookie idCookie = CookieUtil.createCookie("idCookie", id, request.getContextPath(), TextType.PATH, cookieTime);
	response.addCookie(idCookie);
	
	if(redirect){//redirect 값이 true라면
		response.sendRedirect(request.getContextPath()+goPage);
	}else{ 
	//redirect 값이 false라면
		RequestDispatcher rd = request.getRequestDispatcher(goPage);
		rd.forward(request, response);
	}
	
%>


<!--
	1.파라미터 확보(
	2.검증(필수파라미터 전송)
	3.불통(누락) 다시 로그인 하라 loginForm으로 다시 이동 , 아이디는 완료인데 비번이 불통이면  원본요청의 파라미터가 생존한채 전달 
	4.통과(아디와 비번이 동이하면 인증 성공)db를 사용할 수 없으니까 
		4-1 인증성공 : 인덱스 페이지로 이동 , 원본요청 전달할 필요 없음 redirect
		4-2 인증 실패 : loginForm으로 다시 이동 , 아이디는 완료인데 비번이 불통이면  원본요청의 파라미터가 생존한채 전달 
-->
