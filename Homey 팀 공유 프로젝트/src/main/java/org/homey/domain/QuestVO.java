package org.homey.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class QuestVO {
	
	private int questNo; // 문의등록번호 (PK)
    private String mid; // 회원ID (FK)
    private String questTitle; // 제목
    private Date questDate; // 문의작성일
    private String questContent; // 문의내용
    private Date responseDate; // 답변작성일
    private String responseContent; // 답변내용
    private String responseStatus; // 답변진행현황

}
