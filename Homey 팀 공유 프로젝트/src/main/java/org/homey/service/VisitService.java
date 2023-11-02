package org.homey.service;

import java.util.List;

import org.homey.domain.VisitVO;

public interface VisitService {
	
    public boolean register(List<VisitVO> visitList);
    public List<VisitVO> list(); // 모든 스케줄 조회 (관리자)
    public VisitVO listByConsultNo(int consultNo);// 특정 견적상담 번호를 기반으로 스케줄 조회 (회원)
    public VisitVO view(int visitNo); // 스케줄 상세 조회
    public boolean modify(List<VisitVO> visitList);
    public boolean remove(int visitNo);
    
}
