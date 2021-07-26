package com.yedam.mypage.vo;

import java.util.Date;

import lombok.*;

@Data
public class MyPageVO {
	private int notice_num;
	private String notice_title;
	private String notice_content;
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
	private Date offer_start;
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
	private String convey_memo;
	private String convey_driver;
	private String convey_before;
	private String convey_after;
	private String convey_file;
	private Date apply_start;
	private Date apply_end;
	private String apply_time;
	private String apply_whether;
	private String use_num;
	private String tour_code;
	private String tour_tel;
	private Date tour_date;
	private String tour_time;
	private String tour_complete;
	private String coupon_name;
	private float coupon_discount;
	private Date coupon_start;
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
	private Date use_start;
	private Date use_end;
}
