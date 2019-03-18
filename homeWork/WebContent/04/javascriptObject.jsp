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

	<pre>
		자바스크립트와 json
		-json과 xml 등이 왜 필요한지 
		
		ex) 알바생을 모델링 해보자 객체의 특성을 알아보자
		알바생 한명: 이름, 나이, 휴대폰
		
		-java형식 
			class AlbaVO{
				데이터의 객체를 선언하고 타입을 지정하고 값을 할당
				String name ="명노현";
				int age =20;
				String ph ="000-0000-0000";
			}	
			접근방법
				> new AlbaVO.name;
			
		-javaScript 형식
			AlbaVO{
				타입은 있지만 사용하지 않음 
				name : "이진경",
				age: 23,
				hp: "000-0000-0000"
			}
			접근방법
				>new AlbaVO.name;
		
		json을 이용하는 이유
			서버사이드, 클라이언트 사이드에서 돌아가는 언어가 달라 
			서로 다른 언어 상황에서 요청과 응답이 오고가야해 
			서로의 언어를 해석해야하는데 둘다 이해할수있는 언어가 필요해(서로가 이해할 수 있는 언어(영어)>>json) 
			맨처음엔 xml형태로 나왔다가 너무 무겁고 까다로워서 json이 나옴
			
		 -XML형식
		 <AlbaVO> 하나의 데이터를 보내기 위해 다른 데이터도 같이 보내야해 -> 무거움
		 	<name>이진경</name>
		 	<age>34</age>
		 	<hp>010--000--0000</hp>
		 </AlbaVO>						
			
		-JSON형식  javaScriptObject 객체를 표현하는 방식, 그 근간은 자바스크립트에서 따옴
		{
			"name" : "이진경",
			"age"  : 34,
			"hp"   : "000-0000-0000";
		}
		제이슨데이터를 보내면 제이쿼리가 데이터를 자바스크립트에서 꺼내서 번역함 ->resp.객체를 꺼냄 
		클라이언트에서 서버로 json으로 보낸 데이터를 자바언어로 해석하는것을 언마샬링 xml, json->native 
		서버에서 클라이언트로 자바를 json으로 변경해서 보내면  마샬링 native->xml, json
		이기종 시스템간의 서로의 의사소통을 하기 위해서 
		
		
		
			
	</pre>


</body>
</html>