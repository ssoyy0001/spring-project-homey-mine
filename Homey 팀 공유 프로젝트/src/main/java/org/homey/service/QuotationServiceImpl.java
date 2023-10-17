package org.homey.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
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

	//견적서 등록 - 완
	@Override
	public boolean register(QuotationVO qvo) {
		log.info("견적서 register ServiceImpl...");
		return quotationMapper.insert(qvo) == 1;
	}

	//견적서 조회 - 완
	@Override
	public QuotationVO view(int quoNo) {
		log.info("견적서 view ServiceImpl...");
		return quotationMapper.select(quoNo);
	}

	//견적서 수정 - 완
	@Override
	public boolean modify(QuotationVO qvo) {
		log.info("견적서 modify ServiceImpl...");
		// TODO Auto-generated method stub
		return quotationMapper.update(qvo) == 1;
	}

	//견적서 삭제 - 완
	@Override
	public boolean remove(int quoNo) {
		log.info("견적서 remove ServiceImpl...");
		return quotationMapper.delete(quoNo) == 1;
	}

	//일단 어떻게 쓰이는지 모르는데 - 완
    @Override
    public List<ItemVO> getItemsByConsultNo(int consultNo) {
    	log.info("견적서 getItemsByConsultNo ServiceImpl...");
    	return quotationMapper.getItemsByConsultNo(consultNo);
    }

}
