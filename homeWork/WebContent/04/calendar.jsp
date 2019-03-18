<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.Calendar"%><!--  -->
<%@page import="static java.util.Calendar.*"%><!--캘린더 안에있는 스태틱멤버를 사용하고 싶을때-->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>04/calendar.jsp</title>
<STYLE type="text/css">

	table{
		/*겹치는 부분의 선을 두개로 할건지 하나로 할건지 ..등 */
		border-collapse: collapse;
	
		
	}
	
	td,th{
		/*td와 td의경계선*/
		border: 1px solid black;
		width: 150px;
		height: 80px;
		
	}

	th{
		height: 50px;
	}
	
	/*토요일 파란색 글씨색*/
	.sat{
		color: blue;
	}
	
	/*일요일 빨간색 글씨체*/
	.sun{
		color: red;
	}

</STYLE>

<SCRIPT type="text/javascript">

	/*요청의 응답은 폼하나로 통일하자 */
	function calFunction(yearParam, monthParam) {
		//js는 undefined true, defined false 를 구분함
		//js는 undefined 상황은 boolean타입으로 보고 true
		//그 다음은 널값 체크 
		//그 다음은 정수를 체크 
		//근데 0은 js에서는 false
		if(yearParam){//year라는 파라미터가 명시적으로 값이 넘어왔을경우
			//year라는 값을 가지고 있는 input태그를 찾아서 Param값을 넣어줘야됨
			document.calForm.year.value = yearParam;
		}if(monthParam || monthParam>=0){//0도 잡기위한 코드
			document.calForm.month.value = monthParam;
			
		}
		
		//코드를 짜서 코드에 의해 submit이라는 이벤트가 발생할수 잇도록
		//change 이벤트를 통해 submit() 을 강제로 호출
		document.calForm.submit();
		
	}


</SCRIPT>

<!--한가지 요청에 같은 기능을 가진 방식을 4개쓰고 있음
	단점: 요청이 겹칠때 각 요청이 적용되지 않음 , 변경 사항이 발생할대마다 코드를 다 수정해 주어야함 
	어떻게 하면 최소한의 노력으로 수정사항을 해결할수 있을까?
	- 창구를 하나로 결정하자(a태그-이전달, 다음달 을 요청해도 form태그를 거쳐서 요청이 날아갈수 있도록)
	현재 3창구의 공통점은 form 
	무조건 클라이언트에서 요청은 2번 서버로 날아감(3번이든 1번이든)
	
-->

</head>
<body>
	계속 반복되는 틀, 컬럼, 열 7개<br></br>
<% 
		Calendar cal= Calendar.getInstance();
		String yearStr = request.getParameter("year");		
		String monthStr = request.getParameter("month");
		//이 파라미터에 맞는 로케일을 만들어줘야함 
		String language= request.getParameter("language");	
		
		//마샬링 언마샬링 공통 사용.
		Map calendarMap=null; 
		ObjectMapper mapper = new ObjectMapper();
		Cookie[] cookies = request.getCookies();
		if(cookies!=null){
			for(Cookie tmp: cookies){
				if(tmp.getName().equals("calendarCookie")){
					String jsonString = URLDecoder.decode(tmp.getValue(),"UTF-8");
					//언마샬링하고나면 객체가 생성되 
					calendarMap= mapper.readValue(jsonString, HashMap.class);
				}
			}
		}
		
		
		
		//클라이언트 지역의 언어가 accept-Language로 넘어옴
		//이걸 사용하면 변경이 안됨, 변경을 할려면? 현재 자바안에서 처리할수 있는 로케일의 종류를 쭉 늘어놓고 
		//선택해야되
		//날짜를 일정한 형식으로 출력할때 사용하는 기호들
		Locale clientLocale = request.getLocale();//기본값
		
		if(StringUtils.isNotBlank(language)){
			clientLocale = Locale.forLanguageTag(language);
		}else if(calendarMap!=null){
			clientLocale = Locale.forLanguageTag((String)calendarMap.get("language"));
		}
		//우선순위 파라미터, 쿠키, 기본값
		DateFormatSymbols dfs = new DateFormatSymbols(clientLocale);
		
		if(StringUtils.isNumeric(yearStr) && StringUtils.isNumeric(monthStr)){
			cal.set(YEAR, Integer.parseInt(yearStr));
			cal.set(MONTH, Integer.parseInt(monthStr));
		}else if(calendarMap!=null){
			cal.set(YEAR, Integer.parseInt((String)calendarMap.get("year")));
			cal.set(MONTH, Integer.parseInt((String)calendarMap.get("month")));
		}
	
	
		//현재 년도와 열을 그대로 가지고 있는경우, 매개변수값을 가지고 있다던가 
		int year = cal.get(YEAR);
		int month = cal.get(MONTH);

		//한달에서 몇번째 날짜인지 , 3월 1일로 변경
		cal.set(Calendar.DAY_OF_MONTH, 1);
		
		//그날의 가장 마지막날이 언제인가를 동적으로 캐치해야함 
		int lastDate = cal.getActualMaximum(DAY_OF_MONTH);
		
		//일주일에서 몇번째 날짜가 요일, 0번째는 일요일..
		int firstDay = cal.get(Calendar.DAY_OF_WEEK);//3월1일의 요일
		int offset = firstDay-1;
		cal.add(MONTH, -1);
		
		int beforeYear =cal.get(YEAR);
		int beforeMonth =cal.get(MONTH);
		cal.add(MONTH,2);
		
		int nextYear = cal.get(YEAR);
		int nextMonth = cal.get(MONTH);
		cal.add(MONTH,-1);
		
		String[] displayMonth = new String[12];
		for(int idx=0;idx<displayMonth.length; idx++){
			displayMonth[idx] = (idx+1)+"월";
			
		}
%>	
	
	<form name ="calForm">	
		<INPUT type="hidden" name="includePage" value="calendar"/>
	<h4><!--다음번 요청의 방향을 결정하는 href를 사용-->
		<!--눈에는 안보이지만 사실은 주소가 전달됨, 그래서 ?이거 필요함-->
		<!--이 방법은 각개로 요청을 받아줌 하나로 합칠땐 이건 사용하면 안됨 
		<a href="?year=%=beforeYear %>&month=%= beforeMonth%>">이전달</a>-->
		<!--서버에게 클라이언트가 필요한 년도와 월을 요청함(매개변수로 건넴)-->
		<!--폼을 통해서만 나갈수 있게 설정하게 -->
		<!-- javascript: cal..>> 스키마구조-->
		<a href="javascript:calFunction(<%=beforeYear%>,<%=beforeMonth%>)">이전달</a> <!--서버에게 클라이언트가 필요한 년도와 월을 요청함(매개변수로 건넴)-->
		<input type="text" name="year" value="<%=year%>" onblur="calFunction()"/>년<!--입력되다가 입력칸에서 마우스가 벗어났을때-->
		<SELECT name="month" onchange="calFunction();"><!--변수값이 없어도 javaScript에서는 호출 가능함-->
			<%
				String optionPtrn = "<option value='%s' %s>%s</ioption>";
				for(int idx=0; idx<displayMonth.length; idx++){
					String selected ="";
					if(idx==month) selected="selected";
					out.println(String.format(optionPtrn, idx,selected,displayMonth[idx]));
				}
				
			%>
		
			<option value="0">1월</option>
		</SELECT>
		
		<!--변경을 했을때 이벤트가 발생할수있게-->
		<SELECT name="language" onchange="calFunction();">
			<!-- value에 locale코드(랭귀지태그) 설정
			<OPTION value='ko_kr'>한국어</OPTION>-->
			
			<%
			//현재 지원하는 로케일 정보를 싹 받아옴
		
			Locale[] locales = Locale.getAvailableLocales();
			for(Locale tmp: locales){
				//현재 환경에 따라 보여지는 언어가 다름 
				String displayLanguage = tmp.getDisplayLanguage(tmp);
				if(StringUtils.isBlank(displayLanguage)) continue;			
				//해당하는 로케일코드를 가지고오기
				String languageTag = tmp.toLanguageTag();
				//상태를 비교해야됨 , 그래서 ==사용못해
				String selected = tmp.equals(clientLocale)?"selected":"";
				//랭귀지태그 넘기고, 셀렉트 넘기고, 디스플레이 랭귀지 넘기고
				out.println(String.format(optionPtrn,languageTag,selected, displayLanguage));
			}
			
			%>
		</SELECT>
		
		<!--  <a href="?year=%=nextYear%>&&month=%=nextMonth %>">다음달</a> -->
		<!--폼의 방식을 이용하여 응답 단일화함-->
		<a onclick="calFunction(<%=nextYear%>,<%=nextMonth %>);">다음달</a>
	
	</h4>
	</form>
	
	<table>
		<THEAD>
			<tr>
			<%
		
				String ptrn2 = "<th>%s</th>";
				//th부분을 동적으로 
				String[] weekStr =dfs.getWeekdays();// 얘를 사용하면 이렇게 배열을 만들 필요가 없음
					//new String[]{"","일","월","화","수","목","금","토"};	
				for(int idx = 1; idx<=7; idx++){
					out.println(String.format(ptrn2,weekStr[idx]));
				}
			
			%>			
			</tr>
		</THEAD>
		<TBODY>		
		<%//이안에 들어가는건 데이터 
		//19년도 3월11일의 값
		
		
		//42번 반복되는 동안 카운트를 셀 친구가 필요함
		int count=1;
		String ptrn = "<td class='%s'>%s</td>";
		String classNM= "";//토요일, 일요일부분에 클래스 주기 
		for(int row=0; row<6; row++){
			out.println("<tr>");
			for(int col=1; col<=7; col++){
				//dayCount가 0보다 작거나 같으면 공백이 표시되게
				int dayCount=count++ -offset;
				String dayStr = (dayCount>0 && dayCount<=lastDate?dayCount:"&nbsp")+"";
				//1번째 열은 일요일
				if(col==1){
					classNM ="sun";
					
				}else if(col==7){//7번째 열은 토요일
					classNM="sat";
				}
				
				out.println(String.format(ptrn,classNM,dayStr));
			}
			out.println("</tr>");
		}
	
		%>
		</TBODY>
	</table>
	

</body>
</html>

<%
	//쿠키에 년, 월, 일을 설정
	//이 3가지를 따로따로 등록하지 말고 한꺼번에 등록하기
	/* Cookie yearCookie = new Cookie("yearCookie",year+"");
	yearCookie.setMaxAge(60*60*24*2);
	yearCookie.setPath(request.getContextPath());
	
	Cookie monthCookie = new Cookie("monthookie",month+"");
	yearCookie.setMaxAge(60*60*24*2);
	yearCookie.setPath(request.getContextPath());
	
	response.addCookie(yearCookie);
	response.addCookie(monthCookie);
	response.addCookie(monthCookie);
 */
 	Map<String, Object> cookieMap = new HashMap<>();
 	cookieMap.put("year",year);
 	cookieMap.put("month",month);
 	cookieMap.put("language",clientLocale.toLanguageTag());
 
 	//마샬링
 	
 	//마샬링을 한 이후에 저장할 방식,마샬링의 원본 객체 
 	String jsonString=mapper.writeValueAsString(cookieMap);
 	Cookie calendarCookie  =new Cookie("calendarCookie",URLEncoder.encode(jsonString));
 	calendarCookie.setMaxAge(60*60*24*2);
 	calendarCookie.setPath(request.getContextPath());

 	response.addCookie(calendarCookie);
 
%>