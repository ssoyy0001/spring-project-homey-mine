package org.homey.domain;

import lombok.Data;

@Data
public class SiScheduleAttachVO {
	
	private int sicheNo; // 작업등록번호 (FK)
	private String fileName; //
	private String upFolder; //
	private String uuid; //
	private String image; // 

}
