package org.homey.service;

import java.util.List;

import org.homey.domain.ItemVO;
import org.homey.domain.QuotationVO;
import org.homey.domain.SiRequestVO;
import org.homey.domain.SireqCriteria;
import org.homey.mapper.ItemMapper;
import org.homey.mapper.QuotationMapper;
import org.homey.mapper.SiRequestAttachMapper;
import org.homey.mapper.SiRequestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
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
	
//	private SiRequestAttachMapper sireqAttachMapper;
	
	
//	@Override
//	public List<SiRequestVO> getList(){ //시공의뢰 전체목록
//		log.info("list..........");
//		return sireqMapper.getList();
//	}
	
	@Override
	public boolean register(SiRequestVO sireq, ItemVO ivo, QuotationVO qvo) { //시공의뢰 등록 + 첨부파일 등록
		//sireqVO 등록
		int result = sireqMapper.insertSelectkey(sireq);
		log.info("시공의뢰 register...." + sireq);	
		if (result > 0) {
      	 // sireqVO 등록에 성공한 경우 Ivo에서는 ItmeNo, consult와 qutation에서는 consultNo를 얻어옴
		int ItemNo = sireq.getIvo().getItemNo();
      	 int consultNo = sireq.getConsultvo().getConsultNo();
      	 int quotationNo = sireq.getQuotationvo().getQuoNo();
           // 그 후 ItemVO에 consultNo 설정, QuotationVO에 consultNo 설정
           ivo.setConsultNo(consultNo);
           qvo.setConsultNo(ItemNo);
           // item 테이블에 데이터 업데이트
           int itemResult = sireqMapper.updateItem(ivo);
           int qutationResult = sireqMapper.updateQuotationTable(qvo);
           if (itemResult == 1 && qutationResult ==1) { // 성공하면 true 반환
               return true;
           }
		}
       return false; // 등록에 실패한 경우 false 반환
       }
	
//	@Override
//	public boolean register(SiRequestVO sireq, ItemVO ivo) { //시공의뢰 등록 + 첨부파일 등록
//		//sireqVO 등록
//		int result = sireqMapper.insertSelectkey(sireq);
//		log.info("시공의뢰 register...." + sireq);	
//		
//		if (result > 0) {
//       	 // sireqVO 등록에 성공한 경우 consultNo를 얻어옴
//       	 int consultNo = sireq.getConsultvo().getConsultNo();
//       	 
//            // 그 후 ItemVO에 consultNo 설정
//            ivo.setConsultNo(consultNo);
//            
//            // item 테이블에 데이터 업데이트
//            int itemResult = quotationMapper.updateItem(ivo);
//            if (itemResult == 1) { // 성공하면 true 반환
//                return true;
//            }
//        }
//        return false; // 등록에 실패한 경우 false 반환
//       }
	
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
	public boolean modify(SiRequestVO sireq) {//시공의뢰내용 수정 + 기존 첨부파일 모두 삭제 + 다시 첨부파일 데이터 추가
		log.info("modify....." + sireq);
		return sireqMapper.update(sireq)==1;
	}
	
	@Override
	public boolean remove(int sireqNo) {//시공의뢰내용 삭제 + 첨부파일 모두 삭제
		log.info("remove...." + sireqNo);
		return sireqMapper.delete(sireqNo)==1;
	}

//	@Override
//	public int totalCount(Criteria cri) { //시공의뢰 전체 수
//		return sireqMapper.totalCount(cri);
//	}
//
//	@Override
//	public List<SiRequestAttachVO> sireqAttachList(int sireqNo){ //시공의뢰 상세조회시 첨부파일 전체조회
//		return sireqAttachMapper.select(sireqNo);
//	}
//	
//	@Override
//	public List<SiRequestVO> mylist(String mid, Criteria cri){ //나의 시공의뢰 전체목록 + 페이징
//		return sireqMapper.myselectAllPaging(mid, cri);
//	} 
//	
//	@Override
//	public int mytotalCount(String mid, Criteria cri){ //나의 시공의뢰 전체 수
//		return sireqMapper.mytotalCount(mid, cri);
//	} 

}
