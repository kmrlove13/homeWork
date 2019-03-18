package kr.or.ddit.vo;

import java.io.Serializable;

public class itzyVO implements Serializable {
	//직렬화 대상에서 제외하는 키워드 transient
	private String name;
	private transient String page;
	
	//페이지가 없는 상태에서 객체를 생성해야 하는데
	//밑의 생성자는 페이지도 직렬화 대상이니까 오류가 남 , 그래서 기본 생성자도 꼭 
	//어떤일이 있어도 역직렬화 할때는 기본 생성자만 사용
	public itzyVO() {
		super();
	}
	
	public itzyVO(String name, String page) {
		super();
		this.name = name;
		this.page = page;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((page == null) ? 0 : page.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		itzyVO other = (itzyVO) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (page == null) {
			if (other.page != null)
				return false;
		} else if (!page.equals(other.page))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "itzyVO [name=" + name + ", page=" + page + "]";
	}
	
	
	
}
