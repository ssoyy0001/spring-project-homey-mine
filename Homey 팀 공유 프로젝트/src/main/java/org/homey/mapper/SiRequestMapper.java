package org.homey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.domain.SiRequestVO;
import org.homey.domain.SireqCriteria;

public interface SiRequestMapper {
	
	public List<SiRequestVO> getListWithPaging(SireqCriteria cri); //시공의뢰 전체목록 + 페이징
	public int totalCount(SireqCriteria cri); //시공의뢰 전체 수
	
//	public List<SiRequestVO> getList(); //시공의뢰 전체목록
	
	public void insert(SiRequestVO sireq); //시공의뢰 등록(insert만 처리)		
	public int insertSelectkey(SiRequestVO sireq); //시공의뢰 등록(insert 실행 후 생성된 PK값을 알아야 하는 경우)
	public int updateQuotationTable(QuotationVO qvo);//시공의뢰 등록시 견적서항목 업데이트
	public int updateItem(ItemVO ivo);//시공의뢰 등록시 아이템 항목 업데이트
	
	public SiRequestVO read(int sireqNo); //시공의뢰 상세조회
	
	public int delete(int sireqNo); //시공의뢰 삭제
	
	public int update(@Param("sireqNo") int sireqNo, @Param("sireq") SiRequestVO sireq); //시공의뢰 수정
//	public int update(@Param("sireqNo") int sireqNo, 
//			@Param("sireq") SiRequestVO sireq,  
//			@Param("quoNo") int quoNo,  
//			@Param("itemNo") int itemNo,  
//			@Param("consultNo") int consultNo,  
//			@Param("mid") String mid,  
//			@Param("mname") String mname); //시공의뢰 수정
	
	public List<SiRequestVO> myselectAllPaging(@Param("mid")String mid); //나의 시공의뢰 전체목록 + 페이징
//	public int mytotalCount(@Param("mid")String mid, @Param("cri")SireqCriteria cri); //나의 시공의뢰 전체 수
	
	public SiRequestVO select(int quoNo);//견적서 상세조회
}
