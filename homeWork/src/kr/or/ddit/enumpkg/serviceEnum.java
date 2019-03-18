package kr.or.ddit.enumpkg;

public enum serviceEnum {
	GUGUDAN("/02/gugudan.jsp"),
	IDOLFORM("/05/idolForm.jsp"),
	CALENDAR("/04/calendar.jsp"),
	SESSIONTIMER("/06/sessionTimer.jsp"),
	IMAGEFORM("/model2/imageForm.do"),
	GETMEMBERPAGE("/05/getMemberPage.do");
	
	String url;
	
	private serviceEnum (String url) {
		this.url=url;
	}
	
	public String getUrl() {
		return url;
	}
}
