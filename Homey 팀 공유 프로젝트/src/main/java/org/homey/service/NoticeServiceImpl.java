package org.homey.service;

import java.util.List;

import org.homey.domain.Criteria;
import org.homey.domain.NoticeAttachVO;
import org.homey.domain.NoticeVO;
import org.homey.mapper.NoticeAttachMapper;
import org.homey.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service 
@Log4j 
public class NoticeServiceImpl implements NoticeService {
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper noticeMapper;
	@Setter(onMethod_ = @Autowired)
	private NoticeAttachMapper naMapper;

	@Transactional
	@Override
	public boolean register(NoticeVO nvo) {
		boolean result = noticeMapper.insertSelectKey(nvo) == 1;

		if (nvo.getAttachList() != null && nvo.getAttachList().size() > 0) {
			nvo.getAttachList().forEach(navo -> {
				navo.setNotNo(nvo.getNotNo());
				naMapper.insert(navo);
			});
		}
		return result;
	}

	@Override
	public NoticeVO view(int notNo) {
		NoticeVO notice = noticeMapper.select(notNo);
		noticeMapper.noticeHit(notNo); // 조회수 증가
		return notice;
	}

	@Override
	public List<NoticeVO> list(Criteria cri) {
		return noticeMapper.selectAllPaging(cri);
	}

	@Transactional
	@Override
	public boolean modify(NoticeVO nvo) {

		naMapper.deleteAll(nvo.getNotNo());

		boolean result = noticeMapper.update(nvo) == 1;

		noticeMapper.update(nvo);
		if (nvo.getAttachList() != null && nvo.getAttachList().size() > 0) {
			nvo.getAttachList().forEach(navo -> {
				navo.setNotNo(nvo.getNotNo());
				naMapper.insert(navo);
			});
		}
		return result;
	}

	@Transactional
	@Override
	public boolean remove(int notNo) {
		naMapper.deleteAll(notNo);
		return noticeMapper.delete(notNo) == 1;
	}

	@Override
	public int totalCount(Criteria cri) {
		return noticeMapper.totalCount(cri);
	}

	@Override
	public List<NoticeAttachVO> attachList(int notNo) {
		return naMapper.select(notNo);
	}

}
