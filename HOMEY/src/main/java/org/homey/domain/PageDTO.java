package org.homey.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private final double NUM_PER_PAGE = 5.0;	//한 페이지에 표시할 페이지 번호 수
	private int start;			//시작 페이지 번호
	private int end;			//끝 페이지 번호
	private boolean prev;		//이전 
	private boolean next;		//다음
	private Criteria cri;		//한 페이지에 표시할 게시물의 수 및 페이지 번호
	
	public PageDTO(Criteria cri, int totalCount) {
		this.cri = cri;
	    // 실제 끝 페이지 계산
	    // 전체 검색 결과 중 마지막 페이지를 의미하는  pages를 totalCount와 amount를 이용		
		int pages = (int)(Math.ceil((double)totalCount/cri.getAmount())); 
	    // 끝 페이지 계산
	    //end는 (현재 페이지 번호 / 페이지 번호 수)를 올림한 뒤 페이지 번호 수를 곱한 값이		
		end = (int)(Math.ceil(cri.getPageNum()/NUM_PER_PAGE) * NUM_PER_PAGE); 
		// 시작 페이지 계산
		start = end - (int)(NUM_PER_PAGE - 1);
	    // 끝 페이지가 실제 페이지보다 큰 경우 수정
		end   = end >= pages ? pages : end; 
		
		// 이전 페이지 존재 여부
		prev = start > 1;
		// 다음 페이지 존재 여부
		next = end < pages;
	}
}











