package com.yedam.storage.trans.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TransVO {
	
	private String apply_code;
	
	private Date apply_start;
	private Date apply_end;
	private String apply_whether;
	private String apply_product;
	private String use_num;
	private String store_code;
	private String apply_addr;
	private String member_id;
	
	private String convey_code;
	private String convey_before;
	private String convey_after;
	private String convey_file;
	private String info_num;
	private String member_name;
	private String convey_memo;
	private String convey_car;
	private String convey_driver;
	private String convey_time;

}
