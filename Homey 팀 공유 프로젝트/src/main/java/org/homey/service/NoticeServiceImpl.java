package org.homey.service;

import java.util.List;

import org.homey.domain.Criteria;
import org.homey.domain.NoticeVO;
import org.homey.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service					//spring에서 관리하는 요소인데 service니까 service 붙임
@Log4j						//만약 로그기록하고싶다면 log4j
public class NoticeServiceImpl implements NoticeService {
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper noticeMapper;

	@Override
	public boolean register(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<NoticeVO> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeVO view(int notNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<NoticeVO> list(Criteria cri) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modify(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(int notNo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int totalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void noticeHit(int notNo) {
		// TODO Auto-generated method stub

	}

}
