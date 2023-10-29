package org.homey.domain;


import lombok.Data;
@Data
public class ItemVO {

	//시공 및 철거 항목
	private int itemNo; // 아이템 번호 (PK)
    private int consultNo; // 견적상담번호 (FK)
    
    private int tiling; // 도배/벽에 시공비용
    private int tilingD; // 도배/벽에 철거비용
    
    private int flooring; // 바닥에 대한 시공비용
    private int flooringD; // 바닥에 대한 철거비용
    
    private int kitchen; // 주방에 대한 시공비용
    private int kitchenD; // 주방에 대한 철거비용

    private int bathroom; // 욕실에 대한 시공비용
    private int bathroomD; // 욕실에 대한 철거비용
    
    private int entrance; // 현관에 대한 시공비용
    private int entranceD; // 현관에 대한 철거비용

    private int balcony; // 발코니에 대한 시공비용
    private int balconyD; // 발코니에 대한 철거비용

    private int lighting; // 조명에 대한 시공비용
    private int lightingD; // 조명에 대한 철거비용

    private int door; // 문에 대한 시공비용
    private int doorD; // 문에 대한 철거비용

    private int etc; // 그 외 항목에 대한 시공비용
    private int etcD; // 그 외 항목에 대한 철거비용
    
}
