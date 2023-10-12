package org.homey.mapper;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.VisitVO;

public interface VisitMapper {

    public void insert(VisitVO vvo); //스케줄 등록
    public VisitVO select(int visitNo); //스케줄 조회
    public int update(VisitVO vvo); //스케줄 수정
    public int delete(int visitNo); //스케줄 삭제
    public List<VisitVO> selectByConsultNo(int consultNo);
    
}
