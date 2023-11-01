package org.homey.mapper;

import java.util.List;

import org.homey.domain.SiScheduleVO;

public interface SiScheduleMapper {
	public List<SiScheduleVO> sicheList();
	public List<SiScheduleVO> sicheMyList(String mid);
	public SiScheduleVO sicheView(int sicheNo);
	public int sicheInsert(SiScheduleVO sicheVO);
	public int sicheUpdate(SiScheduleVO sicheVO);
	public List<SiScheduleVO> checkDate(String workCrew);
	public int sicheDelete (int sicheNo);
}
