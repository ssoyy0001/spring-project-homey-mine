package org.homey.domain;

import lombok.Data;
@Data
public class VisitVO {
	
	// VisitVO: 방문실측 스케줄 정보
	
	private int consultNo; // 견적상담번호 (FK)
    private int visitNo; // 방문 실측 스케줄 번호 (PK)
    private String visitDateStart; //실측 일자 시작
    private String visitDateEnd; //실측 일자 끝
    private String visitStatus; //실측 여부
    private String description; //설명
  
}
