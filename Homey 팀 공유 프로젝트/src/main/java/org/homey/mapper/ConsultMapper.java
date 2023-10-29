package org.homey.mapper;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.ItemVO;

public interface ConsultMapper {
    
    public int insert(ConsultVO cvo); // 견적상담 등록
    public int insertItem(ItemVO ivo); // 견적상담 등록과 동시에 ivo에 시공항목 추가
    
    public List<ConsultVO> selectAllPaging(Criteria cri); // 견적상담 전체 목록 페이징
    public List<ConsultVO> selectAllMe(String mid); // 나의 견적상담 전체 목록(페이징 X)

    public ConsultVO select(int consultNo); // 견적상담 상세 조회
    
    public int update(ConsultVO cvo); // 견적상담 수정
    public int delete(int consultNo); // 견적상담 삭제
    public int totalCount(Criteria cri); // 견적상담 개수 조회
    
    
}
