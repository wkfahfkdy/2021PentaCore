package com.yedam.storage.center.vo;

import lombok.Data;

@Data
public class CenterVO {
	// FAQ
	private int faq_num;
	private String faq_title;
	private String faq_content;
	
	private int question_num;
	private int question_parents;
	private String question_content;
	private String question_file;
	private String store_code;
	private String member_id;
}
