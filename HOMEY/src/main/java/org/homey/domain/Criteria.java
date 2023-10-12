package org.homey.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//한 페이지에 출력할 게시물의 수, 페이지 번호,
//검색 타입, 검색 키워드 저장 및 전달
@Getter
@Setter
@ToString
public class Criteria {
	private int amount;
	private int pageNum;
	private String type;
	private String keyword;
	
	//값을 지정하지 않은 경우
	//한 페이지 게시물(댓글)은 5개, 페이지 번호는 1로 지정
	public Criteria() {
		this(3, 1);
	}

	//값을 지정한 경우
	//매개변수로 전달 받은 값으로 지정
	public Criteria(int amount, int pageNum) {
		this.amount = amount;
		this.pageNum = pageNum;
	}
	
	//검색어 2개 이상 검색할 때 배열
		public String[] getTypeArr() {
			return type == null ? new String[] {} : type.split("");
		}
	
}







