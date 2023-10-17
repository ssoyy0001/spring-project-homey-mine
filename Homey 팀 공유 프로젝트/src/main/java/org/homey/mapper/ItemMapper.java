package org.homey.mapper;


import org.homey.domain.ItemVO;

public interface ItemMapper {
	
    public void insert(ItemVO ivo); //시공 및 철거 항목 등록
    public ItemVO select(int consultNo); //시공 및 철거 항목 조회
    public int update(ItemVO ivo); //시공 및 철거 항목 수정
    public int delete(int consultNo); //시공 및 철거 항목 삭제

}
