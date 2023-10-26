package org.homey.service;

import java.util.List;

import org.homey.domain.FPReqVO;


public interface FPReqService {
	
	// 제품 나눔 신청 관련 서비스단					
	
	public List<FPReqVO> fpWinList(int fpNo);					//제품 나눔 당첨자 목록조회 -> 특정 제품 나눔 게시글의 전체 신청목록
	public List<FPReqVO> fpWinListAll();							//제품 나눔 당첨자 목록조회 -> 모든 제품 나눔 게시글의 전체 신청목록 ( 나의 제품 나눔 신청 목록조회 시 필요 )
	public List<FPReqVO> fpListMine(String mid);			//나의 제품 나눔 신청 목록조회
	public boolean fpReqRegister(FPReqVO fprvo);			//제품 나눔 신청 : ServiceImpl 구현 시 plusNowPeople 트랜잭션해야 함!
	public int fpReqCheck(int fpNo, String mid);				//제품 나눔 신청 중복체크
		

}
