<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="8kb" autoFlush="true" isErrorPage="true"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>05/bufferDesc</title>
</head>
<body>
	<h4>출 력 버 퍼</h4>
	<pre>
		전송 속도를 높이는 거라 Response랑 관련이 있음
		웹 어플리케이션서 응답 전송 효율을 향상시키기 위해 사용되는 저장 공간.
		출력데이터를 기록하는 과정중에 버퍼가 사용됨 
		out: 버퍼를 핸들링 
		버퍼의 크기 : <%=out.getBufferSize() %> byte
		버퍼의 남은 용량: <%=out.getRemaining()%>byte
		<%
			//버퍼가 꽉 찼을때 어떻게 되는지 확인하기 위해 
			for(int i=1; i<100; i++){//한번돌때마다 24byte가 생김
				//autoFlush 버퍼가 꽉차면 자동으로 버퍼를 비움
				//autoFlush가 false이면 자동으로 비워지지가 않음 
				//수동방출방법
				if(i%10==0){//10번마다
					out.flush();//수동으로 방출
				}
			
				if(i==80){
					throw new RuntimeException("강제발생예외");
				}
			
				out.println(i+"번째 기록<br />");				
			}
		
		
	
		
		
		
		%>
	</pre>


</body>
</html>