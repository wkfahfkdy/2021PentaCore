package com.yedam.storage.storage.vo;

import lombok.Data;
/*
  	STORAGE_CODE     NOT NULL VARCHAR2(5)   
	STORAGE_WIDTH             NUMBER(3)     
	STORAGE_CONTENT           VARCHAR2(500) 
	STORAGE_NAME              VARCHAR2(15)  
	STORAGE_PRICE             NUMBER        
	STORAGE_VERTICAL          NUMBER(3)     
	STORAGE_HEIGHT            NUMBER(3)     
	STORAGE_VOLUME            NUMBER        
	STORAGE_IMAGE             VARCHAR2(100) 
 */
@Data
public class StorageVO {
	private String storage_code;
	private int storage_width;
	private String storage_content;
	private String storage_name;
	private int storage_price;
	private int storage_vertical;
	private int storage_height;
	private int storage_volume;
	private String storage_image;
}
