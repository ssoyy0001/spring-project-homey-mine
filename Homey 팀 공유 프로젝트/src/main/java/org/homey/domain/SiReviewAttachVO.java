package org.homey.domain;

import lombok.Data;

@Data
public class SiReviewAttachVO {
	
	private int sirevNo;// 시공후기 번호 (FK)
	private String fileName; //
	private String upFolder; //
	private String uuid; //
	private String image; // 

}
