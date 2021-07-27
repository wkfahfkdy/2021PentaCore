package com.yedam.storage.center.map;

import java.util.List;

import com.yedam.storage.center.vo.CenterVO;

public interface CenterMap {
	
	// FAQ
	public List<CenterVO> faqSelectList();
	
	// 1:1
	public List<CenterVO> inquirySelectList();
	public int inquiryInsert();
	public int inquiryUpdate();
	public int inquiryDelete();	

}
