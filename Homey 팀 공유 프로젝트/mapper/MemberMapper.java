package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.MemberVO;
import org.homey.domain.ScCriteria;

public interface MemberMapper {
	
	public List<MemberVO> selectAll(ScCriteria cri);//관리자페이지 전체회원조회
	public MemberVO select(String mid);//회원상세보기 및 내 정보조회
	public int update(MemberVO mvo);//회원정보 수정
	public int delete(String mid);//탈퇴 및 삭제
	public int insert(MemberVO mvo);//회원 가입
	
	//public MemberVO login(String mid, String pw);//로그인은 시큐리티가 대신 해쥼
	public String selectId(@Param("mname") String mname,@Param("mphone") String mphone);//아이디 찾기
	public int chkId(String mid);//아이디 중복체크 
	public String selectPw(@Param("mid") String mid,@Param("mname") String mname,@Param("mphone") String mphone);//비번찾기에서 찾는것 비밀번호 찾아서 넘겨줄듯?
	public int updatePw(String mid,String newPw);//비밀번호 변경
}
