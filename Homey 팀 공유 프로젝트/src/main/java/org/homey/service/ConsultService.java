package org.homey.service;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.ItemVO;
import org.homey.domain.MemberVO;



public interface ConsultService {
	
	
	public MemberVO consultMember(int consultNo); // 특정 견적상담의 멤버 정보 가져오기
	
//	public boolean register(ConsultVO cvo); // 견적상담 등록 
	public int register(ConsultVO cvo, ItemVO ivo); // 견적상담 등록 및 시공항목 등록
    public List<ConsultVO> list(Criteria cri); // 견적상담 전체 목록 조회 + 페이징
    public List<ConsultVO> list(Criteria cri, String mid); // 나의 견적상담 전체 목록 조회 + 페이징
    public ConsultVO view(int consultNo); // 견적상담 상세 조회
    public boolean modify(ConsultVO cvo); // 견적상담 수정
    public boolean remove(int consultNo); // 견적상담 삭제
    public int totalCount(Criteria cri); // 견적상담 개수 조회
	
	
	//서비스를 구현하는 서비스imple클래스를 만들기
	//스프링에서 관리하는 bean으로 추가
}
