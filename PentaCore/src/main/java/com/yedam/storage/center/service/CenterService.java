package com.yedam.storage.center.service;

import java.util.List;

import com.yedam.storage.center.vo.CenterVO;

public interface CenterService {
	
	//FAQ
	public List<CenterVO> faqSelectList();
	
	//1:1
	public List<CenterVO> inquirySelectList();
	public int inquiryInsert(CenterVO vo);
	public int inquiryDelete();	
	
	//댓글
	public List<CenterVO> replyList();
	public int replyInsert();
	public int replyDelete();

}
