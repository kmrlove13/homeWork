package kr.or.ddit.servlet01;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ResourceBundle;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.eclipse.jdt.internal.compiler.ast.ThrowStatement;

import kr.or.ddit.utils.CookieUtil;
import kr.or.ddit.utils.CookieUtil.TextType;

@WebServlet("/image.do")
public class ImageProviderServlet extends HttpServlet {
	File sampFolder;
	
	// 파라미터 확보 selImg , select의 name을 확인
	// 검증 클라이언트가 보낸 값을 믿지말것! 데이터 검증 꼭!
	// 이미지의 존재 여부 확인
	// 마임테스트 jpg
	// 폴더를 객체화 시켜서

	@Override //서블릿의 객체가 생성된 직후 실행
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		//*************************중요
		//프로퍼티스 파일은 늘 클래스패스 안에 생성(설정의 외부화) 
		//baseName은 클래스패스 형식으로 경로를 설정
		//ResourceBundle 자원의 묶음 , 여러개의 프로퍼티스를 읽음 
		//다른 번들이랑 다른 이유는 
		//프로퍼티스 파일은 객체를 외부에서도 저장 가능함, 동시에 객체이면서 파일, 확장자를 뺀 나머지를 기술
		ResourceBundle bundle = ResourceBundle.getBundle("kr.or.ddit.servlet01.sample");
		
		String folderPath = bundle.getString("sampleFolder");
		sampFolder = new File(folderPath);
		
		//프로퍼티 자료를 꺼내고 
		//그 중 하나를 꺼내서 초기화 
	
	}
	
	
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 파라미터 받아오기
		String img = req.getParameter("selImg");
		String imgNm = "6.jpg";//일치하지 않으면 기본값

		//널값체크
		if(StringUtils.isBlank(img)) {
			//잘못은 클라이언트에게 있으니까 
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST,"이미지를 선택하시오");
			return;
		}

		//이미지 존재 여부
		File imageFile = new File(sampFolder, img);
		
		if(!imageFile.exists()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND,"이미지가 없습니다.");
			return;
		}
		
		//이미지가 존재하면 img를 쿠키에 저장
//		Cookie imgCookie = new Cookie("img", URLEncoder.encode(img,"UTF-8"));
//		imgCookie.setMaxAge(60*60*24*3);//3일을 살려놓는다.
//		imgCookie.setPath(req.getContextPath());//이미지를 생성할때와 출력할때가 다르니까 패스 설정
		//클라이언트는 1차적으로 서블릿으로 갔다가 jsp로 가니까 
		
		Cookie imgCookie  =CookieUtil.createCookie("imgCookie", img, req.getContextPath(), TextType.PATH, 60*60*24*7);
		resp.addCookie(imgCookie);
		
		
		// 받아온 파라미터 검증
		//드라이브의 파일 이름과 일치하는지 확인
		String mimeText = getServletContext().getMimeType(img);
		resp.setContentType(mimeText);
		byte[] buffer = new byte[1024];
		int length = -1;//파일 전송이 다끝났다는 eof 문자
		
		try (FileInputStream fis = new FileInputStream(imageFile); 
				OutputStream os = resp.getOutputStream();
			) {
			while ((length = fis.read(buffer)) != -1) {
				os.write(buffer, 0, length);//나머지가 있는 경우
			}
		}
	}
}
