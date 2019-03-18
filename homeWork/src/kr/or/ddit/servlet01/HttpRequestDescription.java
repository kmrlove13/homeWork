package kr.or.ddit.servlet01;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *Http  Requst
 * 1. Request Line
 * 		URL, Protocol, Http Method
 * 		Http Method : 요청의 목적/ 의도/ 방식
 * 			1)Get(조회) : 대부분의 요청은 GET방식
 * 				form태그이 method 속성으로 변경 가능.
 * 				조회 목적의 요청이므로 body 영역을 구성하지 않음
 * 			2)Post(등록, create) : 데이터 전송 목적의 요청
 * 			3)Put(수정,update)07230723Jjsp
 * 			4)Delete(삭제)
 * 			5)Head
 * 			6)Option
 * 			7)Trace
 * 2. Requst Header : client와 request에 대한 부가정보 (metadate)
 * 		이름과 값의 쌍으로 전달됨[name:value]
 * 		ex) Accept, Accept-language, User-Agent	
 * 
 * 3. Requst Body(Content Body) : 클라이언트가 서버로 보낼 내용(파라미터등..)
 * 
 * ==> MiddleWare(Server, WAS, ServletContainer, Tomcat)
 * 		전달된 요청을 캡슐화해서 HttpServletRequest 객체를 생성
 * 
 *  클라이언트에서 서버로 파라미터를 전송하는 방법 
 *  1)get: Line영역을 통해 URL의 일부 형태로 전송
 *  	URL?QueryString Section1&section2 param_name = param_value로 구성
 *  2)post: body영역을 통해 전송
 *  
 *  **파라미터에 특수문자가 포함된 경우 
 *  IETF 에서 정한 RFC2396규약에 따라 % 인코딩(URIEncoding)방식으로 인코딩됨 
 *  ex)%EB%%8D%....
 *  1)post : server.xml > connector(http) > URIEncoding useBodyEncodingFor
 *  2)get :
 *  
 */
@WebServlet("/httpReq.do")
public class HttpRequestDescription extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//super.service(req, resp);각 메서드에 관한 정보들을 구별하지 않을거면 삭제 
		//Line부분의 값들을 조회
		System.out.println("=============LINE=====================");
		String uri =req.getRequestURI();
		String protocol = req.getProtocol();
		String httpMethod = req.getMethod();
		System.out.printf("Line : %s %s %s\n", uri, protocol,httpMethod);
		
		
		System.out.println("=======================HEADER==========");
		//Header부분의 값들을 조회
		Enumeration<String> headerNames = req.getHeaderNames();//header의 이름을 받는거기 때문에 String으로
		
		while (headerNames.hasMoreElements()) {
			String name = (String) headerNames.nextElement();
			String value = req.getHeader(name);
			System.out.printf("header : %s : %s\n", name, value);
		}
		req.setCharacterEncoding("UTF-8");//post는 이것만 해도 됨 , get은 server.xml 수정해야됨 
		//클라이언트에서 전달되는 name의 값이 여러가지라면 getParameter 리턴값이 []인걸로 하기
		//키와 값을 합쳐 entry라고 부름 getParameter는 body가 없을땐 쿼리스트링에서 값을 가져옴
		System.out.println("======================BODY=================");

		Map<String, String[]> parameterMap = req.getParameterMap();
		for(Entry<String, String[]> entry : parameterMap.entrySet()) {//map안에 있는 entry를 집합으로 가져옴
			String name = entry.getKey();
			String[] values = entry.getValue();
			
			System.out.printf("%s:%s\n", name, Arrays.toString(values));// values의 배열값을 출력해야 되서 Arrays.toString을 이용함
		}
		
		
		String bodyEncoding = req.getCharacterEncoding();//body가 없으면 null
		int contentLength = req.getContentLength();
		String contentType = req.getContentType();
		String contentPath = req.getContextPath();
		String serverAddr = req.getLocalAddr(); // 현재 화면이 서버니까 서버 주소
		int serverPort = req.getLocalPort();
		String clientAddr = req.getRemoteAddr(); //클라이언트 주소
		int clientPort = req.getRemotePort();
		Locale local = req.getLocale();
		String queryString = req.getQueryString();
		
		System.out.printf("bodyEncoding : %s\n", bodyEncoding);
		System.out.printf("contentLength : %d\n", contentLength);
		System.out.printf("contentType : %s\n", contentType);
		System.out.printf("contentPath : %s\n",contentPath);
		System.out.printf("serverAddr : %s\n",serverAddr);
		System.out.printf("serverPort : %d\n", serverPort);
		System.out.printf("clientAddr : %s\n", clientAddr);
		System.out.printf(" clientPort : %d\n",  clientPort);
		System.out.printf("local : %s\n", local);
		System.out.printf("queryString: %s\n", queryString);
	}
	
}
