package org.homey.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class SiRequestVO {
	
    private int sireqNo;// 의뢰번호(PK)   
    
    private ConsultVO consultvo;// 견적상담관련 목록(FK) 시공의뢰 1건에 시공의뢰 견적상담 1건이기에 VO객체로 생성
    private QuotationVO quotationvo;// 견적서관련 목록(FK) 위와 동일
    
    private Date sireqDate;// 시공의뢰 등록일   
    
    private ItemVO ivo;// consultNo에 해당하는 아이템 목록(철거 항목/시공 항목 및 비용)
    
    private int sigongTotal;// 총 시공 금액    
    
    private String sireqStatus;// 의뢰 진행 현황
    private String payStatus;// 결제 진행 현황
    
    private List<SiRequestAttachVO> sireqAttachList;// 시공의뢰 첨부파일
    
//    private int quoNo; // 견적서 번호 (PK)
//    private int itemNo; // 아이템 번호 (PK)
    
//    private String mid;// 회원(의뢰인)ID(FK)    
//    private String mname;// 의뢰인 이름   
   
//    private String constScheduleStart; // 시공일정 시작
//    private String constScheduleEnd; // 시공일정 끝 
//    private String buildingType;// 건물 유형    
//    private int pyeongsu ;// 평수   
    
//    private int constTotal; // 시공 비용
//    private int demolTotal; // 철거 비용
    
//    private QuotationVO quotationVO;// 견적서 상세 정보 (QuotationVO 객체)
    
}
