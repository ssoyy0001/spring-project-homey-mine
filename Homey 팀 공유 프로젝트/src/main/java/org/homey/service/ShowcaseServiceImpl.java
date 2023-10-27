package org.homey.service;

import java.util.List;

import org.homey.domain.ScCriteria;
import org.homey.domain.ShowcaseAttachVO;
import org.homey.domain.ShowcaseVO;
import org.homey.mapper.ShowcaseAttachMapper;
import org.homey.mapper.ShowcaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
public class ShowcaseServiceImpl implements ShowcaseService {
	@Setter(onMethod_ = @Autowired)
	private ShowcaseAttachMapper showcaseAttachMapper;
	@Setter(onMethod_ = @Autowired)
	private ShowcaseMapper showcaseMapper;
	private boolean result;
	@Override
	public List<ShowcaseVO> list(ScCriteria cri) {
		log.info("service:"+cri);
		return showcaseMapper.selectAllPaging(cri);
	}

	@Override
	public int totalCount(ScCriteria cri) {
		return showcaseMapper.totalCnt(cri);
	}
	@Transactional
	@Override
	public boolean modify(ShowcaseVO scvo) {
		showcaseAttachMapper.deleteAll(scvo.getScid());
		result=showcaseMapper.update(scvo)==1;
		if(scvo.getAttachList() != null && scvo.getAttachList().size()>0) {
			scvo.getAttachList().forEach(scavo->{
				scavo.setScid(scvo.getScid());
				showcaseAttachMapper.insert(scavo);
			});
		}
		return result;
	}

	@Override
	public boolean remove(int scid) {
		showcaseAttachMapper.deleteAll(scid);
		return showcaseMapper.delete(scid)==1;
	}
	
	@Transactional
	@Override
	public boolean register(ShowcaseVO scvo) {
		result= showcaseMapper.insert(scvo)==1;
		if(scvo.getAttachList() != null && scvo.getAttachList().size()>0) {
			scvo.getAttachList().forEach(scavo->{
				scavo.setScid(scvo.getScid());
				showcaseAttachMapper.insert(scavo);
			});
		}
		return result;
	}

	@Override
	public ShowcaseVO view(int scid) {
		return showcaseMapper.select(scid);
	}

	@Override
	public List<ShowcaseAttachVO> attachList(int scid) {
		return showcaseAttachMapper.select(scid);
	}


}
