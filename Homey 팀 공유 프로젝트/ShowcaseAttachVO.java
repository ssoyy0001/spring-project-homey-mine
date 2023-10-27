package org.homey.domain;

import lombok.Data;

@Data
public class ShowcaseAttachVO {
	private int scid;
	private String uuid;
	private String upFolder;
	private String fileName;
	private int isThumbnail;
}
