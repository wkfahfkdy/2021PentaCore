package com.yedam.storage.rental.vo;

import lombok.Data;

/*
	RENTAL_CODE   NOT NULL VARCHAR2(6)   
	RENTAL_NAME            VARCHAR2(12)  
	RENTAL_PRICE           NUMBER        
	DIVISION_CODE          VARCHAR2(5)   
	RENTAL_IMAGE           VARCHAR2(100) 
 */
@Data
public class RentalVO {
	private String rental_code;
	private String rental_name;
	private int rental_price;
	private String division_code;
	private String rental_image;
	private int rental_volume;
}
