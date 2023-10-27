package org.homey.service;

import java.util.List;

import org.homey.domain.ScCriteria;
import org.homey.domain.ShowcaseAttachVO;
import org.homey.domain.ShowcaseVO;

public interface ShowcaseService {
	public List<ShowcaseVO> list(ScCriteria cri);
	public int totalCount(ScCriteria cri);
	public List<ShowcaseAttachVO> attachList(int scid);
	public boolean modify(ShowcaseVO scvo);
	public boolean remove(int scid);
	public boolean register(ShowcaseVO scvo);
	
	public ShowcaseVO view(int scid);
	
}
