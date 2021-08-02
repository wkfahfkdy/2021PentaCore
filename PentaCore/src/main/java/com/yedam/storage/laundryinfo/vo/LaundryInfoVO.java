package com.yedam.storage.laundryinfo.vo;

import lombok.Data;

/*
	LAUNDRY_GUBUN NOT NULL VARCHAR2(5)  
	LAUNDRY_KIND           VARCHAR2(20) 
	LAUNDRY_PRICE          NUMBER   
 */
@Data
public class LaundryInfoVO {
	private String laundry_gubun;
	private String laundry_kind;
	private int laundry_price;
}
