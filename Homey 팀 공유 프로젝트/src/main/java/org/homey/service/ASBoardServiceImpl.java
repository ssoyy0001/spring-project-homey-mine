package org.homey.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.homey.domain.ASBoardAttachVO;
import org.homey.domain.ASBoardVO;
import org.homey.domain.asCriteria;
import org.homey.mapper.ASBoardMapper;
import org.homey.mapper.ASBoardAttachMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ASBoardServiceImpl implements ASBoardService {
    private ASBoardMapper asBoardMapper;
    private ASBoardAttachMapper asBoardAttachMapper;
   
    @Override
    @Transactional
    public boolean register(ASBoardVO avo) {
    	
    		log.info("register...." + avo);
    		boolean result = asBoardMapper.insertSelectKey(avo) == 1;
    		
    		if(avo.getAttachList() != null && 
    			avo.getAttachList().size() > 0) {
    			
    			avo.getAttachList().forEach( bavo -> {
    				bavo.setBno(avo.getBno());
    				asBoardAttachMapper.insert(bavo);
    			});
    		}
    		return result;
    	}



    
   
    @Override
    public ASBoardVO view(int bno) {
        ASBoardVO asBoardVO = asBoardMapper.select(bno);

        if (asBoardVO != null) {
            asBoardVO.setAttachList(asBoardAttachMapper.select(bno));
        }

        return asBoardVO;
    }

   
    @Override
    public List<ASBoardVO> list(asCriteria cri, String mid) {
    log.info("list method in ASBoardServiceImpl is called");
    cri.setAmount(10); // 페이지당 게시물 수. 설정에 따라 변경 가능.
    List<ASBoardVO> resultList = asBoardMapper.selectAllPagingMe(mid, cri.getAmount(), cri.getPageNum());
    log.info("Result size: " + resultList.size());
    return resultList;
    }

    @Override
    public boolean modify(ASBoardVO asBoardVO) {
        log.info("modify..........");
        asBoardAttachMapper.deleteAll(asBoardVO.getBno());

        boolean result = asBoardMapper.update(asBoardVO) == 1;

        if (result && asBoardVO.getAttachList() != null) {
            asBoardVO.getAttachList().forEach(attach -> {
                attach.setBno(asBoardVO.getBno());
                asBoardAttachMapper.insert(attach);
            });
        }

        return result;
    }

    @Override
    public boolean remove(int bno) {
        log.info("remove..........");
        asBoardAttachMapper.deleteAll(bno);
        return asBoardMapper.delete(bno) == 1;
    }

    
    @Override
    public List<ASBoardVO> listPaging(asCriteria cri) {
        log.info("getListPaging..........");
        return asBoardMapper.selectAllPaging(cri);
    }
   

    @Override
    public int getTotal(asCriteria cri) {
        log.info("get total count..........");
        return asBoardMapper.totalCount(cri);
    }

    @Override
    public List<ASBoardAttachVO> getBoardAttachList(int bno) {
        log.info("get board attach list by bno..........");
        return asBoardAttachMapper.select(bno);
    }

    
}
