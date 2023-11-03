package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ASBoardVO {
    private int bno; 
    private String title; 
    private String content; 
    private String mid; 
    private Date regDate; 
    private Date updateDate; 
    private List<ASBoardAttachVO> attachList; 
    private String status;
    private String replyContent;  // 답변 내용
    private Date replyRegDate;     // 답변 작성일
    private Date replyUpdateDate;  // 답변 수정일
    private String replyMid;       // 답변 작성자 (관리자)
    private MemberVO mvo;

}
    
