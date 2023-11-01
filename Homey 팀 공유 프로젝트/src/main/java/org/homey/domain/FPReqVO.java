package org.homey.domain;

import lombok.Data;

@Data
public class FPReqVO {

	//제품 나눔 신청 관련 VO
	private int fpWinRn;				//제품 나눔 신청 로우넘 (인덱스번호)
	private int fpWinNo;				//제품 나눔 당첨자 번호 (PK)  -> 제품나눔의 경우, 선착순이라서 신청자==당첨자
    private int fpNo;					//제품 나눔 게시글번호 (FK)
    private String mid;				//당첨자 ID (FK)
    
    private MemberVO mvo;		//제품 나눔 신청자의 회원정보
    
}
