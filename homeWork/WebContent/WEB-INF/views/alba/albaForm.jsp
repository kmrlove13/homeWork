<?xml version="1.0" encoding="utf-8" ?>
<%@page import="kr.or.ddit.alba.AlbaRegistControllerServlet"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.vo.AlbaVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html> 
<!--템블릿파일하고 jsp랑 비교하기!-->
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>02/albaform.jsp</title>
<SCRIPT type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></SCRIPT>

<jsp:useBean id="alba" class="kr.or.ddit.vo.AlbaVO" scope="request"></jsp:useBean>
<jsp:useBean id="errorsMap" class="java.util.HashMap" scope="request"></jsp:useBean>

</head>
<body>
<h4>알바천국 가입 양식</h4>
<!--서버는 클라이언트에서 넘어오는 절대 믿지마라, 안전장치인 검증을 하자, 클라이언트와 서버 양쪽으로 검증-->
<!--요청을 발송할때는 보호해야 하니까 post -->
<!-- 수정사항도 같이 사용해야 하니까 이거 사용하면 안돼 <form action="%=request.getContextPath()%/albaregist.do" method="post"> -->
<form method="post">
	<table>
		<tr>
			<th>ID</th>		
			<td>			
				<input type="hidden" name="id" value="<%=Objects.toString(alba.getId(),"")%>"/>
			</td>
		</tr>
		<tr>
		<tr>
			<th>이름</th>		
			<td><!--required 필수사항, 널값이면 submit이 되진 않음, 알림창은 개발자가, 클라이언트에서 걸러낼수있다고 생각하지마라-->
				<!-- Objects.toString 자바에서 삼항연산식-->
				<input type="text" name="name" required="required" value="<%=Objects.toString(alba.getName(),"")%>"/>
				<span class="error"><%=Objects.toString(errorsMap.get("name"),"") %></span>
			</td>
		</tr>
		<tr>
			<th>나이</th>	<!--형태는 number지만 넘어갈때는 string-->	
			<td><!--required 필수사항, 널값이면 submit이 되진 않음, 알림창은 개발자가, 클라이언트에서 걸러낼수있다고 생각하지마라-->
				<input type="number" name="age" required="required" min="10" max="100" value="<%=Objects.toString(alba.getAge(),"")%>"/><!--min과 max를 통해 나이 제한 가능-->
			</td>
		</tr>
		<tr>
			<th>주소</th>		
			<td>
				<input type="text" name="addr" required="required" value="<%=Objects.toString(alba.getAddr(),"")%>"/>
				<span class="error"><%=Objects.toString(errorsMap.get("address"),"") %></span>
			</td>
		</tr>
		<tr>
			<th>휴대폰</th>		
			<td><!--placeholder 입력제한 아님, 형식을 보여줄뿐, 제한은 pattern으로 하고 정규화로-->
				<input type="text" name="hp" required="required" placeholder="000-0000-0000" pattern="\d{3}-\d{4}-\d{4}" value="<%=Objects.toString(alba.getHp(),"")%>"/>
			</td>
		</tr>
		<tr>
			<th>이메일</th>		
			<td>
				<input type="email" name="mail" value="<%=Objects.toString(alba.getMail(),"")%>"/>
			</td>
		</tr>
		<tr>
			<th>성별</th>		
			<td><!--기본적으로 둘중에 하나는 선택checked, 불린타입이라 생략 가능-->
				<label><input type="radio" name="gen" value="남" checked />남</label>
				<label><input type="radio" name="gen" value="여" />여</label>
			</td>
		</tr>
		<tr>
			<th>혈액형</th>		
			<td>
				<select name="btype">
				<!--데이터베이스나, 컬렉션으로 만들었으면 "B".equals(albaVo.getBtype())?"selected":""이렇게 안해도됨-->
					<option value="a">a</option>
					<option value="b" <%="B".equals(alba.getBtype())?"selected":"" %>></option>
					<option value="o">o</option>
					<option value="ab">ab</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>최종학력</th>		
			<td>
				<select name="grade">
					<option value="g001">고졸</option>
					<option value="g002">초대졸</option>
					<option value="g003">대졸</option>
					<option value="g004">석사</option>
					<option value="g005">박사</option>
				</select>
				<script>
				//name속성이 grade의 value에, selected는 일일히 하나하나 설정, 여기서 하는건 select의 val에 getGrade의 값을 넣어라 
				//이 방법은 멀티플이 안됨
				$("[name='grade']").val("<%=alba.getGrade()%>");
					
				
				</script>
			</td>
		</tr>
		<tr>
		<%
		//자격증은 배열로 받으니까 다시 돌아왔을때 선택되어있는것이 다시 선택되게 하는법
			Map<String, String> licMap =(Map<String, String>)getServletContext().getAttribute(AlbaRegistControllerServlet.LICMAPATTR);
			licMap.put("l001","정보처리기사");
			licMap.put("l002","sql자격증");
			licMap.put("l003","정보보안기사");
			licMap.put("l004","정보처리산업기사");
			
			
			String ptrn="<Option value='%s' %s>%s</option>";
			StringBuffer options = new StringBuffer();
			
			for(Entry<String,String> entry:licMap.entrySet()){
				String selected="";
				String licCode = entry.getKey();
				String[] lics = alba.getLic();
				
				if(lics!=null){//이진검색, 구간을 두개로 쪼개서 가운데 값을 양쪽과 비교해서 작으면 왼쪽 크면 오른쪽
					//정렬을 먼저 해야됨 
					Arrays.sort(lics);
						//배열안에서 찾아내면 키값(index)이 돌아온다.
					if(Arrays.binarySearch(lics, licCode)>=0){
						selected ="selected";
					}
				}
				options.append(
					String.format(ptrn, licCode, selected, entry.getValue())	
						);
			}
		
		%>
		
			<th>자격증</th>		
			<td><!--여러개를 선택할 수 있도록 , multiple 불린값으로 값은 생략 가능-->
				<select name="lic" multiple size="6">
					<%=options %>
				</select>
			</td>
		</tr>
		<tr>
			<th>경력사항</th>		
			<td>
				<textarea name="career" rows="5" cols="100" ><%=Objects.toString(alba.getCareer(),"")%></textarea>
			</td>
		</tr>
		<tr>
			<th>특기사항</th>		
			<td>
				<textarea name="spec" rows="5" cols="100" ><%=Objects.toString(alba.getSpec(),"")%></textarea>
			</td>
		</tr>
		<tr>
			<th>자기소개</th>		
			<td>
				<textarea name="desc" rows="5" cols="100"><%=Objects.toString(alba.getDesc(),"")%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="전 송"/>
			</td>
		
		</tr>
	
	</table>






</form>
<!--
가입양식이 누락된 사람들, 검증에 실패한 사람들
request.scope를 이용하여 이전의 값을 가져와서 다시 복원해놓기
-->





</body>

<!--  프로필 : 이름(name,문자), 나이(age,숫자), 생년월일(birth,문자),주소(addr, 문자),전번(hp,문자),특기사항(spec, 문자), 자기소개(desc,문자), 자격증(lic코드형 문자)
학력(grade코드형 문자), 경력사항(career문자), 성별(gen선택형 문자), 혈액형(btype선택형 문자), 이메일(mail문자)
코드형문자: 고졸은 a100 대졸은 b100이런식으로 디비에 저장된 형식으로 , char형식, 고정형 길이로 받아서 그외는 입력할수없도록

설계 - 정보에 대한 설계 : 데이터베이스에 데이터를 어떻게 관리할것인가 
				알바생의 프로필에 들어가는게 무엇인가 세세하게 분석
				종류(이름,나이..)-> 각 항목의 길이, 특징 분석(이름은 문자, 나이 숫자, 성별 선택형문자..등)->
				
	- 어플리케이션에 대한 설계 :-->


</html>

