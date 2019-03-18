package kr.or.ddit.alba;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.management.RuntimeErrorException;
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
import sun.reflect.generics.tree.FieldTypeSignature;
@WebServlet(urlPatterns="/albaregist.do",loadOnStartup=1)
public class AlbaRegistControllerServlet extends HttpServlet {
//하나의 주소로 두가지 메서드를 처리할수 잇음 	
	//public static final String MAPATTR = "albaMap";
	AlbaDAOFromFileSystem albaDao = AlbaDAOFromFileSystem.getInstance();
	public static final String LICMAPATTR = "licMap";
	
	//폼으로 연결만 하기때문에 get으로 
	//loadOnStartup 요청이 들어오지 않더라도 얘가 먼저 호출
	@Override
	public void init() throws ServletException {
		super.init();
	//db를 대신할 Map을 미리 호출하기 위해서 , 순서대로 들어갈수 있게 linked
	  // Map<String, AlbaVO> albaMap = new LinkedHashMap<String, AlbaVO>();
	   Map<String, String> licMap = new LinkedHashMap<>();
	//application scope로	
		getServletContext().setAttribute(LICMAPATTR, licMap);
		//getServletContext().setAttribute(MAPATTR, albaMap);
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String view = "/WEB-INF/views/alba/albaForm.jsp";
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.forward(req, resp);
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
			//ex)alba_001 알바 아이디 자동 생성, 숫자3자리 패딩글자는 0
//			Map<String, AlbaVO> albaMap = (Map<String, AlbaVO>)getServletContext().getAttribute(MAPATTR);
//			
//			String id = String.format("alba_%03d",albaMap.size()+1);
//			albaVO.setId(id);
//			albaMap.put(albaVO.getId(), albaVO);
			albaDao.insertAlba(albaVO);
//			//등록이 되었다면 albaList.do(controller, view)로 이동 redirect방법 
			redirect= true;
			goPage="/albaList.do";
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

	// 500에러-서버, 400에러-클라이언트
	// 리플렉션 : 어떤 클래스가 있는지 모르고, 그 클래스의 프로퍼티를 모를때 프로퍼티를 추적하는 과정
	// 검증로직

	private void ref() {
		// 일부러 메서드에 넣어서 정리한거임, 실제로 사용한건 아님
		// 리플렉션 방법
		// for(Entry<String, String[]> entry : parameterMap.entrySet()) {
		// String paramName= entry.getKey();
		// String[] values = entry.getValue();
		// Class type= albaVO.getClass();
		//
		// try {//리플렉션은 추측하면서 하는거라 예외처리 해야될게 많아
		// //Field field = type.getField(paramName); 이건 private에 접근 못해
		// Field field = type.getDeclaredField(paramName);
		// Class fieldType = field.getType();//전역변수의 타입을 받아올수 있음
		//
		// String setterName = "set"+paramName.substring(0,1).toUpperCase();
		// Method method = type.getMethod("setName", fieldType);
		//
		// if(String.class.equals(fieldType)) {
		// if(values !=null && values.length>0) {
		// method.invoke(albaVO,values[0]);
		// //==albaVo.setName(name) 이런형식
		// }
		//
		// }else if(String[].class.equals(fieldType)) {
		// method.invoke(albaVO,values);
		//
		// }else if(Integer.class.equals(fieldType)) {
		//
		// if(values !=null && values.length>0) {
		// // parseInt하면 변수 타입이 int니까
		// method.invoke(albaVO,new Integer(values[0]));
		// }
		// }
		// } catch (NoSuchFieldException | SecurityException | NoSuchMethodException e)
		// {
		// e.printStackTrace();
		// } catch (NumberFormatException e) {
		// e.printStackTrace();
		// } catch (IllegalAccessException e) {
		// e.printStackTrace();
		// } catch (IllegalArgumentException e) {
		// e.printStackTrace();
		// } catch (InvocationTargetException e) {
		// e.printStackTrace();
		// }
		// }
	}

}
