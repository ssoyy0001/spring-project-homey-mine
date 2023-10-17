package org.homey.mapper;

import java.util.List;

import org.homey.domain.ConsultVO;
import org.homey.domain.Criteria;
import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.domain.VisitVO;

public interface QuotationMapper {
    
    public int insert(QuotationVO qvo); // 견적서 등록
    public QuotationVO select(int quoNo); // 견적서 조회
    public int update(QuotationVO qvo); // 견적서 수정
    public int delete(int quoNo); // 견적서 삭제
    
    // 아이템 목록 조회
    public List<ItemVO> getItemsByConsultNo(int consultNo);
}
