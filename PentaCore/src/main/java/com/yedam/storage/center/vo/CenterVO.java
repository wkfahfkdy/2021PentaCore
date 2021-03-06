package com.yedam.storage.center.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CenterVO {
	// FAQ
	private String faq_num;
	private String faq_title;
	private String faq_content;
	
	// 1대1 문의
	private int question_num;
	private int question_parents;
	private String question_content;
	private String question_file;
	private String store_code;
	private String member_id;
	private Date question_date;
	private int question_group;
	
	//paging Btn index 
	private int firstRecordIndex;
	private int lastRecordIndex;
	private int totalCnt;
	
}
