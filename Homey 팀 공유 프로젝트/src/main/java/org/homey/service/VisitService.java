package org.homey.service;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.VisitVO;

public interface VisitService {
	
    public boolean register(VisitVO vvo);
    public List<VisitVO> list(); // 모든 스케줄 조회 (관리자)
    public VisitVO listByConsultNo(int consultNo);// 특정 견적상담 번호를 기반으로 스케줄 조회 (회원)

    public VisitVO view(int visitNo); // 스케줄 상세 조회
   
    public boolean modify(VisitVO vvo);
    public boolean remove(int visitNo);
    
    
	//서비스를 구현하는 서비스imple클래스를 만들기
	//스프링에서 관리하는 bean으로 추가
}
