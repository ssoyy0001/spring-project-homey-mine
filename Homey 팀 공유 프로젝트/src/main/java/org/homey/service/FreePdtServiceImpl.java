package org.homey.service;

import java.util.List;

import org.homey.domain.SoCriteria;
import org.homey.domain.FreePdtVO;
import org.homey.mapper.FreePdtMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FreePdtServiceImpl implements FreePdtService {
	
	private boolean result;									//boolean으로 리턴된 것 담을 result 변수
	
	@Setter(onMethod_ = @Autowired)
	   private FreePdtMapper freePdtMapper;			//제품 나눔 게시글 CRUD 맵퍼

	@Override
	public int fpTotalCount(SoCriteria cri) {			//페이징 시 필요한 게시글 개수 조회
		log.info("fpTotalCount.......");
		return freePdtMapper.fpTotalCount(cri);
	}

	@Override
	public List<FreePdtVO> fpListPaging(SoCriteria cri) {			//제품 나눔 게시글 전체조회 (페이징O)
		log.info("listPaging......." + cri);		
		return freePdtMapper.fpSelectAllPaging(cri);
	}


	@Override
	public FreePdtVO fpView(int fpNo) {									//제품 나눔 게시글 상세조회
		log.info("view......" + fpNo); 			
		return freePdtMapper.fpSelect(fpNo);
	}

	@Override
	public boolean fpRegister(FreePdtVO fpvo) {						//제품 나눔 게시글 등록
		log.info("register...." + fpvo);
		result = freePdtMapper.fpInsert(fpvo) == 1;
		return result;
	}

	@Override
	public boolean fpRemove(int fpNo) {								//제품 나눔 게시글 삭제
		log.info("remove........" + fpNo);
		result = freePdtMapper.fpDelete(fpNo) == 1;		
		return result;
	}

	@Override
	public boolean fpModify(FreePdtVO fpvo) {						//제품 나눔 게시글 수정
		log.info("modify....." + fpvo);		
		result = freePdtMapper.fpUpdate(fpvo) ==1;
		return result; 
	}

}
