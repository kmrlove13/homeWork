<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="part1">
	<h2>PagePart1에서 생성된 응답일부</h2>
	<!-- 상대경로 <img src="../../06/Lighthouse.jpg"/>-->
	절대경로 :<img src="<%=request.getContextPath()%>/06/Lighthouse.jpg"/>
	<!--브라우저 기준이 아니기에 -->
	<!--여기서는 사진이 같은 폴더에 있지만, 브라우저에 pagePart1이 나올일이 없기에 basePage기준으로 작성해야함-->

</div>

<form>

	<input type="text" name="sample" value="확인용"/>
	<input type="submit" value="전 송"/>

</form>