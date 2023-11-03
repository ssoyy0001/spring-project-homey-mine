package org.homey.domain;

import lombok.Data;

@Data
public class ASBoardAttachVO {
	private int bno;
	private String uuid;
	private String upFolder;
	private String fileName;
	private boolean image;
}
