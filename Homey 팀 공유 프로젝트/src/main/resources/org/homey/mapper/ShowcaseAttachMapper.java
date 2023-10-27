package org.homey.mapper;

import java.util.List;

import org.homey.domain.ShowcaseAttachVO;

public interface ShowcaseAttachMapper {
	public void delete(String uuid);
	public void insert(ShowcaseAttachVO scavo);
	public List<ShowcaseAttachVO> select(int scid);
	public int deleteAll(int scid);
}






