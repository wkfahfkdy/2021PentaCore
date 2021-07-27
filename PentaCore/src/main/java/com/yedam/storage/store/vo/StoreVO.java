package com.yedam.storage.store.vo;

public class StoreVO {

	/*
	 	STORE_CODE		VARCHAR2(5 BYTE)	NOT NULL	지점코드
		STORE_TEL		VARCHAR2(14 BYTE)				지점연락처
		STORE_BUS		VARCHAR2(150 BYTE)				버스정보
		STORE_SUBWAY	VARCHAR2(100 BYTE)				지하철정보
		STORE_EMAIL		VARCHAR2(40 BYTE)				이메일
		STORE_NAME		VARCHAR2(21 BYTE)				지점명
		STORE_ADDR		VARCHAR2(150 BYTE)				지점주소
		HUMIDITY		NUMBER(2,0)						온도
		TEMPERATURE		NUMBER(2,0)						습도
	*/
	
	private String store_tel;
	private String store_bus;
	private String store_subway;
	private String store_email;
	private String store_code;
	private String store_name;
	private String store_addr;
	private int humidity;
	private int temperature;
	
	public String getStore_tel() {
		return store_tel;
	}
	public void setStore_tel(String store_tel) {
		this.store_tel = store_tel;
	}
	public String getStore_bus() {
		return store_bus;
	}
	public void setStore_bus(String store_bus) {
		this.store_bus = store_bus;
	}
	public String getStore_subway() {
		return store_subway;
	}
	public void setStore_subway(String store_subway) {
		this.store_subway = store_subway;
	}
	public String getStore_email() {
		return store_email;
	}
	public void setStore_email(String store_email) {
		this.store_email = store_email;
	}
	public String getStore_code() {
		return store_code;
	}
	public void setStore_code(String store_code) {
		this.store_code = store_code;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getStore_addr() {
		return store_addr;
	}
	public void setStore_addr(String store_addr) {
		this.store_addr = store_addr;
	}
	public int getHumidity() {
		return humidity;
	}
	public void setHumidity(int humidity) {
		this.humidity = humidity;
	}
	public int getTemperature() {
		return temperature;
	}
	public void setTemperature(int temperature) {
		this.temperature = temperature;
	}
	
	@Override
	public String toString() {
		return "StoreVO [store_tel=" + store_tel + ", store_bus=" + store_bus + ", store_subway=" + store_subway
				+ ", store_email=" + store_email + ", store_code=" + store_code + ", store_name=" + store_name
				+ ", store_addr=" + store_addr + ", humidity=" + humidity + ", temperature=" + temperature + "]";
	}
	
}
