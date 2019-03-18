package kr.or.ddit.enumpkg;

public  enum OsType {
	WINDOW("윈도우계열"), MAC("맥계열"), ANDROID("안드로이드 계열"), OTHER("그 외 계열");
	
	//OsType이 상수들의 타입이 됨
	//자체적으로 상수들의 이름과 값들이 제공됨
	
	OsType(String text) {
		this.text= text;
	}
	
	private String text;
	
	public String getText() {
		return text;
	}
	
	public static OsType matchedType(String userAgent) {
		OsType[] types = values();
		OsType res = OTHER;
		userAgent = userAgent.toUpperCase();
		
		for(OsType tmp : types) {
			if(userAgent.contains(tmp.name())) {
				res = tmp;
				break;
			}
		}
		return res;
	}
	
}
