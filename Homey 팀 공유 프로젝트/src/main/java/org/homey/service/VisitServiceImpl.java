package org.homey.service;

import java.util.List;

import org.homey.domain.VisitVO;
import org.homey.mapper.NoticeMapper;
import org.homey.mapper.VisitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service					//spring에서 관리하는 요소인데 service니까 service 붙임
@Log4j						//만약 로그기록하고싶다면 log4j
public class VisitServiceImpl implements VisitService {

	@Setter(onMethod_ = @Autowired)
	private VisitMapper visitMapper;
	
	//스케줄 등록
	@Override
	public boolean register(VisitVO vvo) { //등록시 true, 아니면 false
		log.info("스케줄 register ServiceImpl...");
		return visitMapper.insert(vvo) == 1;
	}

	//스케줄 전체 조회 - 관리자
	@Override
	public List<VisitVO> list() {
		log.info("스케줄 관리자list ServiceImpl...");
		 return visitMapper.selectAll();
	}
	
	// 특정 견적상담 번호를 기반으로 스케줄 조회 (회원)
	@Override
	public VisitVO listByConsultNo(int consultNo) {
		log.info("스케줄 회원listByConsultNo ServiceImpl...");
		 return visitMapper.selectByConsultNo(consultNo);
	}
	
	//스케줄 상세 조회
	@Override
	public VisitVO view(int visitNo) {
		log.info("스케줄 view ServiceImpl...");
		return visitMapper.select(visitNo);
	}

	//스케줄 수정
	@Override
	public boolean modify(VisitVO vvo) { //수정시 true, 아니면 false
		log.info("스케줄 modify ServiceImpl...");
		 return visitMapper.update(vvo) == 1;
	}

	//스케줄 삭제
	@Override
	public boolean remove(int visitNo) { //삭제시 true, 아니면 false
		log.info("스케줄 remove ServiceImpl...");
		 return visitMapper.delete(visitNo) == 1;
	}





}
