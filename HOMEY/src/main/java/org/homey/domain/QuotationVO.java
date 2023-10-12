package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class QuotationVO {

	//QuotationVO : 견적서 정보
	
    private int quoNo; // 견적서 번호 (PK)
    private int consultNo; // 견적상담번호 (FK)
    private String mname; // 이름 (FK)
    private String homeno; // 우편 번호
    private String maddr; // 도로명 주소 + 상세주소
    private String buildingType; // 건물 유형
    private int size;//평수
    private Date quoDate; // 견적서 등록일
    private String constScheduleStart; // 시공일정 시작
    private String constScheduleEnd; // 시공일정 끝
    private String constItems; // 시공항목
    private int constItemsCost; 	//시공항목 비용
    private String demolItems; // 철거항목
    private int demolItemsCost; 	//시공항목 비용
    private int constTotal; // 시공 총 비용
    private int demolTotal; // 철거 총 비용
    private int total; // 총 견적 금액
    
    private List<ConsultVO> cvoList;
  
}
