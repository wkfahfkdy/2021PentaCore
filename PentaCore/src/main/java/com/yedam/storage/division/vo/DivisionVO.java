package com.yedam.storage.division.vo;

import lombok.Data;

/*
DIVISION_CODE NOT NULL VARCHAR2(5)  
DIVISION_NAME          VARCHAR2(15) 
 */

@Data
public class DivisionVO {
	private String division_code;
	private String division_name;
}
