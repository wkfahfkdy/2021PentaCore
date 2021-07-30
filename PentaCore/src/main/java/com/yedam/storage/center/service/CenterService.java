package com.yedam.storage.center.service;

import java.util.List;

import com.yedam.storage.center.vo.CenterVO;
import com.yedam.storage.paging.paging;

public interface CenterService {
	
	//FAQ
	public List<CenterVO> faqSelectList();
	
	//1:1
	public List<paging> inquirySelectList(CenterVO vo);
	public List<paging> inquiryPaging(CenterVO vo);
	public int inquiryInsert(CenterVO vo);
	public int inquiryDelete(CenterVO vo);	
	
	//댓글
	public List<CenterVO> replyList(CenterVO vo);
	public int replyInsert();
	public int replyDelete();


}
