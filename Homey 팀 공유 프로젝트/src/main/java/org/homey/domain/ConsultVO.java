package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class ConsultVO {

	//ConsultVO: 견적 상담 정보
	
	private int consultNo; // 견적상담번호(PK)
	private String mid; //회원 id
//	private MemberVO member; //회원 정보가 담긴 VO : 아이디, 이름을 가져올 예정
	
    private String mphone; // 연락처
    private String postcode; // 우편 번호
    private String address; // 도로명 주소
    private String detailAddress; // 상세주소
    private String buildingType; // 건물 유형
    private String scheduledDate; // 공사예정일 
    private int pyeongsu; //평수
    private int budget; // 예산
    
    private ItemVO item;; //시공 항목들을 담은 VO
    
    private String happyCall; // 해피콜 희망일시
    private Date consultDate; // 견적 상담 신청날짜
    private String status ; // 처리현황 : 컨설트데이트와 스케줄 데이트의 값을 받아와서 바뀔것 !
    
    //여기서, "하나의 '견적상담 상세조회'페이지에 
    //견적상담 상세조회, 수정, 삭제가 가능하고, 방문실측 스케줄 등록, 수정, 삭제가 가능하고
    //견적서 등록, 수정, 삭제가 가능하다" 라는 요구 사항
    // 페이지가 같을 때 각 정보가 담긴vo를 list로 불러와야한다.
    private List<VisitVO> vvoList;
    private List<QuotationVO> qvoList;

    //itemVO가 들어감 0원으로  0, 0, 0, 0, 0, 1 1 1 //체크를 했고
    public void setConsultNo(int consultNo) {
        this.consultNo = consultNo;
    }

  
}
