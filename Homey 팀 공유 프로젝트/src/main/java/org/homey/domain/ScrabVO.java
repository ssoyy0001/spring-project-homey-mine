package org.homey.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ScrabVO {
	private int scrabNum;//스크랩 pk  seq
	private String mid;//멤버아이디fk
	private int scid;//시공사례fk
	private int isvaild;//유효여부default true->1 
	private Date scrabDate;//생성일시 sysdate
	
}
