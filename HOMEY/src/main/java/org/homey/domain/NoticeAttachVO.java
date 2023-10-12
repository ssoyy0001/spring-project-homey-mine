package org.homey.domain;

import lombok.Data;

@Data
public class NoticeAttachVO {
    private int notNo;
    private String uuid;
    private String upFolder;
    private String fileName;
    private boolean image;
}
