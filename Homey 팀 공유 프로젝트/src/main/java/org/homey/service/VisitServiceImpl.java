package org.homey.service;

import java.util.List;

import org.homey.domain.VisitVO;
import org.homey.mapper.VisitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class VisitServiceImpl implements VisitService {

	@Setter(onMethod_ = @Autowired)
	private VisitMapper visitMapper;

	@Override
	@Transactional
	public boolean register(List<VisitVO> visitList) { // 등록시 true, 아니면 false
		log.info("스케줄 register ServiceImpl...");
		for (VisitVO visit : visitList) {
			if (visitMapper.insert(visit) != 1) { // 만약 개별 등록에 실패하면 false 반환
				return false;
			}
		}
		return true; // 모든 등록이 성공적으로 이루어지면 true 반환
	}

	// 스케줄 전체 조회 - 관리자
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

	// 스케줄 상세 조회
	@Override
	public VisitVO view(int visitNo) {
		log.info("스케줄 view ServiceImpl...");
		return visitMapper.select(visitNo);
	}

	// 스케줄 수정
	@Override
	@Transactional
	public boolean modify(List<VisitVO> visitList) { // 수정시 true, 아니면 false
		log.info("스케줄 modify ServiceImpl...");
		for (VisitVO visit : visitList) {
			if (visitMapper.update(visit) != 1) { // 만약 개별 등록에 실패하면 false 반환
				return false;
			}
		}
		return true; // 모든 등록이 성공적으로 이루어지면 true 반환
	}

	// 스케줄 삭제
	@Override
	public boolean remove(int visitNo) { // 삭제시 true, 아니면 false
		log.info("스케줄 remove ServiceImpl...");
		return visitMapper.delete(visitNo) == 1;
	}

}
