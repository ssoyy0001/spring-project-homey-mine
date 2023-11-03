package org.homey.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//한 페이지에 출력할 게시물의 수, 현재 페이지 번호, 검색 타입, 검색 키워드 저장 및 전달
@Getter
@Setter
@ToString
public class SoCriteria {

	private int amount;		//한 페이지에 게시물을 몇 개씩 표시할 건지
	private int pageNum;	//현재 페이지 번호
	private String type;		//검색옵션
	private String keyword;	//검색어
	
	//값을 지정하지 않은 경우, 한 페이지에 게시물 8개 표시하고 페이지 번호는 1로 지정
	public SoCriteria() {
		//this.pageNum = 1;
		//this.amount = 8;
		
		this(8, 1);		//위의 두 줄 대신, 아래의 생성자를 호출함
	}
	
	//값을 지정하는 경우
	//매개변수로 전달 받은 값으로 지정
	public SoCriteria(int amount, int pageNum) {
		super();
		this.amount = amount;
		this.pageNum = pageNum;
	}
	
	
	//검색
	public String[] getTypeArr() {
		//type이 안넘어왔다면 빈 String 배열객체를 넘기고, type에 값이 있다면 잘라 ex) T W , T C
		return type == null ? new String[] {} : type.split("");		
	}
	

}
