package org.homey.mapper;

import java.util.List;

import org.homey.domain.SoCriteria;
import org.homey.domain.FreePdtVO;



public interface FreePdtMapper {
	
	// 제품 나눔 게시글 관련 맵퍼
	
	//페이징
	public int fpTotalCount(SoCriteria socri);								//제품 나눔 게시글 개수
	public List<FreePdtVO> fpSelectAllPaging(SoCriteria socri);	//제품 나눔 게시글 전체조회
	
	public FreePdtVO fpSelect(int fpNo);									//제품 나눔 게시글 상세조회
	public int fpInsert(FreePdtVO fpvo);									//제품 나눔 게시글 등록
	public int fpDelete(int fpNo);											//제품 나눔 게시글 삭제
	public int fpUpdate(FreePdtVO fpvo);									//제품 나눔 게시글 수정

	public int plusNowPeople(int fpNo);									//'현재 신청자 수' 증가
}
