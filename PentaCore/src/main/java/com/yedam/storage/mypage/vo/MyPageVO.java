package com.yedam.storage.mypage.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.*;

@Data
public class MyPageVO {
	private int notice_num;
	private String notice_title;
	private String notice_content;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date notice_date;
	private String store_code;
	private String offer_code;
	private String member_id;
	private String storage_code;
	private String offer_product;
	private String offer_wash;
	private String laundry_product;
	private int laundry_count;
	private String offer_rental;
	private String offer_premium;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date offer_start;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date offer_date;
	private String offer_pickup;
	private String coupon_code;
	private int offer_price;
	private String offer_pay;
	private String convey_code;
	private String member_name;
	private String info_num;
	private String apply_code;
	private String apply_product;
	private String apply_addr;
	private String convey_memo;
	private String convey_driver;
	private String convey_before;
	private String convey_after;
	private String convey_file;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private java.sql.Date apply_start;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private java.sql.Date apply_end;
	private String apply_time;
	private String apply_whether;
	private String use_num;
	private String tour_code;
	private String tour_tel;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private java.sql.Date tour_date;
	private String tour_time;
	private String tour_complete;
	private String coupon_name;
	private float coupon_discount;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date coupon_start;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date coupon_end;
	private String member_pwd;
	private String member_addr;
	private String member_tel;
	private String member_email;
	private String member_birth;
	private String member_enable;
	private int question_num;
	private int question_parents;
	private String question_content;
	private String question_file;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date use_start;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date use_end;
	private String storage_name;
	private String store_name;
	private int storage_width;
	private int storage_height;
	private int storage_vertical;
	private int total_price;
	private int storage_price;
	private String Store_addr;
	private String store_tel;
	private String store_bus;
	private String store_subway;
	private String store_email;
	private String tour_cancel;
	private int review_num;
	private String review_title;
	private String review_content;
	private String review_date;
	
	// 투어 취소에 필요: Grid Api
	private List<MyPageVO> updatedRows;
}
