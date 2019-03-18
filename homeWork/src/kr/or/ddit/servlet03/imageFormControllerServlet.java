package kr.or.ddit.servlet03;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.utils.CookieUtil;

/**
 * Model2 구조상에서 
 * 요청을 받고,
 * 분석을 하고,
 * 컨텐츠를 생성하고,
 * 뷰레이어를 선택하고,
 * 컨텐츠를 공유하고.
 * 해당 뷰로 이동하는 역할만을 담당할 컨트롤러
 * 
 *
 */

@WebServlet("/model2/imageForm.do")
public class imageFormControllerServlet extends HttpServlet {
	//요청을 받고 d드라이브 파일을 확보
	//뷰쪽으로 전달, 
	//어떤 뷰를 쓰겠다 정하고 
	//어떤 뷰로 이동 -web_inf안의 jsp로 이동하니까 서버사이드 방식의 dispacth이동
	//이동할때 데이터도 가져가야 하는데, 최초 요청도 같이 이동하니까 최소한의 데이터 이동 방식을 사용하니까 
	//request scope사용 
	//모델2에서 요청만 분석
	File sampleFolder;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		//클래스패스 기준, .으로 구분, 확장자는 생략
		ResourceBundle bundle =ResourceBundle.getBundle("kr.or.ddit.servlet01.sample");
		String folderPath= bundle.getString("sampleFolder");//d드라이브의 폴더의 경로를 가져왔음
		sampleFolder=new File(folderPath);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		File[] imageFiles = sampleFolder.listFiles((dir,name)->{
			//어플리케이션 기본 객체, 스트링타입의 마임이 반환
			String mime = getServletContext().getMimeType(name);
			return mime!=null&&mime.startsWith("image/");
		});
	
//		Cookie[] cookies = req.getCookies();
//		if (cookies != null) {
//			for (Cookie tmp : cookies) {
//				if (tmp.getName().equals("img")) {
//					String imgName =URLDecoder.decode(tmp.getValue(),"UTF-8");
//					req.setAttribute("imgName", imgName);
//				}
//			}
//		}
		
		//cookie value를 설정하기
		CookieUtil cookieUtil = new CookieUtil(req);
		String imgName = cookieUtil.getCookieValue("imgCookie");
		req.setAttribute("imgName", imgName);
		
		req.setAttribute("imageFiles", imageFiles);
		String view="/WEB-INF/views/imageFormView.jsp";
		RequestDispatcher rd= req.getRequestDispatcher(view);
		rd.include(req, resp);
	}
	
	
	
	
	
}
