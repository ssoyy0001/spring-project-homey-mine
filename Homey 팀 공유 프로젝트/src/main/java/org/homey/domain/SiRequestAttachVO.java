package org.homey.domain;

import lombok.Data;

@Data
public class SiRequestAttachVO {
	
	private String uuid; //고유값
	private int sireqNo;// 시공의뢰번호(FK)
	private String fileName; //파일이름
	private String upFolder; //저장경로
	private boolean image; //이미지파일 

}
