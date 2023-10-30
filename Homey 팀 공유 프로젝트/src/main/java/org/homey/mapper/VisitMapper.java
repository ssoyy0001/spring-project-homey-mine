package org.homey.mapper;

import java.util.List;

import org.homey.domain.VisitVO;

public interface VisitMapper {

    public int insert(VisitVO vvo); //스케줄 등록
    public VisitVO select(int visitNo); //스케줄 상세조회(특정 스케줄 번호를 기반으로 스케줄 정보를 데이터베이스)
    public List<VisitVO> selectAll(); //스케줄 전체 조회(관리자)
    public VisitVO selectByConsultNo(int consultNo);//특정 견적상담 번호를 기반으로 한 스케줄(회원)

    public int update(VisitVO vvo); //스케줄 수정
    public int delete(int visitNo); //스케줄 삭제
    
}
