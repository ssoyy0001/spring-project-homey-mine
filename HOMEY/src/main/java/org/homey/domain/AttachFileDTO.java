package org.homey.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	//업로드한 개수만큼 DTO가 생겨야함
	private String fileName;	//업로드 파일 이름
	private String upFolder;	//getFolder
	private String uuid;		//UUID
	private boolean image;		//isImage
}
