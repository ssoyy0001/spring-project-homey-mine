package org.homey.service;

import org.homey.domain.ItemVO;

public interface ItemService {

    public void register(ItemVO ivo);
    public ItemVO view(int consultNo); 
    public boolean modify(ItemVO ivo); 
    public boolean remove(int consultNo); 
	
}
