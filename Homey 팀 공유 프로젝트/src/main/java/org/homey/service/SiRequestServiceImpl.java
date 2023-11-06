package org.homey.service;

import java.util.List;

import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.domain.SiRequestVO;
import org.homey.domain.SireqCriteria;
import org.homey.mapper.ItemMapper;
import org.homey.mapper.QuotationMapper;

import org.homey.mapper.SiRequestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SiRequestServiceImpl implements SiRequestService {
	
	@Setter(onMethod_ = @Autowired)
	private SiRequestMapper sireqMapper;
	@Setter(onMethod_ = @Autowired)
	private QuotationMapper quotationMapper;
	@Setter(onMethod_ = @Autowired)
	private ItemMapper itemMapper;
//	@Setter(onMethod_ = @Autowired)
//	private SiRequestAttachMapper sireqAttachMapper;
	
	
//	@Override
//	public List<SiRequestVO> getList(){ //시공의뢰 전체목록
//		log.info("list..........");
//		return sireqMapper.getList();
//	}
	
	@Override
	public boolean register(SiRequestVO sireq, ItemVO ivo, QuotationVO qvo) { //시공의뢰 등록 + 첨부파일 등록
		//sireqVO 등록
		int result = sireqMapper.insert(sireq); //sireqMapper에 insert 성공 하면 결과값 1 반환
		log.info("시공의뢰 register...." + sireq);	
		if (result > 0) { //1보다 크면, sireqVO 등록 성공하면
      	 // ivo의 철거/시공항목과 qvo의 철거/시공비용 업데이트 필요 
		
      	 int consultNo = sireq.getConsultvo().getConsultNo(); //ivo, qvo를 업데이트하기 위해 consultNo를 얻어옴
  
           ivo.setConsultNo(consultNo); // 그 후 ItemVO에 consultNo 설정
           qvo.setConsultNo(consultNo); // QuotationVO에 consultNo 설정
          
           int itemResult = sireqMapper.updateItem(ivo);  // item 테이블에 데이터 업데이트
           int qutationResult = sireqMapper.updateQuotationTable(qvo); //quotation 테이블에 데이터 업데이트
           if (itemResult == 1 && qutationResult ==1) { // 성공하면 true 반환
               return true;
           }
		}
       return false; // 등록에 실패한 경우 false 반환
       }
	
	
	@Override
	public List<SiRequestVO> getList(SireqCriteria cri){ //시공의뢰 전체목록 + 페이징
		log.info("get List with crieteria: " + cri);
		return sireqMapper.getListWithPaging(cri);
	}
	
	@Override
	public SiRequestVO get(int sireqNo) { //시공의뢰 상세조회
		log.info("get......" + sireqNo);
		return sireqMapper.read(sireqNo);
	}
	
	@Override
	public boolean modify(SiRequestVO sireq, ItemVO ivo, QuotationVO qvo) {//시공의뢰내용 수정 + 기존 첨부파일 모두 삭제 + 다시 첨부파일 데이터 추가	
		
		int result = sireqMapper.update(sireq); //sireqMapper에 update 성공 하면 결과값 1 반환

		log.info("시공의뢰 modify한 sireqVO : " + sireq);	
		
		if (result > 0) { //1보다 크면, sireqVO 업데이트 성공하면,
		// ivo의 철거/시공항목과 qvo의 철거/시공비용 업데이트 필요
		
      	 int consultNo = sireq.getConsultvo().getConsultNo(); //ivo, qvo를 업데이트하기 위해 consultNo를 얻어옴
  
           ivo.setConsultNo(consultNo); // 그 후 ItemVO에 consultNo 설정
           qvo.setConsultNo(consultNo); // QuotationVO에 consultNo 설정
           
           int itemResult = sireqMapper.updateItem(ivo);  // item 테이블에 데이터 업데이트
           int qutationResult = sireqMapper.updateQuotationTable(qvo); //quotation 테이블에 데이터 업데이트
           if (itemResult == 1 && qutationResult ==1) { // 성공하면 true 반환
               return true;
           }
		}
       return false; // 등록에 실패한 경우 false 반환
	}
	
	@Override
	public boolean remove(int sireqNo) {//시공의뢰내용 삭제 + 첨부파일 모두 삭제
		log.info("remove...." + sireqNo);
		return sireqMapper.delete(sireqNo)==1;
	}

	@Override
	public int totalCount(SireqCriteria cri) { //시공의뢰 전체 수
		return sireqMapper.totalCount(cri);
	}
//
//	@Override
//	public List<SiRequestAttachVO> sireqAttachList(int sireqNo){ //시공의뢰 상세조회시 첨부파일 전체조회
//		return sireqAttachMapper.select(sireqNo);
//	}
//	
	@Override
	public List<SiRequestVO> mylist(String mid){ //나의 시공의뢰 전체목록 + 페이징
		log.info("get MyList with crieteria: " + mid);
		return sireqMapper.myselectAllPaging(mid);
	} 

//	@Override
//	public SiRequestVO quoSelect(int quoNo) {
//		log.info("quoSelect......" + quoNo);
//		return sireqMapper.select(quoNo);
//	}

}
