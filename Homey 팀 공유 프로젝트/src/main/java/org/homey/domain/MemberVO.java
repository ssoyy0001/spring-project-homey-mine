package org.homey.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String mid;//아이디
	private String pw;//비밀번호
	private String mname;//이름
	private String maddr;//주소
	private String memail;//이메일
	private String mphone;//전화번호
	private Date mdate;//가입날짜
	private List<AuthVO> authList;//권한
}
