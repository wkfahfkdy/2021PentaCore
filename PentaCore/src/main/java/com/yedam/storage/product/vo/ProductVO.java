package com.yedam.storage.product.vo;

import lombok.Data;

/*
PRODUCT_CODE     NOT NULL VARCHAR2(5)   
PRODUCT_NAME              VARCHAR2(30)  
PRODUCT_WIDTH             NUMBER(3)     
PRODUCT_VERTICAL          NUMBER(3)     
PRODUCT_HEIGHT            NUMBER(3)     
PRODUCT_VOLUME            NUMBER        
DIVISION_CODE             VARCHAR2(5)   
PRODUCT_IMAGE             VARCHAR2(100) 
 */

@Data
public class ProductVO {
	private String product_code;
	private String product_name;
	private int product_width;
	private int product_vertical;
	private int product_volume;
	private String division_code;
	private String product_image;
	private String division_name;
}
