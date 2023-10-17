package org.homey.service;

import java.util.List;

import org.homey.domain.Criteria;
import org.homey.domain.ItemVO;
import org.homey.domain.NoticeVO;



public interface ItemService {

    public boolean register(ItemVO ivo); 
    public ItemVO view(int consultNo); 
    public boolean modify(ItemVO ivo); 
    public boolean remove(int consultNo); 
	
	//서비스를 구현하는 서비스imple클래스를 만들기
	//스프링에서 관리하는 bean으로 추가
}
