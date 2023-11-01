package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.ScCriteria;
import org.homey.domain.ShowcaseVO;

public interface ShowcaseMapper {
	public List<ShowcaseVO> selectAllPaging(ScCriteria cri);
	public ShowcaseVO select(int scid);
	public int insert(ShowcaseVO scvo);
	public int update(ShowcaseVO scvo);
	public int delete(int scid);
	public int totalCnt(ScCriteria cir);//페이징을 위한 게시물 총 개수
	
}
