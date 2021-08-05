package com.yedam.storage.offer.vo;

import java.sql.Date;

import lombok.Data;

/*
OFFER_CODE      NOT NULL VARCHAR2(5)   
OFFER_PRODUCT            VARCHAR2(300) 
OFFER_START              DATE          
OFFER_RENTAL             VARCHAR2(50)  
OFFER_PICKUP             VARCHAR2(150) 
OFFER_PRICE              NUMBER        
OFFER_DATE               DATE          
OFFER_WASH               VARCHAR2(1)   
OFFER_PREMIUM            VARCHAR2(1)   
RENTAL_CODE              VARCHAR2(5)   
STORAGE_CODE             VARCHAR2(5)   
COUPON_CODE              VARCHAR2(5)   
STORE_CODE               VARCHAR2(5)   
LAUNDRY_PRODUCT          VARCHAR2(300) 
LAUNDRY_COUNT            NUMBER        
OFFER_PAY                VARCHAR2(1)   
MEMBER_ID                VARCHAR2(20)  
 */
@Data
public class OfferVO {
	private String offer_code;
	private String offer_product;
	private Date offer_start;
	private String offer_rental;
	private String offer_pickup;
	private int offer_price;
	private int offer_date;
	private String offer_wash;
	private String offer_premium;
	private String rental_code;
	private String coupon_code;
	private String store_code;
	private String laundry_product;
	private String offer_pay;
	private String member_id;
}
