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
    private int itemNo; //아이뎀 번호(FK)
    //견적서 등록 시 같은 consultNo을 가진 item 테이블의 값이 변경되어야함
    private ItemVO item ; //여기서 itemNo을 설정해야함
    private Date quoDate; 				// 견적서 등록일
    private Date constScheduleStart; 	// 시공일정 시작
    private Date constScheduleEnd; 		// 시공일정 끝
    private int constTotal; // 시공 총 비용
    private int demolTotal; // 철거 총 비용
    private int total; // 총 견적 금액
    
}
