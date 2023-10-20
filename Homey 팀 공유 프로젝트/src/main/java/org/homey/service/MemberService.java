package org.homey.service;

import java.util.List;

import org.homey.domain.MemberVO;
import org.homey.domain.ScCriteria;

public interface MemberService {
	public List<MemberVO> list(ScCriteria cri);//관리자페이지 전체회원조회
	public MemberVO view(String mid);//회원상세보기 및 내 정보조회
	public boolean modify(MemberVO mvo);//회원정보 수정
	public boolean remove(String mid);//탈퇴 및 삭제
	public boolean regist(MemberVO mvo);//회원 가입
	
	
	public String findId(String mname,String mphone);//아이디찾기
	public String findPw(String mid,String mname,String mphone);//비번찾기
	public boolean modifyPw(String mid,String newpw);
	public boolean chkId(String mid);//아이디 중복체크 
}
