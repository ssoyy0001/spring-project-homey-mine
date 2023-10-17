package org.homey.domain;

import java.util.Date;

import lombok.Data;
@Data
public class VisitVO {
	
	// VisitVO: 방문실측 스케줄 정보
	
	private int consultNo; // 견적상담번호 (FK)
    private int visitNo; // 방문 실측 스케줄 번호 (PK)
    private Date visitDate; //실측 일자
    private boolean visitStatus; //실측 여부 O, X
  
}
