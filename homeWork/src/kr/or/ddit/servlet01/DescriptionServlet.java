package kr.or.ddit.servlet01;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *Servlet Spec.
 * : 자바 기반의 웹어플리케이션을 구현하기 위한 API 모음. 
 *** 서블릿 개발 단계
 * 1. HttpServlet의 하위 클래스 후ㅕㄴ -> 필요한 콜백 메서드 재정의 
 * 2. 컴파일 -> /WEB-INF/Classes(컨텍스트의 classpath)에 위치
 * 3. Servlet Container에 등록
 * 	1) web.xml에 등록: servlet > servlet-name, servlet-class
 * 	2) @webServlet으로 등록(spec 3.0)등록
 * 4. 웹리퀘스트를 받을 수 있ㄷ록 요청과의 매핑 설정 
 *	1)web.xml에 매핑 servlet-mapping > servlet-name, url-pattern
 * 	2)@webServlet으로 등록(spec 3.0)
 * 	매핑 설정 방식
 * 		-경록 매핑 : /depth/* depth아래의 모든건 내가 받겠다.
 * 		-확장자 매핑 : *.do do로 끝나는건 모두 받겠다
 * 		- 둘을 합쳐서 할 수 없다.
 * 5. 서버 리스타트
 * 
 * ***3,4,5단계는 컨테이너와 관련
 * 
 * **서블릿 컨테이너 
 * 	:서블릿의 객체 생성과 소멸을 책임, 이 서블릿의 운영 역할도 톰캣이 책임
 * 	: 서블릿의 라이프사이클을 담당하며, 특정 요청에 대해 해당 서블릿을 운영하는 주체
 *	: 컨테이너는 등록된 서블릿에 관한 설정 정보를 immutable 객체인 servletconfig 객체로 생성하고 init의 메서드를 통해 서블릿으로 전달함
 * **컨테이너의 서블릿 관리 특성
 * 	1) singleton: 일반적으로 해당 서블릿의 인스턴스를 하나만 생성하는 구조
 *	(경우에 따라서는 비싱글톤, 하지만 거의 싱글톤으로만 사용)
 *	2) 특별한 설정(load-on-startup)이 없는한 매핑된 요청이 최초로 발생하면 객체 설정
 * ** 서블릿의 콜백 메서드 종류
 * 	- 콜백의 주체는 컨테이너 
 * 	- 서블릿의 라이프 사이클을 관리하는 콜백(생명주기 콜백)
 * 	 1) init(생성) 싱글톤이라 서버 온할때 한번 
 * 	 2) destroy(소멸) 0번이상 
 * 	
 * 	-요청 처리 콜백 n번 이상 호출
 * 	1) service
 * 	2) doxxx
 * 
 * 
 * 
 */

/*
웹 어플리케이션 컨텍스트에 대한 설정 
1. 서블릿을 등록
2. 필터등록
3.리스너등록
4.세션설정
5. jsp페이지에 대한 설정 
*/

//@WebServlet("/desc")어노테이션에 값을 하나만 넣었을때 싱글밸류어노테이션
//하나의 서블릿에 여러개의 주소를 부여 가능, 가상 주소이기때문에 여러개로 가능 
@WebServlet(loadOnStartup=1,urlPatterns="/desc",initParams={@WebInitParam(name="param1", value="파라미터값")})
//멀티밸류어노테이션
public class DescriptionServlet extends HttpServlet{

	public DescriptionServlet() {
		System.out.println(getClass().getSimpleName()+" : 인스턴스 생성");
	}
	
	//컨테이너가 매핑을 읽고 -> 그 정보를 읽어서 컨피그 객체를 생성 , 등록도 한번 매핑도 한번이니까 각 서블릿은 객체를 하나씩 가지고 있어 
	//immutable 객체 > 불러오기만 하고 수정은 안되는 객체
	@Override//객체가 생성할때실행, 
		public void init(ServletConfig config) throws ServletException {
			super.init(config);
			System.out.println(getClass().getSimpleName()+" : 초기화");
			String value = config.getInitParameter("param1");
			System.out.println("전달된 파라미터 : " + value);
		}
	
	//init과 destroy 사이의 녀석들은 요청과 관련된 것들 
	
	
	//HttpServletRequest 매개변수 타입은 http사용 할때, 
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("요청 접수");
		super.service(req, resp); //doGet을 호출해주는 역할****중요한 역할, get을 부를지, post를 부를지 아니면 다른 메서드를 부를지 결정하는 곳
		System.out.println("요청 처리 완료");
	}
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet메서드 내에서 요청 처리");
	}
	
	
	
	@Override
	public void destroy() {//실행이 될수도 있고, 안될수도 있어, 서버가 죽기전에 가비지 컬렉션이 되었다면 호출, 서버가 죽고난후 가비지 컬렉션이 되었다면 호출되지 않음 
		super.destroy();
		System.out.println(getClass().getSimpleName()+" : 객체 소멸");
	}
	
	
	
}
