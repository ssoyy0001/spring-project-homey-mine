package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.OdReqVO;


public interface OdReqMapper {

	// 원데이클래스 신청 관련 맵퍼
	
	public List<OdReqVO> odReqSelectAll(int odNo);				//원데이클래스 신청목록 전체조회 -> "특정 클래스"(odNo)의 전체신청목록
	public List<OdReqVO> odReqSelectMine(String mid);			//나의 원데이클래스 신청목록 조회
	
	public OdReqVO odReqSelect(int odReqNo);						//원데이클래스 신청서 상세조회
	public int odReqInsert(OdReqVO odrvo);							//원데이클래스 신청
	public int odReqDelete(int odReqNo);								//원데이클래스 신청 취소
	public int odReqWin(@Param("odReqNo")int odReqNo);		//원데이클래스 당첨자 선정 (odReqNo의 '당첨여부' 컬럼을 1로 변경)
	public int odReqWinX(@Param("odReqNo")int odReqNo);	//원데이클래스 당첨취소 (odReqNo의 '당첨여부' 컬럼을 0으로 변경)
	public List<OdReqVO> odWinSelect(int odNo);					//원데이클래스 당첨자 목록 -> 클래스번호(odNo) && 당첨여부가 1 의 전체신청목록
	
	public int doubleCheck(@Param("odNo")int odNo, @Param("mid")String mid);			//원데이클래스 신청 중복체크

}


