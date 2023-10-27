package org.homey.service;

import java.util.List;

import org.homey.domain.ScCriteria;
import org.homey.domain.ShowcaseVO;

public interface ScrabService {
	public List<ShowcaseVO> scrabList(String mid,ScCriteria cri);
	public int myscrabTotalCnt(String mid);//나의 스크랩 개수
	public int scScrabCnt(int scid);//게시물의 스크랩수 
	public boolean addScrab(int scid,String mid);
	public boolean removeScrab(int scid,String mid);
	public boolean isScrab( int scid,String mid);//스크랩했는지 안했는지
	public boolean updateScrabCnt(int scid,int scrabCnt);
}
