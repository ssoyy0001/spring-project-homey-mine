package org.homey.mapper;


import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;


public interface QuotationMapper {
	public int insert(QuotationVO qvo); // 견적서 등록
	public int updateItem(ItemVO ivo); // 견적서 등록과 수정 시 동시에 item테이블의 값 업데이트
    public QuotationVO select(int quoNo); // 견적서 조회 - 견적서 번호
    public int update(QuotationVO qvo); // 견적서 수정
    public int delete(int quoNo); // 견적서 삭제
    public ItemVO selectItem(int consultNo); //등록된 시공항목 및 철거항목 조회
}
