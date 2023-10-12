package org.homey.mapper;

import java.util.List;

import org.homey.domain.Criteria;
import org.homey.domain.NoticeVO;

public interface NoticeMapper {
	
    public void insert(NoticeVO nvo); // 공지사항 정보를 데이터베이스에 삽입합니다.
    public List<NoticeVO> selectAll(); // 모든 공지사항을 조회합니다.
    public NoticeVO select(int notNo); // 특정 공지사항을 조회합니다.
    public List<NoticeVO> selectAllPaging(Criteria cri); // 페이징된 공지사항 목록을 조회합니다.
    public int update(NoticeVO nvo); // 공지사항 정보를 업데이트합니다.
    public int delete(int notNo); // 특정 공지사항을 삭제합니다.
    public int totalCount(Criteria cri); // 공지사항의 전체 수를 조회합니다 (페이징을 위한 목적).
    public void noticeHit(int notNo); // 조회 수 증가
    

}
