package kr.or.ddit.alba;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;

import kr.or.ddit.alba.dao.AlbaDAOFromFileSystem;
import kr.or.ddit.vo.AlbaVO;

@WebServlet("/albaUpdate.do")
public class AlbaUpdateControllServlet extends HttpServlet {
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
			//수정할려면 전에 작성했던것도 가져가야지 
			req.setAttribute("alba", alba);
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/alba/albaForm.jsp");
			rd.forward(req, resp);
		
		}else {//해당회원이 존재하지 않음
			statusCode = HttpServletResponse.SC_NOT_FOUND;
		}
		
		if(statusCode!=0) {//상태코드 있는경우 에러 있는경우
			resp.sendError(statusCode);
			return;
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//검증 성공
		//파라미터 name을 모를땐 Map으로, key가 name
		req.setCharacterEncoding("UTF-8");
		
		Map<String, String[]> parameterMap = req.getParameterMap();
		
		AlbaVO albaVO = new AlbaVO();
		//검증에 통과 못하면 얘를 가져가고 아니면 자동으로 삭제 
		req.setAttribute("albaVO", albaVO);
		
		try {
			//밑의 for문을 안써도되, populate가 해줨, BeanUtils.역할
			BeanUtils.populate(albaVO, parameterMap);
			
		} catch (IllegalAccessException | InvocationTargetException e) {
			//IllegalAccessException - setter가 public이 아니라면 발생
			//InvocationTargetExceptio - 값을 넣을려면 setter가 없을때 
			throw new RuntimeException(e); //트라이캐치 안해도되는 언체크익셉션, 예외가 발생하면 밑으로 가지 않음 return안해도됨
		}

		//검증 
		
		Map<String, String> errors=new HashMap<String, String>() ;
		req.setAttribute("errors", errors);
		boolean valid = validate(albaVO, errors);
		//메소드를 호출하고 넘기면 메소드 내부에서 객체의 상태를 검사
		String goPage = null;
		boolean redirect = false;
		
		//플래그 변수가 true면 성공, false면 실패
		//value of object ==vo, 일일이 하나하나 검증하기 어려우니까 한꺼번에 할수 있는것을 찾았고, 그 방법이 모듈화 인데, 그 모듈화를 효과적으로 하기 위해서 
		
		//검증 성공
		if(valid) {
			//db를 대신해 map을 작성해야함
			//수정
			//Map<String, AlbaVO> albaMap = (Map<String, AlbaVO>)getServletContext().getAttribute(AlbaRegistControllerServlet.MAPATTR);
			albaDao.updateAlba(albaVO);
			
			//등록이 되었다면 albaList.do(controller, view)로 이동 redirect방법 
			redirect= true;
			goPage="/albaView.do?who="+albaVO.getId();
		}else {//검증 실패
			//응답데이터는 응답상태코드를 활용할 수 있음
			//404, 500..응답이 실패했다는 정보를 제공
			//검증이 실패했을때, 
			//다시 알바폼으로 WEB-INF/views/alba/albaForm.jsp forword
			//남은 vo, error를 꺼내야함 , 상태도 복원하고 
			//메세지 처리도 필요함, 왜때문에 통과하지 못했는가
			
			goPage="/WEB-INF/views/alba/albaForm.jsp";
			//resp.sendError(HttpServletResponse.SC_BAD_REQUEST,errors.toString());
		}
		
		if(redirect) {
			//redirect는 get방식밖에 안됨
			resp.sendRedirect(req.getContextPath()+goPage);
		}else {
			RequestDispatcher rd = req.getRequestDispatcher(goPage);
			rd.forward(req, resp);
		}
	
	}
	
	// 검증
	private boolean validate(AlbaVO albaVO, Map<String, String> errors){
		boolean valid = true;
		//검증
		//if(albaVO.getName()==null ||albaVO.getName().trim().length()==0) {
		//의미없이 띄어쓰기 했을수도 있으니까 trim
		
		//이 if문을 축약하자 하는게 lang이라는 lib, 자바의 기본클래스(lang)에 몇가지 기능을 더 넣은것들. 
		//대소문자 구별
		//검증 라이브러리
		//검증에 대상이 객체의 프로퍼티 
		if(StringUtils.isBlank(albaVO.getName())) {//널값 확인, 널값이 아니라면 trim을 시켜서 length를 확인
			valid = false;
			errors.put("name", "이름누락"); //에러가 어떤것때문에 생긴건지
		}else if(StringUtils.isBlank(albaVO.getName())) {//널값 확인, 널값이 아니라면 trim을 시켜서 length를 확인
			valid = false;
			errors.put("address", "주소누락"); //에러가 어떤것때문에 생긴건지
		}
		return valid;
	}	

	
}
