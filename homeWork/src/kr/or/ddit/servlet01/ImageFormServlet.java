package kr.or.ddit.servlet01;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.xml.ws.Response;

import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

@WebServlet()
public class ImageFormServlet extends HttpServlet {
	File SampleFolder;// 전역으로 사용

	// d드라이브의 sample폴더 대상으로 `
	// 샘플 폴더 중 jpg 파일만 가져오기 , 확장자로 확인해서 가져오기
	// 가져온 이미지파일 목록화
	// 컬렉션을 대상으로 반복문
	// 이미지 하나하나 대상으로 해서 클라이언트가
	// 폼, select태그, for문안에서 옵션을 구성
	// 이미지를 선택하면 전송이벤트 할수 있도록 버튼 생성
	// 응답데이터를 내보내고 전송버튼의 방향을 결정- form의 action
	// 또다른 서블릿에서 어떤 이미지를 선택했는지 찾고
	// d드라이브에서 이미지를 찾아서 응답데이터 생성
	// 이미지를 선택할수 있는 ui를 보내줌

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		SampleFolder = new File(config.getInitParameter("contentPath"));
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");

		// 템플릿
		String tmp = readTemplet("image.tmpl");
		// 어플리케이션의 기본 객체는 싱글톤이라는걸 확인하기 위한 코드
		// System.out.println(getServletContext().hashCode());

		// jpg 파일만 가져오기
		File[] fileName = SampleFolder.listFiles((dir, name) -> {
			String mimeText = getServletContext().getMimeType(name);
			return mimeText.startsWith("image/");
		});

		StringBuffer buff = new StringBuffer();
		String pat = "<option value='%1$s'>%1$s</option>";

		// 파일이 없을수도 있어
		if (fileName != null) {
			for (File temp : fileName) {
				buff.append(String.format(pat, temp.getName()));
			} // for end
		} // if end

		String html = tmp.replaceAll("@data@", buff.toString());

		try (PrintWriter writer = resp.getWriter();

		) {
			writer.print(html);
		}
	}// doPost end

	// 템플릿메서드
	public String readTemplet(String tmpl) throws IOException {
		// readTemplet을 부른 폼에서는 IOException을 처리하니까 여기서는 넘어가자
		File tmpFile = new File(getClass().getResource(tmpl).getFile());
		StringBuffer template = null;

		try (FileInputStream fis = new FileInputStream(tmpFile);
				InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
				BufferedReader reader = new BufferedReader(isr);) {
			template = new StringBuffer();
			String temp = null;

			while ((temp = reader.readLine()) != null) {
				template.append(temp + "\n");
			}
			return template.toString();
		}

	}

}