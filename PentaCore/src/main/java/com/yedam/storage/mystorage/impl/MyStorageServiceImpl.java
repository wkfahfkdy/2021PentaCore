package com.yedam.storage.mystorage.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.yedam.storage.mystorage.service.MyStorageService;
import com.yedam.storage.mystorage.vo.MyStorageVO;

@Service("myStorageDAO")
public class MyStorageServiceImpl implements MyStorageService {

	@Override
	public List<MyStorageVO> keepList() {
		// test
		return null;
	}
	
	@Override
	public int keepInsert() {
		// 보관이사 신청
		return 0;
	}


}
