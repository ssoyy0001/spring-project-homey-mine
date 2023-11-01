package org.homey.service;

import java.util.List;

import org.homey.domain.SiScheduleVO;

public interface SiScheduleService {
	public List<SiScheduleVO> sicheList();
	public List<SiScheduleVO> sicheMyList(String mid);
	public SiScheduleVO sicheView(int sicheNo);
	public boolean sicheModify(SiScheduleVO sicheVO); 
	public List<SiScheduleVO> checkDate(String workCrew);
	public boolean sicheRegister(SiScheduleVO sicheVO);
	public boolean sicheRemove(int sicheNo);
}
