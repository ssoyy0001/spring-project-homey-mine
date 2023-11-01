package org.homey.mapper;

import java.util.List;

import org.homey.domain.SoCriteria;
import org.homey.domain.OnedayVO;


public interface OnedayMapper {

	// 원데이클래스 게시글 관련 맵퍼 (이미지 첨부는 한 장까지 가능)
	
	//페이징
	public int odTotalCount(SoCriteria cri);								//원데이클래스 게시글 개수
	public List<OnedayVO> odSelectAllPaging(SoCriteria cri);	//원데이클래스 게시글 전체조회
	public OnedayVO odSelect(int odNo);									//원데이클래스 게시글 상세조회
	public int odInsert(OnedayVO odvo);									//원데이클래스 게시글 등록
	public int odDelete(int odNo);											//원데이클래스 게시글 삭제
	public int odUpdate(OnedayVO odvo);								//원데이클래스 게시글 수정
	
}
