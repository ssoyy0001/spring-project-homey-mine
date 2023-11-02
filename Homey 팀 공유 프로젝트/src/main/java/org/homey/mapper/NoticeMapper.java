package org.homey.mapper;

import java.util.List;

import org.homey.domain.Criteria;
import org.homey.domain.NoticeVO;

public interface NoticeMapper {
    
	public int insertSelectKey(NoticeVO nvo);	//등록
	public NoticeVO select(int notNo); //조회
    public List<NoticeVO> selectAllPaging(Criteria cri); // 페이징된 공지사항 목록
    public int update(NoticeVO nvo); // 수정
    public int delete(int notNo); // 삭제
    public int totalCount(Criteria cri); // 공지사항의 전체 수를 조회
    public void noticeHit(int notNo); // 조회 수 증가

}
