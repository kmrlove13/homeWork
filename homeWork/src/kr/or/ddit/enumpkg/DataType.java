package kr.or.ddit.enumpkg;

public enum DataType {
	HTML("text/html;charset=UTF-8"),PLAIN("text/plain;charset=UTF-8"),JSON("application/json;charset=UTF-8"), OTHER("지원하지 않는 타입입니다.");

	private String text ;
	
	private DataType(String text) {
		this.text = text;
	}
	public String getText() {
		return text;
	}

	public static DataType dataMatch(String accept) {
		DataType[] types = values();//dataType enum 상수들을 types 배열에 초기화
		DataType res = OTHER; //기본값
		accept = accept.toUpperCase(); //상수들이 모두 대문자 이기에 받아온 매개값을 대문자로 변환
		
		for(DataType tmp: types) {//types배열에 있는 값들을 매개값과 비교
			if(accept.contains(tmp.name())) {//매개값과 상관있는  dataType 상수를 결과에 초기화
				res=tmp;
				break;
			}
		}
		return res;
	}
	
}
