package com.yedam.storage.trans.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.trans.service.TransService;
import com.yedam.storage.trans.vo.TransVO;

@Service("transDAO")
public class TransServiceImpl implements TransService {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<TransVO> customerListAll(TransVO vo) {
		// 운송팀 list
		return sqlSession.selectList("customerListAll", vo);
	}

	@Override
	public TransVO myCustomerSelect(TransVO vo) {
		// list 상세조회
		return sqlSession.selectOne("myCustomerSelect", vo);
	}

	@Override
	public List<TransVO> cuStorage(TransVO vo) {
		// select 
		return sqlSession.selectList("cuStorage", vo);
	}
	

	
}
