package org.homey.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class SiReviewVO {
		
    private int sirevNo;// 시공후기 번호 (PK)   
    private int sicheNo;// 작업등록 번호 (FK) //혹시라도 못불러오면 vo객체로 불러오기
    
    private ConsultVO consultvo;// 견적상담관련 목록(FK)
    private QuotationVO quotationvo;// 견적서관련 목록(FK)
    
    private String sirevTitle;// 제목    ㅣ
    private String sirevContent;// 내용
    private Date sirevDate;// 시공 후기 작성일
    
    private List<SiReviewAttachVO> sirevAttachList;// 시공후기 첨부파일(사진)
    
//    private String mid;// 회원 ID (FK)   
//    private String buildingType;// 건물 유형    
//    private String constScheduleStart; // 공사기간 시작
//    private String constScheduleEnd; // 공사기간 끝       

}
