<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<%
	String imgName = (String)request.getAttribute("imgName");
%>
<script src="/webStudy01/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		var pattern = '<img src="%C?selImg=%I"/>';//여기서 상대경로가 사용됨
		var imageArea = $("#imageArea"); //값이 바뀔때마다 다시 찾을 필요없으니까 여기다가 작성, 트레이싱이 남발되지 않도록

		$("[name='selImg']").on("change", function(event) {
			var selImg = $(this).val();
			var form = $(this).closest("form");
			var imgTag = //폼이 가지고 있는 액션속성의 값
			pattern.replace("%C", form.attr("action")).replace("%I", selImg);
			imageArea.html(imgTag);
		});
		
		
		 <%
			if(imgName!=null){
		 %>
		 	$("[name='selImg']").val("<%=imgName%>"); /* select name이 selImg의 value값을 imgName으로 설정*/
		 	$("[name='selImg']").trigger("change");
		<%
			}
		%>
		

		//전송버튼 눌러도 사진이 나오고, 선택해도 사진이 나오고
		$("#imgForm").on(
				"submit",
				function(event) {
					event.preventDefault();
					//event.preventDefault();이거 없으면 이코드는 불안해 , 리턴전에 에러가 나면 리턴이 실행되기전에 화면이 넘어감
					var selImg = $("[name='selImg']").val();
					var imgTag = pattern.replace("%C", $(this).attr("action"))
							.replace("%I", selImg);
					imageArea.html(imgTag);
					return false;
				});
	});
</script>


<body>
	<h4>이미지 목록</h4>
	<form id="imgForm" action="<%=request.getContextPath()%>/image.do"
		method="post">

		<select name="selImg">
			<%
				File[] imageFiles = (File[]) request.getAttribute("imageFiles");
				String ptrn = "<option>%s</option>";
				for (File tmp : imageFiles) {
					out.println(String.format(ptrn, tmp.getName()));
				}
			%>
		</select> 
		<input type="submit" value="전  송" />
	</form>
	<br>
	<br>
	<div id="imageArea"></div>
	
</body>
</html>
<!--  
	3일숙제
	1. view 
	2. copy, move, delete 
	파일브라우저 목록 보여야됨 
	폴더가 있고 파일이 있으니 어떤 폴더를 클릭햇을때 해당 폴더로 들어갈수 있어야됨 화면이 전환되며 파일들이 나와야함 
	또다른 폴더가 있다면 그 폴더를 선택하면 화면이 전환하면서 보여줘야됨 
	최종적으로 이렇게 파일들이 보여졌다면 
	파일을 선택하고 copy, delete, move해주기 


-->



<!--셀렉트가 변경되면 change함수-->
<!--event.target == $(this) 이벤트를 발생시킨 녀석들, img src(출처)에는 나를 대신해서 이미지를 읽어주는 중개자를 적음-->
<!--대신, 파라미터의 값에 따라 사진이 바뀌니까 주소에 쿼리스트링으로 작성 innerHTML == html() 같은거야-->
<!--doPost였지만 그림은 get방식이기 때문에 provider 메서드를 service로 변경-->
<!--인터프리티 방식은 위에서 순서적으로-->
