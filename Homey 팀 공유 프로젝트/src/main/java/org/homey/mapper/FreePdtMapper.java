package org.homey.mapper;

import java.util.List;

import org.homey.domain.SoCriteria;
import org.homey.domain.FreePdtVO;



public interface FreePdtMapper {
	
	// 제품 나눔 게시글 관련 맵퍼 (페이징O, 이미지 첨부는 한 장까지 가능)
	
	//페이징
	public int fpTotalCount(SoCriteria cri);								//제품 나눔 게시글 개수
	public List<FreePdtVO> fpSelectAllPaging(SoCriteria cri);	//제품 나눔 게시글 전체조회 , SoCriteria에는 amount, pageNum, searchOpt, searchKywd 들어있음
	
//	public List<FreePdtVO> fpSelectAll();						//제품 나눔 게시글 전체조회 (페이징X)
	public FreePdtVO fpSelect(int fpNo);						//제품 나눔 게시글 상세조회
	public int fpInsert(FreePdtVO fpvo);				//제품 나눔 게시글 등록
	public int fpDelete(int fpNo);						//제품 나눔 게시글 삭제
	public int fpUpdate(FreePdtVO fpvo);				//제품 나눔 게시글 수정

	public int plusNowPeople(int fpNo);				//'현재 신청자 수' 증가 (신청하기에서 Register할 때 @transaction 사용)
}
