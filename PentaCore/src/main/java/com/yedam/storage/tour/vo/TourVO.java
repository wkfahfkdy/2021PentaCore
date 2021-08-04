package com.yedam.storage.tour.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TourVO {

	private String tour_code;
	private String tour_tel;
	private Date tour_date;
	private String tour_time;
	private String store_code;
	private String tour_complete;
	private String member_id;
	private String tour_cancel;
	
}
