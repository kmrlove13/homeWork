package kr.or.ddit.alba;

import java.io.IOException;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import kr.or.ddit.alba.dao.AlbaDAOFromFileSystem;
import kr.or.ddit.vo.AlbaVO;

@WebServlet("/albaView.do")
public class AlbaViewController extends HttpServlet {
	AlbaDAOFromFileSystem albaDao = AlbaDAOFromFileSystem.getInstance();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//잘못된 파라미터 400, 
		//application map을 가져오고 
		//map리스트에서 아이디를 가지고 회원을 찾고 , 회원이 없으면 404
		//파라미터 없고, 파라미터있으며 회원이 없을때, 파라미터있고 회원도 있고 
		//해당 회원 있으면 /webStudy01/WebContent/WEB-INF/views/alba/albaView.jsp
		
		//list id파람 가지고 오고 
		String param = req.getParameter("who");
		//총 회원들 정보를 가져오고 
		//Map<String, AlbaVO> albaMap=(Map<String, AlbaVO>)getServletContext().getAttribute(AlbaRegistControllerServlet.MAPATTR);
		//상태코드 받을 변수 
		int statusCode = 0;
		if(StringUtils.isBlank(param)) {
			statusCode= HttpServletResponse.SC_BAD_REQUEST;
		}
		
		//총회원들하고 id를 비교
		
		AlbaVO alba = albaDao.selectAlba(param);
		
		//해당 회원이 존재	
		if(alba!=null) {
			req.setAttribute("alba", alba);
			
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/alba/albaView.jsp");
			rd.forward(req, resp);
		
		}else {//해당회원이 존재하지 않음
			statusCode = HttpServletResponse.SC_NOT_FOUND;
		}
		
		if(statusCode!=0) {//상태코드 있는경우 에러 있는경우
			resp.sendError(statusCode);
			return;
		}
		
	}
	
	
	
}
