package org.homey.domain;

import lombok.Data;

@Data
public class EmailVO {

	//이메일 관련 VO
	
	private String mailAddress;		//이메일주소 (From)
	private String mailTitle;				//제목
	private String mailContent;		//내용
	
}
