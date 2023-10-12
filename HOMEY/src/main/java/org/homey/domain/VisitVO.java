package org.homey.domain;

import java.util.Date;


import lombok.Data;
@Data
public class VisitVO {
	
	// VisitVO: 방문실측 스케줄 정보

    private int visitNo; // 방문 실측 스케줄 번호 (PK)
    private int consultNo; // 견적상담번호 (FK)
    private String title; // 일정 제목
    private String description; // 일정 설명
    private String start; // 일정 시작일
    private String end; // 일정 종료일
    private String type; // 카테고리
    private String backgroundColor; // 배경색
    private String textColor; // 텍스트색
    private boolean allDay; // 종일 여부
  
}
