package org.homey.service;

import java.util.HashMap;
import java.util.Map;

import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.mapper.ItemMapper;
import org.homey.mapper.QuotationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class QuotationServiceImpl implements QuotationService {

	@Setter(onMethod_ = @Autowired)
	private QuotationMapper quotationMapper;
	@Setter(onMethod_ = @Autowired)
	private ItemMapper itemMapper;

	@Override
	public boolean register(QuotationVO qvo, ItemVO ivo) throws Exception {
		log.info("견적서 register ServiceImpl...");

		if (checkDate(qvo, 0)) {
			// 겹치는 시공일정이 있을 경우, 예외를 발생
			throw new Exception("새로운 시공일정이 기존의 시공일정과 겹칩니다.");
		}

		// QuotationVO 등록
		int result = quotationMapper.insert(qvo);

		if (result > 0) {
			// QuotationVO 등록에 성공한 경우 consultNo를 얻어옴
			int consultNo = qvo.getConsultNo();

			// 그 후 ItemVO에 consultNo 설정
			ivo.setConsultNo(consultNo);

			// item 테이블에 데이터 업데이트
			int itemResult = quotationMapper.updateItem(ivo);
			if (itemResult == 1) { // 성공하면 true 반환
				return true;
			}
		}
		return false; // 등록에 실패한 경우 false 반환
	}

	// 견적서 조회 - 완
	@Override
	public QuotationVO view(int quoNo) {
		log.info("견적서 view ServiceImpl...");
		// quotationMapper를 사용하여 QuotationVO와 관련된 정보를 조회한 후, 조회된 정보를 QuotationVO 객체에 담고,
		// ItemVO, ConsultVO의 정보를 적절한 필드에 할당
		return quotationMapper.select(quoNo);
	}

	// 견적서 수정 - 완
	@Override
	public boolean modify(QuotationVO qvo, ItemVO ivo) throws Exception {
		log.info("견적서 modify ServiceImpl...");

		if (checkDate(qvo, qvo.getQuoNo())) { // checkDate에 견적서 번호를 전달
			// 겹치는 시공일정이 있을 경우, 예외를 발생
			throw new Exception("새로운 시공일정이 기존의 시공일정과 겹칩니다.");
		}

		int result = quotationMapper.update(qvo);

		if (result > 0) {
			// QuotationVO 수정에 성공한 경우 consultNo를 얻어옴
			int consultNo = qvo.getConsultNo();

			// 그 후 ItemVO에 consultNo 설정
			ivo.setConsultNo(consultNo);

			// item 테이블에 데이터 업데이트
			int itemResult = quotationMapper.updateItem(ivo);
			if (itemResult == 1) { // 성공하면 true 반환
				return true;
			}
		}
		return false; // 등록에 실패한 경우 false 반환
	}

	// 견적서 삭제
	@Override
	public boolean remove(int quoNo) {
		log.info("견적서 remove ServiceImpl...");
		return quotationMapper.delete(quoNo) == 1;
	}

	@Override
	public ItemVO selectItem(int consultNo) {
		return quotationMapper.selectItem(consultNo);
	}

	@Override
	public boolean checkDate(QuotationVO qvo, int quoNo) throws Exception {
		// java.util.Date 형식을 java.sql.Date 형식으로 변환
		java.sql.Date sqlStartDate = new java.sql.Date(qvo.getConstScheduleStart().getTime());
		java.sql.Date sqlEndDate = new java.sql.Date(qvo.getConstScheduleEnd().getTime());

		// SQL 쿼리에 바인딩할 매개변수를 준비
		Map<String, Object> params = new HashMap<>();
		params.put("sqlStartDate", sqlStartDate);
		params.put("sqlEndDate", sqlEndDate);
		params.put("quoNo", quoNo);

		// SQL 쿼리 실행
		int overlaps = quotationMapper.checkDate(params);

		return overlaps > 2; // 최대 3개 일정까지 중복 가능
//	    return overlaps > 0;
	}

}
