package org.homey.service;

import java.util.List;

import org.homey.domain.SiScheduleVO;
import org.homey.mapper.SiScheduleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class SiScheduleServiceImpl implements SiScheduleService {
	@Setter(onMethod_ = @Autowired)
	private SiScheduleMapper sicheMapper;
	@Override
	public List<SiScheduleVO> sicheList() {
		return sicheMapper.sicheList();
	}
	@Override
	public SiScheduleVO sicheView(int sicheNo) {
		return sicheMapper.sicheView(sicheNo);
	}
	@Override
	public boolean sicheModify(SiScheduleVO sicheVO) {
		return sicheMapper.sicheUpdate(sicheVO)==1;
	}
	@Override
	public List<SiScheduleVO> checkDate(String workCrew) {
		return sicheMapper.checkDate(workCrew);
	}
	@Override
	public boolean sicheRegister(SiScheduleVO sicheVO) {
		return sicheMapper.sicheInsert(sicheVO)==1;
	}
	@Override
	public boolean sicheRemove(int sicheNo) {	
		return sicheMapper.sicheDelete(sicheNo)==1;
	}
	@Override
	public List<SiScheduleVO> sicheMyList(String mid) {
		return sicheMapper.sicheMyList(mid);
	}

}
