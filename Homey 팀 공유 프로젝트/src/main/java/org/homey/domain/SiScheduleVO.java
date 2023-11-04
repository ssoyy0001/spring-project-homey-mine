package org.homey.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class SiScheduleVO {
	private int sicheNo;
	private int sireqNo;
	private int quoNo;
	private String mid;
	private String balanceStatus;
	private String constructionStatus;
	@JsonProperty("title")//json으로 값반환시 이름 지정  풀캘린더사용을 위함
	private String workCrew;
	@JsonProperty("start")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'")
	//timezone을 Asia/Seoul로 하게되면 풀캘린더에 끝나는 날짜가 하루적게 보여지게됨 DB시간대와 안맞아서 그러는듯  
	private Date startDate;
	@JsonProperty("end")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'")
	private Date endDate;
	
	private String startDateStr;//input type="date"의 값을 Date로 전환시 사용
	private String endDateStr;
	
	private int total;//견적서,시공의뢰에서 값을 받기위함
	private String buildingType;
	private int pyeongsu;

}
