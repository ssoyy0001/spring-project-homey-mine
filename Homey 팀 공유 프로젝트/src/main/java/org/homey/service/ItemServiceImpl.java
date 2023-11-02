package org.homey.service;

import org.homey.domain.ItemVO;
import org.homey.mapper.ItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service					
@Log4j						
public class ItemServiceImpl implements ItemService {

	@Setter(onMethod_ = @Autowired)
	private ItemMapper itemMapper;
	
	@Override
	public void register(ItemVO ivo) {
		 itemMapper.insert(ivo);
	}

	@Override
	public ItemVO view(int consultNo) {
		return itemMapper.select(consultNo);
	}

	@Override
	public boolean modify(ItemVO ivo) {
	      int updated = itemMapper.update(ivo);
	      return updated > 0;
	}

	@Override
	public boolean remove(int consultNo) {
        int deleted = itemMapper.delete(consultNo);
        return deleted > 0;
	}

}
