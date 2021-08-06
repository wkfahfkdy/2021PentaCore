package com.yedam.storage.trans.service;

import java.util.List;

import com.yedam.storage.trans.vo.TransVO;

public interface TransService {
	
	public List<TransVO> coustomerListAll(TransVO vo);
	public TransVO myCoustomerSelect(TransVO vo);
	
}
