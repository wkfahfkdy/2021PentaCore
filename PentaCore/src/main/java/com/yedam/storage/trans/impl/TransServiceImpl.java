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
		// select Box
		return sqlSession.selectList("cuStorage", vo);
	}

	@Override
	public int customerInsert(TransVO vo) {
		// 추가입력
		return sqlSession.update("customerInsert", vo);
	}

	@Override
	public int customerFileup(TransVO vo) {
		// 사후관리 사진+메모 등록
		return sqlSession.update("customerFileup", vo);
	}

	@Override
	public TransVO FileupSelect(TransVO vo) {
		// 사후관리 상세내역
		return sqlSession.selectOne("FileupSelect", vo);
	}

	@Override
	public List<TransVO> conveyFullList() {
		// 캘린더 운송 리스트
		return sqlSession.selectList("conveyFullList");
	}

	@Override
	public List<TransVO> conveyStoreList(TransVO vo) {
		return sqlSession.selectList("conveyStoreList", vo);
	}
	

	
}
