package org.homey.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
@Data
public class VisitVO {
	
	// VisitVO: 방문실측 스케줄 정보
	
	@JsonProperty("title") //JSON 변환 시 title로 이름을 변경하여 전달
	private int visitNo; // 방문 실측 스케줄 번호 (PK) //Event : title
	
	private int consultNo; // 견적상담번호 (FK)
	
	@JsonProperty("description") //JSON 변환 시 description로 이름을 변경하여 전달
	private String visitStatus; //실측 여부 O, X
	
	@JsonProperty("start")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss", timezone = "Asia/Seoul")
    private Date visitStartDate; //실측 일자 //Event : start
    
	@JsonProperty("end")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss", timezone = "Asia/Seoul")
	private Date visitEndDate; //실측 일자 //Event : end
  
}
