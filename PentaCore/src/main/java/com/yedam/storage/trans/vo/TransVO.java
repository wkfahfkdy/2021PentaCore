package com.yedam.storage.trans.vo;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class TransVO {
	
	private String apply_code;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private java.sql.Date apply_start;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private java.sql.Date apply_end;
	private String apply_whether;
	private String apply_product;
	private String use_num;
	private String store_code;
	private String store_name;
	private String apply_addr;
	private String convey_code;
	private String convey_before;
	private String convey_after;
	private String convey_file;
	private String convey_memo;
	private String convey_car;
	private String convey_driver;
	private String convey_time;
	private String member_id;	
	private String member_name;
	private String member_tel;
	private String info_num;
	private String info_use;
	private String storage_code;
	private String storage_name;
	

}
