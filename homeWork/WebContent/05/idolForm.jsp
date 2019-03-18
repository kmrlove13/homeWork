<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="kr.or.ddit.vo.itzyVO"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<SCRIPT type="text/javascript">
	function submitHandler(event) {
	//발생한 이벤트의 타겟
		var form = event.target;	
		var selValue=form.itzy.value;
	//""가 js에선 false로 인식
	//	alert(selValue?true:false);
	//이벤트 핸들러가 작동이 안될 때 
	//콘솔 확인 
	//소스라는 태그에서 ctrl+b 소스파일열고 펑션부분 확인, 펑션부분 디버깅 
	
		if(!selValue){
			//요청 발생시켰다면 
			return false;
		}else{
			return true;// 호출자쪽에서 리턴값을 가져감 submitHandler가
		}
	}
</SCRIPT>
<%
	Map<String, itzyVO> itzyMap=new LinkedHashMap<>();//지네릭스 뒤에는 생략 가능함 1.7부터,  jdk는 1.8이지만, 톰캣이 컴파일하는데 톰캣의 자바
	application.setAttribute("itzyMap", itzyMap);
	itzyMap.put("yezi",new itzyVO("예지","/itzy/yezi.jsp"));
	itzyMap.put("ria",new itzyVO("리아","/itzy/ria.jsp"));
	itzyMap.put("ryuzin",new itzyVO("류진","/itzy/ryuzin.jsp"));
	itzyMap.put("cheryung",new itzyVO("채령","/itzy/cheryung.jsp"));
	itzyMap.put("yuna",new itzyVO("유나","/itzy/yuna.jsp"));

%>

</head>
<body>
	<pre>
	
팀원의 목록 생성
팀원을 선택하면 컨텐츠 페이지 제공 
</pre>

	<!--액션을 설정: 파라미터가 생겼을때 누가 파라미터를 사용할것인지 결정
	어떤 이벤트를 강제로 발생시켜 일정한 코드를 수행한다. - 트리거
	 셀렉트에서 체인지 이벤트가 발생시키면 폼을 대상으로 서브밋이 발생하고 
	 옵션 이름의 파라미터가 서버로 전달되게
	 submit을 실행시켜 func을 실행시키게 -트리거 구조 
	 어떤 이벤트를 통해 다른 이벤트를 동작시킬 목적
	지금 이폼의 궁극적인 목적은 func의 실행 
	

-->
<!--event매개변수 :발생한 submit의 이벤트까지 사용가능
리턴값을 받아서 리턴값에 따라 submit()을 핸들링
이벤트핸들러를 갖다 붙이는 녀석, 사식 익명함수가 만들어져 있고 그안에 코드를 작성 
리턴 펄스가 되었다는건 리턴을 취소-->
<!--submit이 되더라도 현재브라우저(index)기준 화면분할-->
	<form onsubmit="return submitHandler(event);" name='idolForm'>	
		<%-- action='<%=request.getContextPath()%>/05/getMemberPage.do'> --%><!--서블렛 주소를 -->
		<!--도큐먼트가 가지고 있는 id가 submitBtn이라는 요소를 -->
		<INPUT type="hidden" name="includePage" value="GETMEMBERPAGE"/>
		<SELECT name="itzy" onchange="document.getElementById('submitBtn').click();">
			<OPTION >멤버</OPTION>
			<%
				String ptrn = "<option value='%s'>%s</option>";			
				for(Entry<String,itzyVO> entry : itzyMap.entrySet()){
					String code = entry.getKey();
					itzyVO vo = entry.getValue();
					
					out.println(String.format(ptrn, code, vo.getName()));
				}
			%>
		</SELECT>
	<input id="submitBtn" type="submit" value="확인용"/>
	</form>
	<h4>idolForm : <%=application.hashCode()%></h4>
	<h4>servletContext : <%=getServletContext().hashCode()%></h4>
	
	
</body>
</html>