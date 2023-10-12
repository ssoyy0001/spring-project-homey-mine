package org.homey.service;

import java.util.List;

import org.homey.domain.Criteria;
import org.homey.domain.NoticeVO;



public interface NoticeService {

    public boolean register(NoticeVO nvo); // 공지사항 정보를 데이터베이스에 삽입합니다.
    public List<NoticeVO> list(); // 모든 공지사항을 조회합니다.
    public NoticeVO view(int notNo); // 특정 공지사항을 조회합니다.
    public List<NoticeVO> list(Criteria cri); // 페이징된 공지사항 목록을 조회합니다.
    public boolean modify(NoticeVO nvo); // 공지사항 정보를 업데이트합니다.
    public boolean remove(int notNo); // 특정 공지사항을 삭제합니다.
    public int totalCount(Criteria cri); // 공지사항의 전체 수를 조회합니다 (페이징을 위한 목적).
    public void noticeHit(int notNo); // 조회 수 증가
	
	//서비스를 구현하는 서비스imple클래스를 만들기
	//스프링에서 관리하는 bean으로 추가
}
