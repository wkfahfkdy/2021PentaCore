package com.yedam.storage.store.vo;

import lombok.Data;

@Data
public class StoreVO {

	/*
	 	STORE_CODE		VARCHAR2(5 BYTE)	NOT NULL	지점코드
		STORE_TEL		VARCHAR2(14 BYTE)				지점연락처
		STORE_BUS		VARCHAR2(150 BYTE)				버스정보
		STORE_SUBWAY	VARCHAR2(100 BYTE)				지하철정보
		STORE_EMAIL		VARCHAR2(40 BYTE)				이메일
		STORE_NAME		VARCHAR2(21 BYTE)				지점명
		STORE_ADDR		VARCHAR2(150 BYTE)				지점주소
		HUMIDITY		NUMBER(2,0)						온도
		TEMPERATURE		NUMBER(2,0)						습도
	*/
	
	private String store_tel;
	private String store_bus;
	private String store_subway;
	private String store_email;
	private String store_code;
	private String store_name;
	private String store_addr;
	private int humidity;
	private int temperature;
	
}
