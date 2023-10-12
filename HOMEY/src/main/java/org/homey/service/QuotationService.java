package org.homey.service;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.QuotationVO;



public interface QuotationService {

    public boolean register(QuotationVO qvo); // 견적서 등록
    public QuotationVO view(int quoNo); // 견적서 조회
    public boolean modify(QuotationVO qvo); // 견적서 수정
    public boolean remove(int quoNo); // 견적서 삭제
	
	
	//서비스를 구현하는 서비스imple클래스를 만들기
	//스프링에서 관리하는 bean으로 추가
}
