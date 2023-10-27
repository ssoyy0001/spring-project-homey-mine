package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ShowcaseVO {
	private int scid;//시퀀스
	private int sicheNo; // 작업등록번호 (FK)
	private String scTitle;// 제목
	private String scContent;// 내용
	private int scrabCnt;//스크랩수->트리거 사용
	private String totalRange; // 비용
	private String sizeRange; // 평수
	private String buildingType; // 주거 유형//여기까지가 DB
	private Date scDate;// 작성 날짜
	private int isVaild;//스크랩유효여부
	private String thumbnail;
	private List<ShowcaseAttachVO> attachList;//이미지들
	
}
