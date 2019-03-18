<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%!
	private void commandProcess(String command, File srcFile, File targetFile) throws IOException {
	
		if ("copy".equals(command) || "move".equals(command)) {//이런경우는 nullpoint 피해갈수 있다.
			try (//fileNot예외도 IOE에 속함
					FileInputStream fis = new FileInputStream(srcFile);
					FileOutputStream fos = new FileOutputStream(targetFile);) {
				int len = -1;
				byte[] buffer = new byte[1024];
				while ((len = fis.read(buffer)) != -1) {
					fos.write(buffer, 0, len);
				}
				fos.flush();
			}
			if ("move".equals(command))
				srcFile.delete();
		} else if ("delete".equals(command)) {
			srcFile.delete();
		} else {//우리가 처리할수 없는 매개가 넘어왔을때 익셉션 발생, 우리가 잘못한게 아닌데 400이라는 상태코드를 내보내야함
			throw new IllegalArgumentException("처리할 수 없는 명령");
		}
	}%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<SCRIPT src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></SCRIPT>
<SCRIPT type="text/javascript">

	$(function() {
		var hiddenTag = $("#hiddenCommand");
		$(".radioBtn").on("click", function() {
			var command = $(this).val();
			hiddenTag.val(command);
			//내 상위를 찾아내는 방법 1.parents, parent 2. closest
			hiddenTag.closest("form").submit();
		});
	})
</SCRIPT>
</head>
<body>
	<h4>servletContext application 기본 객체</h4>
	<form>
		<!--현재 브라우저의 주소, 직접입력을 받기위해서 만든게 아니라 데이터르 ㄹ넘기기위해 생성 -->
		<input type="hidden" name="command" id="hiddenCommand" />
	</form>
	<pre>
		:웹 어플리케이션과 서블릿 컨테이너(서버, WAS)에 대한 정보를 가진 객체이며, 
		하나의 어플리케이션을 대상으로 싱글톤의 형태로 관리됨(한 프로젝트 내에서는 싱글톤으로 관리)
		 1) 서버에 대한 정보 획득: 
		 	톰캣버젼 : <%=application.getServerInfo()%> 
		 	>>이게 더 많이 사용함 
		 	서블릿버젼 확인 : <%=application.getMajorVersion()%>, <%=application.getMinorVersion()%>
		 2) 로그를 기록 <%application.log("기록메세지");%> 
			클라이언트를 위한게 아님 , 서버에서 개발자를 위한 것 
		 	> 디버깅 용도, 서버를 분석할 용도, 서버는 클라이언트가 언제 요청하고 언제 병목현상이 발생하는지 언제 연락을 끊는지 
		 	다 로그로 기록을 남김   
		 	>로깅4 프레임웍 잘쓰기!
		 3) 어플리케이션의 초기화 파라미터(컨텍스트 파라미터) 획득
		 	>웹어플리케이션(톰캣) 자체를 대상으로 해서 파라미터 넘김 
		 	><%=application.getInitParameter("appParam1")%>
		 4) 서버의 웹 리소스를 확보할때 ********* 얘를 많이 사용 
		 	MimeText(문자열) = getMimeType(파일명)
		 	파일시스템경로(realPath) getRealPath(서버방식의 URL)
		 	getResourceAsStream(서버방식의 URL);
		 <!-- 기본값에 checked표시 서버에 데이터를 넘길 폼태그를 따로 생성,이벤트를 생성하기 class생성, 처음부터 있으면 
		  클릭할때 매개변수가 넘어가지 않음 
		  -->	
		 <INPUT type="radio" class="radioBtn" name="command" value="copy" /> 복사
		 <INPUT type="radio" class="radioBtn" name="command" value="move" /> 이동
		 <INPUT type="radio" class="radioBtn" name="command" value="delete" /> 삭제
					 
		
		 <%
			 	//모든 파일이 공통적으로 가진 경로는 파일시스템 경로, 이건 그 경로를 사용
			 	//파일시스탬 경로를 사용못하니가 가상의 경로를 부여해서 사용하는데, 이건 파일시스템의 경로를 알려주는것
			 	/* String fileSystemPath =application.getRealPath("/images/sakujun.jpg");
			 	out.println(fileSystemPath); */
			 	//이미지를 읽어올때 세단계의 작업이 필요함 파일객체, 경로 구하기, 아웃풋 이 단계를 줄여줌
			 	//url를 넘김
			 	//InputStream in = application.getResourceAsStream("/images/sakujun.jpg");
			 	//소스폴더의 url를 이용하여 파일시스템 경로를 찾아내서 파일객체 찾기 
			 	//자식파일들을 하나하나 대상으로 하여 06번에 복사 
			 	//06번 아래에 복사를 뜰수있는 포문을 돌리기
			 	
			 	String command = request.getParameter("command");

			 	if (StringUtils.isNotBlank(command)) {

			 		String SourceUrl = "/images";
			 		String targetUrl = "/06";

			 		File sourceFolder = new File(application.getRealPath(SourceUrl));
			 		File targetFolder = new File(application.getRealPath(targetUrl));

			 		String[] imageNames = sourceFolder.list((dir, name) -> {
			 			String mime = application.getMimeType(name);
			 			//오른쪽껀 체크를 할수도 있고 안할수도 있고, 앤드연산자는 둘중에 하나라도 안되면 오른쪽가지도 않음 
			 			//이런걸 short circuit and, or 연산자 사용할때 이 특성을 생각하며 순서를 정하기
			 			//return mime.startsWith("image/") && mime!=null; 이건 nullpoint뜸 순서 중요
			 			return mime != null && mime.startsWith("image/");
			 		});

			 		if (imageNames != null) {
			 			for (String imageName : imageNames) {
			 				//소스폴더에 있는 이미지파일
			 				File srcFile = new File(sourceFolder, imageName);
			 				File targetFile = new File(targetFolder, imageName);
			 				try {
			 					commandProcess(command, srcFile, targetFile);//예외 처리할 필요없음 원래의 서블릿에서 예외를 하고 있음

			 				} catch (IllegalArgumentException e) {
			 					response.sendError(400, "니 잘못");
			 					return;//break도 가능
			 				}

			 			}
			 		}

			 	}

			 	/*
			 		우리가 지금 작업하는 환경(이클립스)은 진짜 서버가 아님, 진짜 자원이 아님 
			 		리소스가 필요한 상황이 되었을때 하드코딩하지마, 배포할때 없으니까 
			 		이클립스에서 보는 경로는 진짜 경로가 아님 
			 		06번 폴더는 개발환경의 폴더- 개발하는 과정에서 만들어지는 임시 데이터
			 		진정한 데이터가 되기위해서는 배포를 해야함
			 		진짜 주소는 현재 서버를 기준으로 해서 설정 , 
			 		서버에서 사용하는것이 아님
			 	
			 	*/
			 %>
	</pre>
</body>
</html>