package com.yedam.storage.mystorage.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MyStorageVO {

	// 안심보관이사
	private String apply_code;
	private Date apply_start;
	private Date apply_end;
	private String apply_whether;
	private String apply_product;
	private String use_num;
	private String store_code;
	private String apply_addr;
	private String member_id;
	
}
