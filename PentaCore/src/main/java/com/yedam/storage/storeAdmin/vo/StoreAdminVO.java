package com.yedam.storage.storeAdmin.vo;

import java.sql.Date;

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
	 */

	//고객관리부분
	private String use_num;
	private Date use_start;
	private Date use_end;
	private String info_num;
	private String store_code;
	private String offer_code;
	private String member_id;
	
	// 지점별 공지사항 등록
	private int notice_num;
	private String notice_title;
	private String notice_content;
	private Date notice_date;
}
