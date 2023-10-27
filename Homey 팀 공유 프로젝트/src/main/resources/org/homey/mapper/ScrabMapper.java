package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.ScCriteria;
import org.homey.domain.ShowcaseVO;

public interface ScrabMapper {
	public int myScrabCnt(String mid);//나의 스크랩 총 개수 페이징에서 쓰일듯?
	public int addScrab(@Param("scid")int scid,@Param("mid") String mid);
	public int removeScrab(@Param("scid")int scid,@Param("mid")String mid);
	public List<ShowcaseVO> myScrabSelectAll(@Param("mid") String mid,@Param("cri") ScCriteria cri);//나의 스크랩 목록
	public int isScrab(@Param("scid") int scid,@Param("mid") String mid);//스크랩했는지 안했는지
	public int scScrabCnt(int scid);//->한 게시물 스크랩 총개수
	public int updateScrabCnt(@Param("scid") int scid,@Param("scrabCnt") int scrabCnt);
}
