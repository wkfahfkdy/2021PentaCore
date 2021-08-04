package com.yedam.storage.mystorage.vo;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class MyStorageVO {

	// 안심보관이사
	private String apply_code;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private java.sql.Date apply_start;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private java.sql.Date apply_end;
	private String apply_whether;
	private String apply_product;
	private String use_num;
	private String store_code;
	private String apply_addr;
	private String member_id;
	
}
