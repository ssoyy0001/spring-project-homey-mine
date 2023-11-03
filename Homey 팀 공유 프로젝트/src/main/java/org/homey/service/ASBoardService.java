package org.homey.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.homey.domain.ASBoardVO;
import org.homey.domain.ASBoardAttachVO;
import org.homey.domain.asCriteria;

public interface ASBoardService {
    public boolean register(ASBoardVO avo); // AS 게시물 등록
    public ASBoardVO view(int bno); // AS 게시물 조회
    public boolean modify(ASBoardVO avo); // AS 게시물 수정
    public boolean remove(int bno); // AS 게시물 삭제
    public List<ASBoardVO> listPaging(asCriteria cri); // AS 게시물 목록 페이징 조회
    public List<ASBoardVO> list(asCriteria cri, String mid); // 나의 견적상담 전체 목록 조회 + 페이징
    public int getTotal(asCriteria cri); // AS 게시물 전체 개수 조회
    public List<ASBoardAttachVO> getBoardAttachList(int bno);
    

   
}
