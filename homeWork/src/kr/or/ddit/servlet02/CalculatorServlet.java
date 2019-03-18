package kr.or.ddit.servlet02;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.html.HTMLDocument.HTMLReader.ParagraphAction;
import javax.xml.ws.Response;

import org.apache.commons.lang.StringUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.enumpkg.OperatorType;
@WebServlet("/calculator.do")
public class CalculatorServlet extends HttpServlet {
	
	@FunctionalInterface
	public static interface MakeResult{
		public String makeResult(double result) ;
	}
	
	public static enum CalculateType{
		
		PLAIN("text/plain;charset=UTF-8",(result)->{return result+"";}), 
		JSON("application/json;charset=UTF-8",(result)->{
			Map<String, Object> resulMap = new HashMap<String, Object>();
			resulMap.put("result",result);
			//마샬링 
			ObjectMapper mapper = new ObjectMapper();
			//직렬화도 같이 하기 위해 writevalue..이 메서드 사용
			try {
				return mapper.writeValueAsString(resulMap);
			} catch (JsonProcessingException e) { // return 대신에 예외 생성
				throw new RuntimeException(e);// 원본 예외를 사라지지 않게 e를 매개로 
			}
			
			//마샬링하는 과정에서 직렬화가 안된  객체이면 JsonProcessingException 얘가 생김
			
			}), 
		
		HTML("text/html;charset=UTF-8",(result)->{return "<span>"+result+"</span>";}),
		XML("application/xml;charset=UTF-8", (result)->{return "<result>"+result+"</result>";});
		
		private String mimeText;
		private MakeResult realMaker;
		
		
		//text의 값을 구성할수있는 요소는 생성자 
		private CalculateType(String mimeText, MakeResult realMaker) {
			this.mimeText=mimeText;
			this.realMaker= realMaker;
			
		}
		
		//context타입을 어떤 식으로 내보낼것인가
		public String getResult(double leftOp, double rightOp, OperatorType realOp) {
			//고정값을 줄수없고 행동의 값을 주자
			//operator : 사칙연산 if문을 돌리거나, enum, functionalInterface를 이용 
			double result =realOp.operate(leftOp, rightOp);
			
			return realMaker.makeResult(result);
		}
		
		public String getMimeText() {
			
			return mimeText;
		}

		//외부에서 객체를 생성할 수 없기에 static
		public static CalculateType matches(String accept) {
			CalculateType matchedType = HTML;
			CalculateType[] types = values();
			accept = accept.toUpperCase();
			
			for(CalculateType tmp: types) {
				if(accept.contains(tmp.name())) {
					matchedType = tmp;
					break;
				}
			}
			return matchedType;
		}
	}
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String content = null;
		
		//파라미터 확보 
		String operator = req.getParameter("operator");
		OperatorType opType	=null;	
		//플래그변수
		boolean valid = true;
		//플래그변수 없다면 try가 복잡해져
		
		//유효한값이 돌아오면 검증 완료, 유효하지 못한 값이 돌아오면 검증 실패
		//없다면 예외 발생, 있으면 상수 리턴
		
		try {
			 opType = OperatorType.valueOf(operator);
		}catch (IllegalArgumentException e) {
			valid= false;
		}
		String leftOp = req.getParameter("leftOp");
		String rightOp = req.getParameter("rightOp");
		
		double left = 1;
		double right= 2;
		//검증 필수파라미터 전송 여부, 데이터 타입
		//불통과 =sendError.400 
		if(StringUtils.isBlank(rightOp)||!StringUtils.isNumeric(rightOp)||StringUtils.isBlank(leftOp)||!StringUtils.isNumeric(leftOp)) {
			//resp.sendError(400,"제대로 입력해주세요");
			content="제대로 입력해주세요";
			
		}else {
		
			//통과 = 연산하고 결과 생성(html)
			left = Double.parseDouble(leftOp);
			right= Double.parseDouble(rightOp);
			
//			//double res = left+right;
//			
//			//ajax데이터 타입에 따라 변경해줘야됨 
//			//마임 ajax데이터 타입을 불러와서 타입을 설정
			String accept =req.getHeader("Accept");
			CalculateType type= CalculateType.matches(accept);
			String mime = type.getMimeText();
			
			content = type.getResult(left, right, opType);
		
		
		resp.setContentType(mime);
		
		try(
			PrintWriter writer = resp.getWriter();	
		){
			writer.print(content);
		}
		
		}
	
	}
}
