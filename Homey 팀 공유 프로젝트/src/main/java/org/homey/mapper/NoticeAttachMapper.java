package org.homey.mapper;

import java.util.List;

import org.homey.domain.NoticeAttachVO;

public interface NoticeAttachMapper {

	public void insert(NoticeAttachVO nvo);		
	public List<NoticeAttachVO> select(int notNo);
	public void delete(String uuid);			
	public void deleteAll(int notNo);
	
}
