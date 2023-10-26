package org.homey.service;

import java.util.List;

import org.homey.domain.OdReqVO;


public interface OdReqService {

	//원데이클래스 신청 관련 서비스단
	
	//DB보다는 고객들과 더 가깝기 때문에 Mapper인터페이스에 비해 명칭이 달라짐
	//반환형도 boolean으로 바꿈
	
	//페이징
//	public int odTotalCount(Criteria cri);							//원데이클래스 게시글 개수 -> 페이징 안해서 지움
	public List<OdReqVO> odReqList(int odNo);				//원데이클래스 신청목록 전체조회 -> "특정 클래스"(odNo)의 전체신청목록
	public List<OdReqVO> odReqListMine(String mid);		//나의 원데이클래스 신청목록 조회 -> sid가 신청한 신청목록을 "신청일" 기준 최근 15개까지 조회하기	
	public OdReqVO odReqView(int odReqNo);					//원데이클래스 신청 상세조회
	public boolean odReqRegister(OdReqVO odrvo);			//원데이클래스 신청
	public boolean odReqRemove(int odReqNo);				//원데이클래스 신청 철회
	
	public boolean odReqWin(int odReqNo);					//원데이클래스 당첨자 선정 (odReqNo의 '당첨여부' 컬럼을 1로 변경)
	public boolean odReqWinX(int odReqNo);					//원데이클래스 당첨취소 (odReqNo의 '당첨여부' 컬럼을 0으로 변경)
	public List<OdReqVO> odWinList(int odNo);				//원데이클래스 당첨자 목록 -> 클래스번호(odNo) && 당첨여부가 1 의 전체신청목록
	
	public int doubleCheck(int odNo, String mid);			//원데이클래스 신청 중복체크
	
	
}
