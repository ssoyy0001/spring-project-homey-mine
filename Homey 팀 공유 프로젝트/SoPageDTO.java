package org.homey.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class SoPageDTO {
	private final double NUM_PER_PAGE = 5.0;	//한 페이지에 표시할 페이지 번호 수
	private int start;			//시작 페이지 번호
	private int end;			//끝 페이지 번호
	private boolean prev;	//이전
	private boolean next;	//다음
	private SoCriteria cri;	//한 페이지에 표시할 게시물의 수 및 페이지 번호
	
	
	public SoPageDTO(SoCriteria cri, int totalCount) {

		this.cri = cri;
		int pages = (int)(Math.ceil( (double)totalCount / cri.getAmount()));	//총 페이지 수 : 올림(전체 게시물 개수 /페이지당 표시할 게시물 개수)
																												//예전에 쓰던 amount_per_page가 cri.getAmount()가 됨
		end = (int)(Math.ceil(cri.getPageNum() / NUM_PER_PAGE) * NUM_PER_PAGE );
		start =(end -  ((int)NUM_PER_PAGE -1));
		end = end >= pages ? pages : end;	
		
		prev = start > 1;	
		next = end < pages;
		//pages 총 페이지 수 : 전체 갯수 
	}
	
}