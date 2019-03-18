package kr.or.ddit.servlet01;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class GugudanServlet
 */
@WebServlet(urlPatterns = { "/gugudan.do" }, initParams = { @WebInitParam(name = "param1", value = "값1") })
public class GugudanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GugudanServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.service(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response) do메서드를 부르는건 service, service를 잘못 부르면 do를 사용 못함 형태가 바뀔 필요가 없는
	 *      녀석들은 템플릿으로 이용
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// head로 "구구단" 이라는 타이틀 출력
		// 2단부터 9단까지의 구구단을 table캐그를 이용해서 출력
		String minDanStr = request.getParameter("minDan");//html에서 int로 입력했어도 문자열로 넘어옴
		String maxDanStr = request.getParameter("maxDan");//html에서 int로 입력했어도 문자열로 넘어옴
		
		int minDan = 0; 
		int maxDan = 0;
		//정규식으로 2-9까지만 밖을수 있도록, 널값 체크 조건
		if(minDanStr!=null && minDanStr.matches("[2-9]") && maxDanStr!=null && maxDanStr.matches("[2-9]")) {
			minDan = Integer.parseInt(minDanStr);
			maxDan = Integer.parseInt(maxDanStr);
			
		}
		response.setContentType("text/html; charset=UTF-8");
		
		//현 클래스의 gugudan.tmpl의  파일 주소
		String absolutePath  = getClass().getResource("gugudan.tmpl").getFile();
		File tmplFile = new File(absolutePath);
		FileInputStream fis = new FileInputStream(tmplFile);//데이터를 1바이트씩 읽는다
		//byte, 문자 형식 모두 사용
		InputStreamReader isr = new InputStreamReader(fis,"UTF-8");//내가 어떤 인코딩을 했는지를 작성
		
		
		BufferedReader reader = new BufferedReader(isr);
		//널값이 나오기전까지 읽어야해
		
		
		StringBuffer template = new StringBuffer();
		String temp = null;
		while((temp=reader.readLine())!=null) {
			template.append(temp+"\n");
		}
		
		StringBuffer data = new StringBuffer();
		String pattern = "<td>%d*%d=%d</td>";
		for (int i=minDan; i <=maxDan; i++) {
			data.append("<tr>");
			for (int j = 1; j < 10; j++) {
				data.append(String.format(pattern, i, j, (i * j)));
			}                           
			data.append("</tr>");
		}
		//영대소문자, 숫자 모두 사용 @\\W+@
		//파싱하는 부분(@@)만 잘 설정하면 동적인 화면도 처리 가능
		String html = template.toString().replaceAll("@data@", data.toString());
		html = html.replaceAll("@color@", "red");
		try (PrintWriter writer = response.getWriter();) {
			writer.print(html);
		}
	}

}
