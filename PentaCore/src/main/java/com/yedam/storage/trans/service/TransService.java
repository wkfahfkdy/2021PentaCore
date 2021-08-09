package com.yedam.storage.trans.service;

import java.util.List;

import com.yedam.storage.trans.vo.TransVO;

public interface TransService {
	
	// 신청내역 all
	public List<TransVO> customerListAll(TransVO vo);
	
	// 신청내역 상세정보
	public TransVO myCustomerSelect(TransVO vo);
	
	// 스토리지 셀렉트박스
	public List<TransVO> cuStorage(TransVO vo);
	
}
