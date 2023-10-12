package org.homey.mapper;

import java.util.List;

import org.homey.domain.NoticeVO;

public interface NoticeAttachMapper {

	public void insert(NoticeVO nvo);		//void
	public List<NoticeVO> select(int notNo);
	public void delete(String uuid);			//만약에 확인값 받고싶으면 int하지만 아님 말음 //void
	public void deleteAll(int notNo);			//만약에 확인값 받고싶으면 int하지만 아님 말음 //void
	
}
