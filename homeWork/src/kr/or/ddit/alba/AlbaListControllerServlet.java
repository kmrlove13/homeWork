package kr.or.ddit.alba;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.alba.dao.AlbaDAOFromFileSystem;
import kr.or.ddit.vo.AlbaVO;
@WebServlet("/albaList.do")
public class AlbaListControllerServlet extends HttpServlet {
	AlbaDAOFromFileSystem albaDao = AlbaDAOFromFileSystem.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//맵을 꺼내야함
		//Map<String, AlbaVO> albaMap=(Map<String, AlbaVO>)getServletContext().getAttribute(AlbaRegistControllerServlet.MAPATTR);
		
		//모든 알바생의 Map이 필요함 
		//대부분의 스코프는 리퀘스트 이용함 
		//뷰레이더에서 어느 영역안에 들어있는지 신경쓰지 말라는 뜻에서 리퀘스트에 새로 담자
		Map<String, AlbaVO> albaMap= albaDao.selectAlbaList();
		req.setAttribute("albaMap", albaMap);
		
		String view = "/WEB-INF/views/alba/albaList.jsp";
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.forward(req, resp);
		
	}
	
}
