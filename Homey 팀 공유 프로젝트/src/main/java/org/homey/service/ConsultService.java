package org.homey.service;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.ItemVO;



public interface ConsultService {
	
	public int register(ConsultVO cvo, ItemVO ivo); // 견적상담 등록 및 시공항목 등록
    public List<ConsultVO> list(Criteria cri); // 견적상담 전체 목록 조회 + 페이징
    public List<ConsultVO> myList(String mid); // 나의 견적상담 전체 목록 조회
    public ConsultVO view(int consultNo); // consultNo를 입력받아서 ConsultVO와 관련된 ItemVO, QuotationVO, VisitVO의 정보를 함께 조회하는 기능
    public boolean modify(ConsultVO cvo); // 견적상담 수정
    public boolean remove(int consultNo); // 견적상담 삭제
    public int totalCount(Criteria cri); // 견적상담 개수 조회
}
