package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class QuotationVO {

	//QuotationVO : 견적서 정보
	
	private List<ConsultVO> cvoList; //견적 상담 정보에서 건물유형, 평수, 주소들, 이름을 가져오기 위함
	  
    private int quoNo; // 견적서 번호 (PK)
    private int consultNo; // 견적상담번호 (FK)

    //itemvo에 1원씩 들어오는게 들어가야함
    private ItemVO ivo; // consultNo에 해당하는 아이템 목록

    private Date quoDate; 				// 견적서 등록일
    private String constScheduleStart; 	// 시공일정 시작
    private String constScheduleEnd; 	// 시공일정 끝

    private int constTotal; // 시공 총 비용
    private int demolTotal; // 철거 총 비용
    private int total; // 총 견적 금액
    
}
