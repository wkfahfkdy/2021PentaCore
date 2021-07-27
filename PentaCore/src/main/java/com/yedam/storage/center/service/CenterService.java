package com.yedam.storage.center.service;

import java.util.List;

import com.yedam.storage.center.vo.CenterVO;

public interface CenterService {
	
	//FAQ
	public List<CenterVO> faqSelectList();
	
	//1:1
	public List<CenterVO> inquirySelectList();
	public int inquiryInsert();
	public int inquiryUpdate();
	public int inquiryDelete();	

}
