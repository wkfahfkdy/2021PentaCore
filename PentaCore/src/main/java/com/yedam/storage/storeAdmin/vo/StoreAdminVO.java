package com.yedam.storage.storeAdmin.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class StoreAdminVO {
	
	/*
	USE_START	DATE	Yes		1	시작일
	USE_END	DATE	Yes		2	만료일
	INFO_NUM	VARCHAR2(5 BYTE)	Yes		3	매장 스토리지 고유 번호
	STORE_CODE	VARCHAR2(5 BYTE)	Yes		4	지점코드
	OFFER_CODE	VARCHAR2(5 BYTE)	Yes		5	견적서 코드
	USE_NUM	VARCHAR2(5 BYTE)	No		6	리스트 넘버
	MEMBER_ID	VARCHAR2(20 BYTE)	Yes		7	고객ID
	
	=== Storage_Info (스토리지현황)===
	INFO_NUM     NOT NULL VARCHAR2(5) 
	INFO_USE              VARCHAR2(1) 
	STORAGE_CODE          VARCHAR2(5) 
	STORE_CODE            VARCHAR2(5) 
	
	=== 컨디션 리스트 ===
			CONDITION_TITLE	VARCHAR2(2000 BYTE)	Yes		1	제목
			CONDITION_DATE	DATE	Yes		2	작성일자
			CONDITION_NUM	VARCHAR2(5 BYTE)	No		3	컨디션 리스트 넘버
			USE_NUM	VARCHAR2(5 BYTE)	Yes		4	리스트 넘버
			CONDITION_COMMENT	VARCHAR2(2000 BYTE)	Yes		5	사진 및 코멘트
	
	 */

	
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
	
	/*
	 * 	COUPON_CODE	VARCHAR2(5 BYTE)	No		1	쿠폰코드
		COUPON_NAME	VARCHAR2(60 BYTE)	Yes		2	쿠폰이름
		COUPON_DISCOUNT	NUMBER(3,2)	Yes		3	쿠폰할인률
		COUPON_START	DATE	Yes		4	쿠폰발급일자
		COUPON_END	DATE	Yes		5	쿠폰유효기간
		STORE_CODE	VARCHAR2(5 BYTE)	Yes		6	지점코드
	 */
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
