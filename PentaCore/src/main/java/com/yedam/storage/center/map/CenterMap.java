package com.yedam.storage.center.map;

import java.util.List;

import com.yedam.storage.center.vo.CenterVO;
import com.yedam.storage.paging.paging;

public interface CenterMap {

	//FAQ
	public List<CenterVO> faqSelectList();
	
	//1:1
	public List<paging> inquirySelectList();
	public List<paging> inquiryPaging(CenterVO vo);
	public int inquiryInsert(CenterVO vo);
	public int inquiryDelete();	
	
	//paging
	public int tableCnt();
	
	//댓글
	public List<CenterVO> replyList();
	public int replyInsert();
	public int replyDelete();

}
