package org.homey.service;

import java.util.List;

import org.homey.domain.ScCriteria;
import org.homey.domain.ShowcaseVO;
import org.homey.mapper.ScrabMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
@Service
public class ScrabServiceImpl implements ScrabService {
	@Setter(onMethod_ = @Autowired)
	private ScrabMapper scrabMapper;
	@Override
	public List<ShowcaseVO> scrabList(String mid,ScCriteria cri) {
		return scrabMapper.myScrabSelectAll(mid, cri);
	}

	@Override
	public int myscrabTotalCnt(String mid) {
		return scrabMapper.myScrabCnt(mid);
	}

	@Override
	public boolean addScrab(int scid, String mid) {
		return scrabMapper.addScrab(scid, mid)==1;
	}

	@Override
	public boolean removeScrab(int scid, String mid) {
		return scrabMapper.removeScrab(scid, mid)==1;
	}

	@Override
	public boolean isScrab(int scid, String mid) {
		return scrabMapper.isScrab(scid, mid)==1;
	}

	@Override
	public int scScrabCnt(int scid) {
		return scrabMapper.scScrabCnt(scid);
	}

	@Override
	public boolean updateScrabCnt(int scid, int scrabCnt) {
		return scrabMapper.updateScrabCnt(scid, scrabCnt)==1;
	}

}
