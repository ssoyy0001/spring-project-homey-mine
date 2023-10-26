package org.homey.service;

import java.util.List;

import org.homey.domain.FPReqVO;
import org.homey.mapper.FpReqMapper;
import org.homey.mapper.FreePdtMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FPReqServiceImpl implements FPReqService {
	
	private boolean result;									//boolean으로 리턴된 것 담을 result 변수
	
	@Setter(onMethod_ = @Autowired)
	   private FpReqMapper fpReqMapper;				//제품 나눔 신청 CRUD 맵퍼
	
	
	@Setter(onMethod_ = @Autowired)
	   private FreePdtMapper freePdtMapper;			//제품 나눔 게시글 CRUD 맵퍼 -> 신청서 등록 후 현재 신청자 수 증가시키려고
	

	@Override
	public List<FPReqVO> fpWinList(int fpNo) {
		log.info("OdReqService의 (" + fpNo +  "번 게시물)에 대한 당첨자목록......");		
		return fpReqMapper.fpWinSelect(fpNo);
	}

	@Override
	public List<FPReqVO> fpWinListAll() {
		log.info("OdReqService의 (모든 게시물)에 대한 당첨자목록......");		
		return fpReqMapper.fpWinSelectAll();
	}

	@Override
	public List<FPReqVO> fpListMine(String sid) {
		log.info("OdReqService의 (" + sid +  " 회원)의 제품 나눔 신청목록......");		
		return fpReqMapper.fpSelectMine(sid);
	}

	@Override
	@Transactional
	public boolean fpReqRegister(FPReqVO fprvo) {
		//트랜잭셔널 애노테이션 추가한 후,
		//mapper.register 후 mapper.plusNowPeople도 처리되게 하기
		
		log.info("register...." + fprvo);
		result = fpReqMapper.fpReqInsert(fprvo) == 1;
		
		if(result) {				//나눔 신청이 잘 되었다면,
			freePdtMapper.plusNowPeople(fprvo.getFpNo());
		}
		return result;
	}

	
	@Override
	public int fpReqCheck(int fpNo, String mid) {
		
		return fpReqMapper.fpReqCheck(fpNo, mid);
	}

}
