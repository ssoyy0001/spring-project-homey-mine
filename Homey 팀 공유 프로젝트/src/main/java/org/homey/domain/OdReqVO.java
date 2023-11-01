package org.homey.domain;

import java.util.Date;
import lombok.Data;

@Data
public class OdReqVO {
	
	//원데이클래스 신청 관련 VO
	//직접 입력해야 하는 것 : odNo, mid, odReqTitle, odReqContent
	
	private int odReqRn;							//원데이클래스 신청 로우넘(인덱스번호)
    private int odReqNo;							//원데이클래스 신청 번호 (PK)
    private int odNo;								//원데이클래스 게시글 번호 (FK)
    private String mid;							//신청자 ID (FK)
    private String odReqTitle;					//제목
    private String odReqContent;				//사연내용
    private Date odReqDate;					//신청일자
    private int odReqWin;						//당첨여부 (0:미당첨 / 1:당첨)

    private MemberVO mvo;					//원데이클래스 신청자의 회원정보

}
