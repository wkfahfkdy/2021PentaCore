package com.yedam.storage.storeAdmin.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class StoreAdminVO {


	
	//고객관리부분
	private String num;
	private String use_num;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date use_start;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date use_end;
	private String info_num;
	private String store_code;
	private String store_name;
	private String offer_code;
	private String member_id;
	private String member_tel;
	
	// Storage_Info
	private String info_use;
	private String storage_code;
	private String storage_name;
	private String offer_product;
	
	// 지점별 공지사항 등록
	private int notice_num;
	private String notice_title;
	private String notice_content;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date notice_date;
	private String member_name;
	
	private int firstCnt;
	private int lastCnt;
	
	//고객관리부분 offer
	private String offer_premium;
	private String offer_wash;
	private String laundry_consign;
	private String laundry_collect;
	
	//투어부분
	private String tour_code;
	private java.sql.Date tour_date;
	private String tour_time;
	private String tour_complete;
	private String tour_cancel;
	
	// 투어 취소에 필요: Grid Api
	private List<StoreAdminVO> updatedRows;
	
	//coupon
	private String coupon_code;
	private String coupon_name;
	private double coupon_discount;
	private String coupon_start;
	private String coupon_end;
	
	
	// 1:1 문의 관리
	private int question_num;
	private String question_title;
	private String question_content;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date question_date;
	private int question_parents;
	private int question_group;
	private int group_cnt;
			
	//컨디션 리스트
	//private String use_num
	private String condition_num;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date condition_date;
	private String condition_title;
	private String condition_comment;
	
	
	
}
