package org.homey.service;


import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;

public interface QuotationService {
    public boolean register(QuotationVO qvo, ItemVO ivo); // 견적서 등록 및 시공과 철거항목 업데이트
    public QuotationVO view(int quoNo); // 견적서 조회
    public boolean modify(QuotationVO qvo, ItemVO ivo);// 견적서 등록 및 수정과 철거항목 업데이트
    public boolean remove(int quoNo); // 견적서 삭제
    public ItemVO selectItem(int consultNo); // 시공 및 철거항목 조회

}
