package com.yedam.storage.mystorage.map;

import java.util.List;

import com.yedam.storage.mystorage.vo.MyStorageVO;

public interface MyStorageMap {

	//안심보관이사
	public List<MyStorageVO> keepList();
	public int keepInsert();
	
}
