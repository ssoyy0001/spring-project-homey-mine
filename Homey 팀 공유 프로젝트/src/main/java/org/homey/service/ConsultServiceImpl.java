package org.homey.service;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.MemberVO;
import org.homey.mapper.ConsultMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service					//spring에서 관리하는 service, root-context.xml에 등록되는지 확인
@Log4j						//로그기록을 위한 어노테이션
public class ConsultServiceImpl implements ConsultService {
	@Setter(onMethod_ = @Autowired)
	private ConsultMapper consultMapper;
	
	//견적 상담 등록 - 완 
	@Override
	public boolean register(ConsultVO cvo) {
		log.info("견적 상담 register ServiceImpl...");
		return consultMapper.insert(cvo) == 1; // insert 메서드 실행 결과가 1이면 true 반환, 그렇지 않으면 false 반환
	}

	//견적 상담 전체목록 조회 + 페이징 - 완
	@Override
	public List<ConsultVO> list(Criteria cri) {
		log.info("견적 상담 list ServiceImpl...");
		return consultMapper.selectAllPaging(cri);
	}
	
	// 나의 견적상담 전체 목록 조회 + 페이징 - 완
	@Override
	public List<ConsultVO> list(Criteria cri, String mid) {
		log.info("나의 견적 상담 list ServiceImpl...");
		return consultMapper.selectAllPagingMe(cri, mid);
	}
	
	// 특정 견적상담의 멤버 정보 가져오기
	//@Override
	public MemberVO consultMember(int consultNo) {
        // 데이터베이스에서 멤버 정보를 가져오는 코드
        // consultMapper를 사용하여 데이터베이스 쿼리 실행

//		MemberVO mvo = consultMapper.con(consultNo);
		return null;
	}
	
	//견적 상담 상세 조회 - 완
	@Override
	public ConsultVO view(int consultNo) {
		log.info("견적 상담 view ServiceImpl...");
		return consultMapper.select(consultNo);
	}

	//견적 상담 수정 - 완
	@Override
	public boolean modify(ConsultVO cvo) {
		log.info("견적 상담 modify ServiceImpl...");
		return consultMapper.update(cvo) == 1;
	}

	//견적상담 삭제 - 완
	@Override
	public boolean remove(int consultNo) {
		log.info("견적 상담 remove ServiceImpl...");
		return consultMapper.delete(consultNo) == 1;
	}

	//견적상담 개수 조회 - 완
	@Override
	public int totalCount(Criteria cri) {
		log.info("견적 상담 totalCount ServiceImpl...");
		return consultMapper.totalCount(cri);
	}

// 페이징 없는 견적상담 전체 조회
//	@Override
//	public List<ConsultVO> list() {
//		// TODO Auto-generated method stub
//		return null;
//	}
	
}
