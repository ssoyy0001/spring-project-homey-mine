package org.homey.service;

import org.homey.domain.ItemVO;
import org.homey.mapper.ConsultMapper;
import org.homey.mapper.ItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service					//spring에서 관리하는 요소인데 service니까 service 붙임
@Log4j						//만약 로그기록하고싶다면 log4j
public class ItemServiceImpl implements ItemService {

	@Setter(onMethod_ = @Autowired)
	private ItemMapper itemMapper;
	
	@Override
	public boolean register(ItemVO ivo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ItemVO view(int consultNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modify(ItemVO ivo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(int consultNo) {
		// TODO Auto-generated method stub
		return false;
	}

}
