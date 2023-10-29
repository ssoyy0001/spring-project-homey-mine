package org.homey.domain;

import java.util.Date;

import lombok.Data;
@Data
public class VisitVO {
	
	// VisitVO: 방문실측 스케줄 정보
	
	private int visitNo; // 방문 실측 스케줄 번호 (PK)
	private int consultNo; // 견적상담번호 (FK)
	private String visitStatus; //실측 여부 O, X
    private Date visitStartDate; //실측 일자
    private Date visitEndDate; //실측 일자
  
}
