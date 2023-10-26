package org.homey.service;

import java.util.List;

import org.homey.domain.OdReqVO;
import org.homey.mapper.OdReqMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OdReqServiceImpl implements OdReqService {
	
	private boolean result;									//boolean으로 리턴된 것 담을 result 변수
	
	@Setter(onMethod_ = @Autowired)
	   private OdReqMapper odReqMapper;			//원데이클래스 신청 CRUD 맵퍼

	@Override
	public List<OdReqVO> odReqList(int odNo) {											//특정 게시물의 원데이클래스 신청목록
		log.info("OdReqService의 (" + odNo +  "번 게시물)에 대한 신청목록......");		
		return odReqMapper.odReqSelectAll(odNo);
	}

	@Override
	public List<OdReqVO> odReqListMine(String sid) {									//나의 원데이클래스 신청목록
		log.info("OdReqService의 (" + sid +  "회원)의 제품 나눔 신청목록......");		
		return odReqMapper.odReqSelectMine(sid);
	}

	@Override
	public OdReqVO odReqView(int odReqNo) {											//원데이클래스 신청서 상세조회					
		log.info("view......" + odReqNo); 
		return odReqMapper.odReqSelect(odReqNo);
	}

	@Override
	public boolean odReqRegister(OdReqVO odrvo) {									//원데이클래스 신청
		log.info("register...." + odrvo);
		result = odReqMapper.odReqInsert(odrvo) == 1;
		return result;
	}

	@Override
	public boolean odReqRemove(int odReqNo) {										//원데이클래스 신청 철회
		log.info("remove........" + odReqNo);
		result = odReqMapper.odReqDelete(odReqNo) == 1;		
		return result;
	}

	@Override
	public boolean odReqWin(int odReqNo) {												//원데이클래스 당첨
		log.info("odReqWin....." + odReqNo);		
		result = odReqMapper.odReqWin(odReqNo) ==1;
		return result;
	}

	@Override
	public boolean odReqWinX(int odReqNo) {											//원데이클래스 당첨취소
		log.info("odReqWinX....." + odReqNo);		
		result = odReqMapper.odReqWinX(odReqNo) ==1;
		return result;
	}

	@Override
	public List<OdReqVO> odWinList(int odNo) {											//원데이클래스 당첨자 목록
		log.info("OdReqService의 (" + odNo +  "번 게시물)의 당첨자목록......");		
		return odReqMapper.odWinSelect(odNo);
	}

	@Override
	public int doubleCheck(int odNo, String mid) {										//원데이클래스 중복신청 체크
		
		return odReqMapper.doubleCheck(odNo, mid);
	}

}
