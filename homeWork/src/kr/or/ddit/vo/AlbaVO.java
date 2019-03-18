package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.Map;


/**
 * JavaBean 규약
 * 	- 자바빈 규약에 따라 정의된 재사용 가능한 자바 객체
 *  1) 값을 저장할 프로퍼티 정의(흔히 말하는 전역변수)
 *  2) 프로퍼티를 캡슐화
 *  - 캡슐화의 2가지 정의: 데이터 자체에대한 캡슐화, 로직에 대한 캡슐화 
 *  - 캡슐화 이유 : 프로퍼티를 보호 하기 위해 
 *  3) 캡슐화된 프로퍼티에 접근할 인터페이스를 정의 
 *  	getter/setter : get[set]변수명(첫문자대문자, 카멜표기법)  
 * 	4) 객체의 상태를 비교할 수 있는 방법 제공.(기본키를 비교할 방법을 재정의)
 *  - 참조를 비교할땐 equal, 상태(프로퍼티 값)를 비교할땐 equals
 *  5) 객체의 상태를 확인할 수 있는 방법 제공 
 *  - toString
 *  6) 직렬화 
 *  - 매체에 기록하거나 전송할 목적으로 데이터를 직렬화 한다. 
 * 
 * 
 * 
 *
 */


public class AlbaVO implements Serializable {
	//int대신 integer사용하는 이유, 객체를 이용하기 위해, null값을 사용하기 위해
	//원칙적으로 프레임웍의 기본단위는 오브젝트 
	//기본형을 사용하지 않음 원칙적으로.
	//캡슐화를 해서 일정한 규칙으로 값이 변경될 수 있도록 제한을 걸수 있게 private
	private String id; //폼에서 사용하는건 아니지만 db에서 기본키로 사용할것을 정의
	private String name;
	private Integer age ;
	private String addr ;
	private String hp;
	private String mail;
	private String gen;
	private String btype;
	private String grade;
	private String[] lic;//자격증
	private String career;
	private String spec;
	private String desc;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
		
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getGen() {
		return gen;
	}
	public void setGen(String gen) {
		this.gen = gen;
	}
	public String getBtype() {
		return btype;
	}
	public void setBtype(String btype) {
		this.btype = btype;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public String[] getLic() {
		return lic;
	}
	public void setLic(String[] lic) {
		this.lic = lic;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	@Override
	public String toString() {
		return "AlbaVO [id=" + id + ", name=" + name + ", age=" + age + ", addr=" + addr + ", hp=" + hp + ", mail="
				+ mail + ", gen=" + gen + ", btype=" + btype + ", grade=" + grade + ", lic=" + lic + ", career="
				+ career + ", spec=" + spec + ", desc=" + desc + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	//이게없으면 비교 불가
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AlbaVO other = (AlbaVO) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	
	
	
	
}
