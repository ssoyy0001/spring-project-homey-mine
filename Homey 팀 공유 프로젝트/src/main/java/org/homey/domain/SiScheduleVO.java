package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SiScheduleVO {
	
	private int sicheNo; // 작업등록번호 (PK)
    private int sireqNo; // 시공의뢰번호 (FK) //혹시라도 못불러오면 vo객체로 불러오기
    
    private ConsultVO consultvo;// 견적상담관련 목록(FK)
    private QuotationVO quotationvo;// 견적서관련 목록(FK)
    
    private Date sicheDate; // 작업등록일
    private String balanceStatus; // 잔금처리현황
    private String constructionStatus; // 시공진행현황
    private String workCrew; // 작업할 시공팀
    
    private ItemVO ivo;// consultNo에 해당하는 아이템 목록(철거 항목/시공 항목 및 비용)
    
    private List<SiScheduleAttachVO> sicheAttachList;// 시공작업 첨부파일

    //  private int itemNo; // 아이템 번호 (PK)   
//    private String mid; // 회원ID (FK)
//    private String mname; // 의뢰인이름
//    private String constScheduleStart; // 시공일정 시작
//    private String constScheduleEnd; // 시공일정 끝 
//    private String buildingType; // 건물유형
    
}
