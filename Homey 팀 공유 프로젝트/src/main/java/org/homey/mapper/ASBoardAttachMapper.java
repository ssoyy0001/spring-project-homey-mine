package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.ASBoardAttachVO;
import org.homey.domain.ASBoardVO;
import org.homey.domain.asCriteria;

public interface ASBoardAttachMapper {
	public void deleteAll(int bno);
	public void delete(String uuid);
	public void insert(ASBoardAttachVO bavo);
	public List<ASBoardAttachVO> select(int bno);
}






