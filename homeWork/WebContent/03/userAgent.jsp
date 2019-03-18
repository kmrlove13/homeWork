<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="com.sun.xml.internal.org.jvnet.fastinfoset.stax.LowLevelFastInfosetStreamWriter"%>
<%@page import="kr.or.ddit.enumpkg.OsType"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	
	<%
	//순서때문에 고민될때는 얘를 맨위로 올려도됨, 어디에 두든 SERVICE 안이니까 
		String res1 = "";
		String res2 = "";
		String value =request.getHeader("User-Agent");
		String rowVal = value.toUpperCase();
		
		
		/* Map<String, String> wMap = new HashMap<String, String>();
		wMap.put("window", "당신의 접속 환경은 window입니다.");
		wMap.put("android", "당신의 접속 환경은 android입니다.");
		wMap.put("mac", "당신의 접속 환경은 mac입니다.");
		
		Map<String, String> bMap = new HashMap<String,String>();
		bMap.put("ie","당신의 브라우저는 익스플로러입니다.");
		bMap.put("chrome","당신의 브라우저는 크롬입니다.");
		bMap.put("firefox","당신의 브라우저는 파이어폭스입니다.");
		
		Set<String> keyset = wMap.keySet();
		for(String key: keyset){
			if(rowVal.contains(key)){
				res1 = wMap.get(key);	
				break;
			}else{
				res1 = "알 수 없는 접속환경입니다.";
			}
		}

		Set<String> bset = bMap.keySet();
		for(String key: bset){
			if(rowVal.toLowerCase().contains(key)){
				res2 = bMap.get(key);
				break;
			}else{
				res2 = "알 수 없는 브라우저 입니다.";
			}
		} */
	
		
		//enum 이용
		OsType osType = OsType.matchedType(rowVal);
		res1 = osType.getText();
		
		Type[] type= Type.values();
		
		for(Type type2 : type){
			if(rowVal.contains(type2.name())){
				res2 =type2.getText();
				break;
			}else{
				res2="특이한 브라우저";
			}
		}
		
	%>    
    
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>03/userAgent.jsp</title>
<script src="/webStudy01/js/jquery-3.3.1.min.js"></script>

<SCRIPT type="text/javascript">
	
	$(function(){
		/*alert('<%=res1+" 그리고 "+res2+"입니다."%>');*/
		alert('<%=res1%>\n<%=res2%>');// \n은 클라이언트방법으로 
		
		
	});
</SCRIPT>


	
</head>
<body>
	<h4>클라이언트의 접속 환경을 확인(User-Agent)</h4>
	3가지의 조건 : 윈도우 계열(window), 애플 계열(mac,iphone), 안드로이드 계열(android)
	3가지 조건 : IE(익스플로어), chrome(크롬), firefox(파이어폭스)
	ex: 당신의 접속 환경은 --- 입니다.
	ex: 당신의 브라우저는 ---입니다.(크롬,파이어폭스..)	
	모든 메세지는 alert로 
	자바코드, 자바스크립트(alert), html
	
	<!--1. 클라이언트의 헤드 정보 가지고 오기 
		2. 헤드 정보중 userAgent만 구별하기 
		3. userAgent의 접속환경 3가지 조건 구하기 
		4. userAgent의 브라우저 3가지 조건 구하기
	
	-->
	<%!
		enum Type{
			//순서 지킬것! 상수를 먼저, 그 밑에 변수 선언
			IE("익스플로러 브라우저"), CHROME("크롬 브라우저"), FIREFOX("파이어폭스 브라우저");
			final private String text; 
			String getText(){
				return text;
			}
			Type(String text){
				this.text = text;
			}
		}
	%> 
	
	
	
	<div>
		<%="당신은"+res1+"이고,"+res2+"이네요^^" %>	
		
	</div>
	
	
	
</body>
</html>