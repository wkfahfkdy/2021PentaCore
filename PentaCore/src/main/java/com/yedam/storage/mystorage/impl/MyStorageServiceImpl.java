package com.yedam.storage.mystorage.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.mystorage.service.MyStorageService;
import com.yedam.storage.mystorage.vo.MyStorageVO;

@Service("myStorageDAO")
public class MyStorageServiceImpl implements MyStorageService {

	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<MyStorageVO> keepList() {
		// test
		return null;
	}
	
	@Override
	public int keepInsert(MyStorageVO vo) {
		// 보관이사 신청
		return sqlSession.insert("keepInsert", vo);
	}


}
