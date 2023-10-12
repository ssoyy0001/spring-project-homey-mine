package org.homey.service;

import java.util.List;

import org.homey.domain.VisitVO;
import org.homey.mapper.NoticeMapper;
import org.homey.mapper.VisitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service					//spring에서 관리하는 요소인데 service니까 service 붙임
@Log4j						//만약 로그기록하고싶다면 log4j
public class VisitServiceImpl implements VisitService {

	@Setter(onMethod_ = @Autowired)
	private VisitMapper visitMapper;
	
	@Override
	public boolean register(VisitVO vvo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public VisitVO view(int visitNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modify(VisitVO vvo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(int visitNo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<VisitVO> listByConsultNo(int consultNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
