package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class ConsultVO {

	//ConsultVO: 견적 상담 정보
	
	private int consultNo; // 견적상담번호(PK)
	private String mid; //회원 id
	private MemberVO member; //회원 정보가 담긴 VO : 아이디, 이름을 가져올 예정
    private String mphone; // 연락처
    private String postcode; // 우편 번호
    private String address; // 도로명 주소
    private String detailAddress; // 상세주소
    private String buildingType; // 건물 유형
    private String scheduledDate; // 공사예정일 
    private int pyeongsu; //평수
    private int budget; // 예산

    private ItemVO item; //시공 항목들을 담은 VO : 1 or 0으로 insert 예정
    private String happyCall; // 해피콜 희망일시
    private Date consultDate; // 견적 상담 신청날짜
    private String status ; // 처리현황
    
    //하나의 '견적상담 상세조회'페이지에 
    //견적상담 상세조회, 수정, 삭제 / 방문실측 스케줄 등록, 수정, 삭제 / 견적서 등록, 수정, 삭제가 가능 
    // 페이지가 같을 때 각 정보가 담긴vo를 list로 불러옴
    private List<VisitVO> vvoList;
    private List<QuotationVO> qvoList;
  
}
