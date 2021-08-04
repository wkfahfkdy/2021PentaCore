package com.yedam.storage.mystorage.service;

import java.util.List;

import com.yedam.storage.mystorage.vo.MyStorageVO;

public interface MyStorageService {
	
	//안심보관이사
	public List<MyStorageVO> keepList();
	public int keepInsert(MyStorageVO vo);

}
