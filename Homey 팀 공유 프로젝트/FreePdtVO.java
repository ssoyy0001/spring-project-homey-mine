package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FreePdtVO {
	
	//제품 나눔 게시글 관련 VO
	
	private int fpRn;										//제품 나눔 게시글 로우넘(인덱스번호)
    private int fpNo;										//제품 나눔 게시글 번호 (PK)
    private String fpTitle;								//제목
    private String fpContent;							//내용
    private String freePdt;								//나눔물품
    private int fpPeople;									//당첨인원
    private int fpNowPeople;							//현재 신청자 수
    private String fpDeadline;						//모집마감일
    private int fpState;									//모집현황( 0:나눔중 / 1:신청마감 )
    private String fpGetDate;								//수령일
    private String fpGetPlace;							//수령장소
    private Date fpWDate;								//작성일
    private String mid;									//작성자 ID (FK)
    private String fpImg;								//이미지
    
    private List<FPReqVO> fPReqList;		//fpNo에 대한 신청목록 -> 나의 제품 나눔 신청 목록 조회할 때 JOIN 하려면 필요함 : 멤버..? 참고
    
    //[신청하기]버튼 클릭했을 때 중복신청여부 보려고 List<FPdtReqVO>를 가지고 있어야 하는지 고민했던 부분은
  	//Mapper에 selectAll() 메서드 추가하는 걸로 결정
    
    
}
