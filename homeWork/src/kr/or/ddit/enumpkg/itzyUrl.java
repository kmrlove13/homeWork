package kr.or.ddit.enumpkg;

public enum itzyUrl {
	//itzyVO 이용하기!
	YEZI("/itzy/yezi.jsp"),
	RIA("/itzy/ria.jsp"),
	RYUZIN("/itzy/ryuzin.jsp"),
	CHERYUNG("/itzy/cheryung.jsp"),
	YUNA("/itzy/yuna.jsp");
	
	private String url;
	
	private itzyUrl(String url) {
		this.url=url;
	}
	
	public String getUrl() {
		return url;
	}
	
	
}
