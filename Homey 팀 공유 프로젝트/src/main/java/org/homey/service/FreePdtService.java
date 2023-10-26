package org.homey.service;

import java.util.List;

import org.homey.domain.SoCriteria;
import org.homey.domain.FreePdtVO;


public interface FreePdtService {


	//제품 나눔 게시글 관련 서비스단
	
	//페이징
	public int fpTotalCount(SoCriteria cri);								//제품 나눔 게시글 개수
	public List<FreePdtVO> fpListPaging(SoCriteria cri);			//제품 나눔 게시글 전체조회 , SoCriteria에는 amount, pageNum, searchOpt, searchKywd 들어있음
	
//	public List<FreePdtVO> fpList();									//제품 나눔 게시글 전체조회 (페이징X)
	public FreePdtVO fpView(int fpNo);								//제품 나눔 게시글 상세조회
	public boolean fpRegister(FreePdtVO fpvo);					//제품 나눔 게시글 등록
	public boolean fpRemove(int fpNo);								//제품 나눔 게시글 삭제
	public boolean fpModify(FreePdtVO fpvo);						//제품 나눔 게시글 수정



}
