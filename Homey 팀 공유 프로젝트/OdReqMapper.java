package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.OdReqVO;


public interface OdReqMapper {

	// 원데이클래스 신청 관련 맵퍼
	
//	public int odTotalCount(Criteria cri);							//원데이클래스 게시글 개수 -> 페이징 안해서 지움
	public List<OdReqVO> odReqSelectAll(int odNo);		//원데이클래스 신청목록 전체조회 -> "특정 클래스"(odNo)의 전체신청목록
	public List<OdReqVO> odReqSelectMine(String mid);	//나의 원데이클래스 신청목록 조회 -> sid가 신청한 신청목록을 "신청일" 기준 최근 15개까지 조회하기	
	
	public OdReqVO odReqSelect(int odReqNo);			//원데이클래스 신청 상세조회
	public int odReqInsert(OdReqVO odrvo);				//원데이클래스 신청
	public int odReqDelete(int odReqNo);					//원데이클래스 신청 철회
	public int odReqWin(@Param("odReqNo")int odReqNo);						//원데이클래스 당첨자 선정 (odReqNo의 '당첨여부' 컬럼을 1로 변경)
	public int odReqWinX(@Param("odReqNo")int odReqNo);						//원데이클래스 당첨취소 (odReqNo의 '당첨여부' 컬럼을 0으로 변경)
	public List<OdReqVO> odWinSelect(int odNo);		//원데이클래스 당첨자 목록 -> 클래스번호(odNo) && 당첨여부가 1 의 전체신청목록
	
	public int doubleCheck(@Param("odNo")int odNo, @Param("mid")String mid);			//원데이클래스 신청 중복체크
	
	//궁금증! "나의 원데이클래스 신청목록 조회"에서,
	//화면에 표시할 내용이 <원데이클래스 신청 DB> , < 원데이클래스 게시글 DB > 에 있음.
	//그러면 해당 쿼리문은 odReqSelectMine 에 작성하면 되는거지? 
	//=> YES!<원데이클래스 신청 DB>에서만 가져오면 됨. 신청DB에서 가져온 odNo로 컨트롤러(혹은 서비스단)에서 onedayMapper.select(odNo)로 가져오면 됨.
	
	//-> 근데 그러면 return값으로 같이 들고 온 <게시글DB>의 내용은 ReqVO에 들어가지질 않는데 어떡해?
	//A. 그래서 OnedayVO에 Req 리스트를 둠. 이제 Mapper.xml 작성할 때 resultMap같은 거 써서 join해야 함. MemberMapper 참고!

	
	//방법1. mapper.xml에서는 <신청DB>만 가져오고, 컨트롤러에서 가져온 걸 뿌린다. => view.jsp 코드에서 forEach같은 게 많아짐.
	//방법2. OnedayReqVO에 OnedayVO 리스트를 추가하고, mapper.xml에서 resultMap을 사용한다. => mapper.xml 양이 많아지지만, view.jsp에서는 양이 적어짐
	//=> 이렇게 하려면, OnedayReqVO에 OnedayVO / MemberVO 추가해야 함. 당첨자 목록 띄울 땐 개인정보도 나와야 하거든. 
}


