package org.homey.service;

import java.util.List;

import org.homey.domain.Criteria;
import org.homey.domain.NoticeAttachVO;
import org.homey.domain.NoticeVO;



public interface NoticeService {

    public boolean register(NoticeVO nvo); // 공지사항 등록
    public List<NoticeVO> list(Criteria cri); // 페이징된 공지사항 목록
    public NoticeVO view(int notNo); // 특정 공지사항을 조회
    public boolean modify(NoticeVO nvo); // 공지사항 수정
    public boolean remove(int notNo); // 특정 공지사항을 삭제
    public int totalCount(Criteria cri); // 공지사항의 전체 수 조회
    public List<NoticeAttachVO> attachList(int notNo);
}
