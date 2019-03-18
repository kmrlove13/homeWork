<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<form id="cmdForm" action="<%=request.getContextPath()%>">
	<input type="hidden" name="includePage"/>
</form>	

<ul class="nav flex-column"><!-- 모든 요청은 form에서만, a에 있는 주소는 주소가 아니라 값-->
	<li class="nav-item" >
		<a class="cmdA nav-link" href="gugudan">구구단</a>
	</li>
	
	<li class="nav-item">
		<a class="cmdA nav-link" href="idolForm">아이돌</a>
	</li>
	
	<li class="nav-item">
		<a class="cmdA nav-link" href="calendar">달력</a>
	</li>
	
	<li class="nav-item">
		<a class="cmdA nav-link" href="sessionTimer">세션타이머</a>
	</li>
	
	<li class="nav-item">
		<a class="cmdA nav-link" href="imageForm">이미지뷰</a>
	</li>
	
</ul>

  
<script type="text/javascript">
	var cmdForm = $("#cmdForm");
	
	$(".cmdA").on("click", function(event) {
		event.preventDefault();
		
		var href = $(this).attr("href");
<%-- 		$(this).attr("href", "<%=request.getContextPath() %>"+href);  --%>
		cmdForm[0].includePage.value = href; //html방식
		cmdForm.find("[name='includePage']").val(href);//jquery방식
		cmdForm.submit();
		
		return false;
	});
</script>