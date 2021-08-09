package com.yedam.storage.store.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.store.service.StoreService;
import com.yedam.storage.store.vo.StoreVO;

@Repository
public class StoreServiceImpl implements StoreService {

	@Autowired
	private SqlSessionTemplate map;
	
	@Override
	public List<StoreVO> SelectStoreAddr() {
		
		return map.selectList("SelectStoreAddr");
	}
	

}
