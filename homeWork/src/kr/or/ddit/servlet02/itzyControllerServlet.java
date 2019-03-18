package kr.or.ddit.servlet02;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import kr.or.ddit.vo.itzyVO;

@WebServlet("/05/getMemberPage.do")
public class itzyControllerServlet extends HttpServlet {
//아이돌 폼에서 메소드 방식이 get이기 때문에 doget으로 생성 
//요청만 분석하니까 servlet으로 작성

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//여기에 세션이 없으니까 
		HttpSession session = req.getSession();
		//Map<String, itzyVO> itzyMap = (Map)session.getAttribute("itzyMap");
		Map<String, itzyVO> itzyMap = (Map<String, itzyVO>)getServletContext().getAttribute("itzyMap");
		
		/*
		 * 굳이 jsp로 할 필요 없지 이쪽은 서블릿으로 파라미터를 가져오기, 검증, 각 멤버의 모든 정보가 포함된 페이지를 출력하기 여기서는 요청을
		 * 받고 확인하기 까지만, 멤버의 정보를 확인하는 페이지는 별도로 왜냐하면 여기다가 한꺼번에 하면 가독성이 떨어짐
		 */
		// 파라미터 가져오기
		String memCode = req.getParameter("itzy");
		int statusCode = 0;
		// 검증
		// form에 있는 맵을 가져오게
		// 어떻게 하면 다른 jsp에 있	는 맵을 가져올수 잇을까
//		Map<String, itzyVO> itzyMap = new LinkedHashMap<>();// 지네릭스 뒤에는 생략 가능함 1.7부터, jdk는 1.8이지만, 톰캣이 컴파일하는데 톰캣의 자바
//		itzyMap.put("yezi", new itzyVO("예지", "/itzy/yezi.jsp"));
//		itzyMap.put("ria", new itzyVO("리아", "/itzy/ria.jsp"));
//		itzyMap.put("ryuzin", new itzyVO("류진", "/itzy/ryuzin.jsp"));
//		itzyMap.put("cheryung", new itzyVO("채령", "/itzy/cheryung.jsp"));
//		itzyMap.put("yuna", new itzyVO("유나", "/itzy/yuna.jsp"));

		if (StringUtils.isBlank(memCode)) {// 필수파라미터 누락이 되었다면 상태코드를 sc_bad_request
			statusCode = HttpServletResponse.SC_BAD_REQUEST;
		} else {// 필수파라미터 목록에 있는것 그대로 가져왔는지
			if (!itzyMap.containsKey(memCode)) {
				statusCode = HttpServletResponse.SC_NOT_FOUND;
			}
		}	

		if (statusCode == 0) {// 누락도 안되고 목록에도 있다면
			// client는 web-inf에 접근할수 없음, 이거 사용할려면 dispatch이용해야해
			String goPage = "/WEB-INF/" + itzyMap.get(memCode).getPage();
			// String goPage= itzyMap.get(param).getPage();

			/* 매개변수를 계속 사용할때 */
			RequestDispatcher rd = req.getRequestDispatcher(goPage);
			rd.include(req, resp);

			// 이제 매개변수 계속 사용할 필요가 없으니
			// response.sendRedirect(request.getContextPath()+goPage);

			return;// 해도 되고 안해도 되고 forword는 다시 안돌아옴
		} else {
			resp.sendError(statusCode);
		}

		/*
		 * //enum을 사용하는 경우 String upperParam = param.toUpperCase();
		 * if(!StringUtils.isBlank(param)){ for(itzyUrl list	: itzyUrl.values()){
		 * if(upperParam.equals(list.name())){ RequestDispatcher rd =
		 * request.getRequestDispatcher(list.getUrl()); rd.forward(request, response);
		 * }else{ response.sendError(HttpServletResponse.SC_BAD_REQUEST,"해당 멤버가 없습니다.");
		 * } } }else{
		 * response.sendError(HttpServletResponse.SC_BAD_REQUEST,"제대로 입력해주세요."); }
		 * 
		 */

	}

}
