package org.homey.service;

import java.util.List;

import org.homey.domain.SoCriteria;
import org.homey.domain.OnedayVO;


public interface OnedayService {

	//원데이클래스 게시글 관련 서비스단
	
	//DB보다는 고객들과 더 가깝기 때문에 Mapper인터페이스에 비해 명칭이 달라짐
	//반환형도 boolean으로 바꿈
	
	//페이징
	public int odTotalCount(SoCriteria socri);								//원데이클래스 게시글 개수
	public List<OnedayVO> odListPaging(SoCriteria socri);			//원데이클래스 게시글 전체조회

	public OnedayVO odView(int odNo);								//원데이클래스 게시글 상세조회
	public boolean odRegister(OnedayVO odvo);					//원데이클래스 게시글 등록
	public boolean odRemove(int odNo);							//원데이클래스 게시글 삭제
	public boolean odModify(OnedayVO odvo);					//원데이클래스 게시글 수정
	
}
