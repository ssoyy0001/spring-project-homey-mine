package org.homey.domain;

import java.util.Date;


import lombok.Data;
@Data
public class NoticeVO {

  
    private int notNo; // 공지사항 번호
    private String notCategory; // 분류
    private String notTitle; // 제목
    private String notCont; // 내용
    private int notHit; // 조회 수
    private String notImage; // 사진 : 이미지가 하나 들어가며 이거쓰고, 아니면 attachVO사용
    private Date notDate; // 작성일자

    private String mid; // 작성자의 아이디
}
