package com.yedam.storage.trans.map;

import java.util.List;

import com.yedam.storage.trans.vo.TransVO;

public interface TransMap {
	
	public List<TransVO> customerListAll(TransVO vo);
	public TransVO myCustomerSelect(TransVO vo);
	public List<TransVO> cuStorage(TransVO vo); 
	
}
