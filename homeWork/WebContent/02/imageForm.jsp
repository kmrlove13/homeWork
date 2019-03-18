<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
	<script src ="/webStudy01/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
	
		
	
		$(function(){
			var pattern = '<img src="<%=request.getContextPath()%>/image.do?selImg=%I"/>';
			var imageArea = $("#imageArea"); //값이 바뀔때마다 다시 찾을 필요없으니까 여기다가 작성, 트레이싱이 남발되지 않도록
			
			$("[name='selImg']").on("change", function(event){
				var selImg = $(this).val();
				var imgTag = pattern.replace("%I",selImg);
				imageArea.html(imgTag);
			});
			
			//전송버튼 눌러도 사진이 나오고, 선택해도 사진이 나오고
			$("#imgForm").on("submit", function(event){
				event.preventDefault();//액션이벤트를 뺏어오는것
				//event.preventDefault();이거 없으면 이코드는 불안해 , 리턴전에 에러가 나면 리턴이 실행되기전에 화면이 넘어감
				var selImg = $("[name='selImg']").val();
				var imgTag = pattern.replace("%I",selImg);
				imageArea.html(imgTag);
				return false;
			});
		});
	</script>
	
	
	<body>
	<%!File sampleFolder; %>
		
		<h4>이미지 목록</h4>
			<form id="imgForm" action="/webStudy01/image.do" method="post">
			
				<select name="selImg">
				<%=imgList()%>
				</select>	
				<input type="submit" value="전  송"/>
		</form>
		<br>
		<br>	
		
		<div id="imageArea">
		
		</div>	
			
		<%!
		public StringBuffer imgList(){
			ResourceBundle bundle = ResourceBundle.getBundle("kr.or.ddit.servlet01.sample");
			String folderPath = bundle.getString("sampleFolder");	
			sampleFolder = new File(folderPath);
			
			File[] fileName = sampleFolder.listFiles
					(new FilenameFilter() {
				
				@Override
				public boolean accept(File dir, String name) {
					String mimeText = getServletContext().getMimeType(name);
			         return mimeText.startsWith("image/");
				}
			});
			
			StringBuffer buff = new StringBuffer();
			String pat = "<option value='%1$s'>%1$s</option>";
			
			//파일이 없을수도 있어
			if(fileName != null) {
				for(File temp : fileName) {	
					buff.append(String.format(pat, temp.getName()));
				}//for end
			}//if end
			
			return buff;
		}
		
		%>	
			
	</body>
</html>	
