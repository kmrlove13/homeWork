package kr.or.ddit.servlet03;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import kr.or.ddit.enumpkg.serviceEnum;

@WebServlet("/index.do")
public class IndexControllerServlet extends HttpServlet {

	/* 
	 * 요청을 받고,분석하고 검증하고 뷰를 선택하고, 뷰로 이동하는 
	 * 
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String pageParam = req.getParameter("includePage");
		String includePage=null;
		
		//0이면서 값이 없는경우 
		//0이면서 값이 있는겨웅 
		//404인 케이스
		int statusCode = 0;
		if(StringUtils.isNotBlank(pageParam)){
			try{
				serviceEnum senum = serviceEnum.valueOf(pageParam.toUpperCase());
				includePage = senum.getUrl();
			}catch(IllegalArgumentException e){
				statusCode = HttpServletResponse.SC_NOT_FOUND;
			}
		}
		
		if(statusCode!=0){//상태코드에 값이 있는 경우==에러코드
			resp.sendError(statusCode);
			return;
			
		}
		//값을 넘기기 
		req.setAttribute("includePage",includePage);
		String view = "/WEB-INF/views/index.jsp";
		RequestDispatcher rd= req.getRequestDispatcher(view);
		rd.forward(req, resp);
		
	}

}
