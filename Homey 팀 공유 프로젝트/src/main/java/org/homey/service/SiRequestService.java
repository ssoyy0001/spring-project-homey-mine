package org.homey.service;

import java.util.List;

import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.domain.SiRequestVO;
import org.homey.domain.SireqCriteria;


public interface SiRequestService {
	
//	public List<SiRequestAttachVO> sireqAttachList(int sireqNo); //시공의뢰 첨부파일
	public List<SiRequestVO> getList(SireqCriteria cri); //시공의뢰 전체목록 + 페이징
	public int totalCount(SireqCriteria cri); //시공의뢰 전체 수
	
	public boolean register(SiRequestVO sireq, ItemVO ivo, QuotationVO qvo);//시공의뢰 등록시, 아이템 항목 업데이트와 견적서 항목 업데이트
	public SiRequestVO get(int sireqNo); //시공의뢰 상세조회
	public boolean modify(SiRequestVO sireq); //시공의뢰내용 수정
	public boolean remove(int sireqNo); //시공의뢰내용 삭제
	
//	public List<SiRequestVO> mylist(String mid, SireqCriteria cri); //나의 시공의뢰 전체목록 + 페이징
//	public int mytotalCount(String mid, SireqCriteria cri); //나의 시공의뢰 전체 수

//	public List<SiRequestVO> getList(); //시공의뢰 전체목록
}
