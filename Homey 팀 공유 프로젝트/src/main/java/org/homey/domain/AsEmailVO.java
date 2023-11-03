package org.homey.domain;

import lombok.Data;

@Data
public class AsEmailVO {

	//이메일 관련 VO
    private int bno;                // 게시글 번호

	private String mailAddress;		//이메일주소 (From)
	private String mailTitle;				//제목
	private String mailContent;		//내용
	
}
