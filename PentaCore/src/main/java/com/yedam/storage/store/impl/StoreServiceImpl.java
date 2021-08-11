package com.yedam.storage.store.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.store.service.StoreService;
import com.yedam.storage.store.vo.StoreVO;

@Service("storeDAO")
public class StoreServiceImpl implements StoreService {

	@Autowired
	private SqlSessionTemplate map;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<StoreVO> SelectStoreAddr() {
		
		return map.selectList("SelectStoreAddr");
	}

	@Override
	public List<StoreVO> htSelect(StoreVO vo) {
		// 메인화면 온습도
		return sqlSession.selectList("htSelect", vo);
	}
	

}
