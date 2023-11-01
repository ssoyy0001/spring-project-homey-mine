package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OnedayVO {
	
	//원데이클래스 관련 VO
	
	private int odRn;									//원데이클래스 게시글 로우넘(인덱스번호)
	private int odNo;									//원데이클래스 게시글 번호 (PK)
	private String odTitle;							//제목
	private String odContent;						//내용
	private String odName;							//원데이클래스명
	private String odDate;							//진행일시 -> 시간까지 들어가야 해서 String
	private String odPlace;							//진행장소
	private String odTime;							//예상소요시간
	private int odPeople;								//모집인원
	private String odMc;								//진행자
	private String odDeadline;						//모집마감일
	private int odState;								//모집현황(0:모집중 / 1:모집마감)
	private Date odWDate;							//게시글 작성일
	private String mid;								//작성자 ID(FK)
	private String odImg;							//이미지
	private List<OdReqVO> odReqList;			//odNo에 대한 신청목록 -> 나의 원데이클래스 목록 조회할 때 JOIN 하려면 필요함
	
}
