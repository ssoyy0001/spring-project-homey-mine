package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.SoCriteria;
import org.homey.domain.OnedayVO;


public interface OnedayMapper {

	// 원데이클래스 게시글 관련 맵퍼 (이미지 첨부는 한 장까지 가능)
	
	//페이징
	public int odTotalCount(SoCriteria cri);									//원데이클래스 게시글 개수
	public List<OnedayVO> odSelectAllPaging(SoCriteria cri);		//원데이클래스 게시글 전체조회 , SoCriteria에는 amount, pageNum, searchOpt, searchKywd 들어있음

	public List<OnedayVO> odSelectAll(@Param("mid")String mid);					//내가 신청한 원데이클래스 게시글 전체조회 : "마이페이지 - 나의 클래스 신청내역" 시 필요 (OnedayController 확인)
	public OnedayVO odSelect(int odNo);									//원데이클래스 게시글 상세조회
	public int odInsert(OnedayVO odvo);									//원데이클래스 게시글 등록
	public int odDelete(int odNo);											//원데이클래스 게시글 삭제
	public int odUpdate(OnedayVO odvo);								//원데이클래스 게시글 수정
	
}
