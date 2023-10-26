package org.homey.service;

import java.util.List;

import org.homey.domain.SoCriteria;
import org.homey.domain.OnedayVO;
import org.homey.mapper.OnedayMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OnedayServiceImpl implements OnedayService {
	
	private boolean result;									//boolean으로 리턴된 것 담을 result 변수
	
	@Setter(onMethod_ = @Autowired)
	   private OnedayMapper onedayMapper;			//원데이클래스 게시글 CRUD 맵퍼

	@Override
	public int odTotalCount(SoCriteria cri) {				//페이징 시 필요한 게시글 개수 조회
		log.info("odTotalCount.......");						//ServiceImpl까지 잘 넘어왔는지 로그에 찍어봄
		return onedayMapper.odTotalCount(cri);
	}

	@Override
	public List<OnedayVO> odListPaging(SoCriteria cri) {			//원데이클래스 게시글 전체조회 (페이징O)
		log.info("OnedayService의 listPaging......." + cri);		
		return onedayMapper.odSelectAllPaging(cri);
	}


	@Override
	public List<OnedayVO> odList(String mid) {					//내가 신청한 원데이클래스 게시글 전체조회 (페이징X)
		log.info("OnedayService의 list......." );	
		return onedayMapper.odSelectAll(mid);
	}
	
	@Override
	public OnedayVO odView(int odNo) {								//원데이클래스 게시글 상세조회
		log.info("view......" + odNo); 			
		return onedayMapper.odSelect(odNo);
	}

	@Override
	public boolean odRegister(OnedayVO odvo) {				//원데이클래스 게시글 등록
		log.info("register...." + odvo);
		result = onedayMapper.odInsert(odvo) == 1;
		return result;
	}

	@Override
	public boolean odRemove(int odNo) {							//원데이클래스 게시글 삭제
		log.info("remove........" + odNo);
		result = onedayMapper.odDelete(odNo) == 1;		
		return result;
	}

	@Override
	public boolean odModify(OnedayVO odvo) {					//원데이클래스 게시글 수정
		log.info("modify....." + odvo);		
		result = onedayMapper.odUpdate(odvo) ==1;
		return result; 
	}



}
