package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.FPReqVO;


public interface FpReqMapper {
	
	// 제품 나눔 신청 관련 맵퍼 					
	
	public List<FPReqVO> fpWinSelect(int fpNo);			//제품 나눔 당첨자 목록조회 -> 특정 제품 나눔 게시글의 전체 신청목록
	public List<FPReqVO> fpWinSelectAll();						//제품 나눔 당첨자 목록조회 -> 모든 제품 나눔 게시글의 전체 신청목록 ( 나의 제품 나눔 신청 목록조회 시 필요 )
	public List<FPReqVO> fpSelectMine(String mid);		//나의 제품 나눔 신청 목록조회
	public int fpReqInsert(FPReqVO fprvo);					//제품 나눔 신청
	public int fpReqCheck(@Param("fpNo")int fpNo, @Param("mid")String mid);			//제품 나눔 신청 중복체크
	
	
	//궁금증! "나의 제품 나눔 신청목록 조회"에서,
	//화면에 표시할 내용이 <제품 나눔 신청 DB> , < 제품 나눔 게시글 DB > 에 있음. ex) 모집현황, 수령일, 게시글제목
	//그러면 조인하는 해당 쿼리문은 fpSelectMine 에 작성하면 되는거지?
	//A. 예스
		
	//-> 근데 그러면 return값으로 같이 들고 온 <게시글DB>의 내용은 ReqVO에 들어가지질 않는데 어떡해?
	//A. 그래서 FreePdtVO에 Req 리스트를 뒀음! Mapper.xml 작성할 때 MemberMapper 참고해서 join 활용해야 함! ( resultMap, ... )
}

