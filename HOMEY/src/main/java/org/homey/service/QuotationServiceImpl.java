package org.homey.service;

import org.homey.domain.QuotationVO;
import org.homey.mapper.NoticeMapper;
import org.homey.mapper.QuotationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service					//spring에서 관리하는 요소인데 service니까 service 붙임
@Log4j						//만약 로그기록하고싶다면 log4j
public class QuotationServiceImpl implements QuotationService {
	
	@Setter(onMethod_ = @Autowired)
	private QuotationMapper quotationMapper;

	@Override
	public boolean register(QuotationVO qvo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public QuotationVO view(int quoNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modify(QuotationVO qvo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(int quoNo) {
		// TODO Auto-generated method stub
		return false;
	}

}
