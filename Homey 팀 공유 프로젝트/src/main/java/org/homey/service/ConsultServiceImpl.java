package org.homey.service;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.ItemVO;
import org.homey.mapper.ConsultMapper;
import org.homey.mapper.QuotationMapper;
import org.homey.mapper.VisitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service					//spring에서 관리하는 service, root-context.xml에 등록되는지 확인
@Log4j						//로그기록을 위한 어노테이션
public class ConsultServiceImpl implements ConsultService {
	@Setter(onMethod_ = @Autowired)
	private ConsultMapper consultMapper;
	@Setter(onMethod_ = @Autowired)
	private QuotationMapper quotationMapper;
	@Setter(onMethod_ = @Autowired)
	private VisitMapper visitMapper;
	
	//견적 상담 등록 및 시공항목 등록
	@Override
    public int register(ConsultVO cvo, ItemVO ivo) {
        // ConsultVO 등록
        int result = consultMapper.insert(cvo);

        if (result > 0) {
            // ConsultVO 등록에 성공한 경우 consultNo를 얻어옴
            int consultNo = cvo.getConsultNo();

            // 그 후 ItemVO에 consultNo 설정
            ivo.setConsultNo(consultNo);

            // item 테이블에 데이터 등록
            int itemResult = consultMapper.insertItem(ivo);
            if (itemResult == 1) { //성공하면 true 반환
                return consultNo;
            }
        }
        return -1;
    }

	//견적 상담 전체목록 조회 + 페이징 - 완
	@Override
	public List<ConsultVO> list(Criteria cri) {
		log.info("견적 상담 list ServiceImpl...");
		return consultMapper.selectAllPaging(cri);
	}
	
	// 나의 견적상담 전체 목록 조회 + 페이징 - 완
	@Override
	public List<ConsultVO> myList(String mid) {
		log.info("나의 견적 상담 list ServiceImpl...");
		return consultMapper.selectAllMe(mid);
	}
	
	//견적 상담 상세 조회 - 완
	@Override
	public ConsultVO view(int consultNo) {
		log.info("견적 상담 view ServiceImpl...");
	    //ConsultMapper를 사용하여 ConsultVO와 관련된 정보를 조회한 후, 조회된 정보를 ConsultVO 객체에 담고, ItemVO, QuotationVO, VisitVO의 정보를 적절한 필드에 할당
	    return consultMapper.select(consultNo);
	}
	
	
	//견적 상담 수정 - 완
	@Override
	public boolean modify(ConsultVO cvo) {
		log.info("견적 상담 modify ServiceImpl...");
		return consultMapper.update(cvo) == 1;
	}

	//견적상담 삭제 - 완
	@Override
	public boolean remove(int consultNo) {
		log.info("견적 상담 remove ServiceImpl...");
		return consultMapper.delete(consultNo) == 1;
	}

	//견적상담 개수 조회 - 완
	@Override
	public int totalCount(Criteria cri) {
		log.info("견적 상담 totalCount ServiceImpl...");
		return consultMapper.totalCount(cri);
	}

	
}
