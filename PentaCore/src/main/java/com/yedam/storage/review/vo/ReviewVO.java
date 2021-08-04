package com.yedam.storage.review.vo;

import java.sql.Date;

import lombok.*;

@Data
public class ReviewVO {
	
	/*
	REVIEW_NUM	NUMBER	No		1	리뷰게시글번호
	REVIEW_TITLE	VARCHAR2(150 BYTE)	Yes		2	제목
	REVIEW_CONTENT	VARCHAR2(2000 BYTE)	Yes		3	내용
	REVIEW_DATE	DATE	Yes		4	작성일자
	STORE_CODE	VARCHAR2(5 BYTE)	Yes		5	지점코드
	MEMBER_ID	VARCHAR2(20 BYTE)	Yes		6	고객ID
	*/
	
	private int review_num;
	private String review_title;
	private String review_content;
	private Date review_date;
	private String store_code;
	private String member_id;
	//join
	private String member_name;
	private String store_name;
	private int firstCnt;
	private int lastCnt;
		
	}
