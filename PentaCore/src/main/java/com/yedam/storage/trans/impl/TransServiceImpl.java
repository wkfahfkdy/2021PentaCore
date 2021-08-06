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
	public List<TransVO> coustomerListAll(TransVO vo) {
		// 운송팀 list
		return sqlSession.selectList("coustomerListAll", vo);
	}

	@Override
	public TransVO myCoustomerSelect(TransVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
}
