package com.yedam.storage.store.map;

import java.util.List;

import com.yedam.storage.store.vo.StoreVO;

public interface StoreMap {
	
	public List<StoreVO> SelectStoreAddr();
	public List<StoreVO> htSelect(StoreVO vo);

}
