package com.yedam.storage.coupon.vo;

import java.util.Date;

import lombok.Data;

/*
COUPON_CODE     NOT NULL VARCHAR2(5)  
COUPON_NAME              VARCHAR2(60) 
COUPON_DISCOUNT          NUMBER(3,2)  
COUPON_START             DATE         
COUPON_END               DATE         
STORE_CODE               VARCHAR2(5)  
 */

@Data
public class CouponVO {
	private String coupon_code;
	private String coupon_name;
	private float coupon_discount;
	private Date coupon_start;
	private Date coupon_end;
	private String store_code;
}
