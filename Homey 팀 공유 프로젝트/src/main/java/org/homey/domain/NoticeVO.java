package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class NoticeVO {

    private int notNo; // 공지사항 번호
    private String notCategory; // 분류
    private String notTitle; // 제목
    private String notCont; // 내용
    private int notHit; // 조회 수
    private Date notDate; // 작성일자
    private String mid; // 작성자의 아이디
    private List<NoticeAttachVO> attachList;

}
