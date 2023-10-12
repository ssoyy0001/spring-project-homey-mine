package org.homey.service;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.VisitVO;

public interface VisitService {
	
    public boolean register(VisitVO vvo);
    public VisitVO view(int visitNo);
    public boolean modify(VisitVO vvo);
    public boolean remove(int visitNo);
    public List<VisitVO> listByConsultNo(int consultNo);
    
	//서비스를 구현하는 서비스imple클래스를 만들기
	//스프링에서 관리하는 bean으로 추가
}
