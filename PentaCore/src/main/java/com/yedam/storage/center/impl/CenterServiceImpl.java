package com.yedam.storage.center.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.center.service.CenterService;
import com.yedam.storage.center.vo.CenterVO;
import com.yedam.storage.paging.paging;

@Repository("centerDAO")
public class CenterServiceImpl implements CenterService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<CenterVO> faqSelectList() {
		// FAQ 목록
		return sqlSession.selectList("faqSelectList");
	}

	@Override
	public List<paging> inquirySelectList(CenterVO vo) {
		// 1:1문의 조회
		return sqlSession.selectList("inquirySelectList", vo);
	}
	
	@Override
	public List<paging> inquiryPaging(CenterVO vo) {
		// 1:1문의 페이징
		return sqlSession.selectList("inquiryPaging", vo);
	}

	@Override
	public List<CenterVO> replyList(CenterVO vo) {
		// 내가쓴글조회
		return sqlSession.selectList("replyList", vo);
	}
	
	@Override
	public int inquiryInsert(CenterVO vo) {
		// 1:1문의 작성
		return sqlSession.insert("inquiryInsert", vo);
	}

	@Override
	public int inquiryDelete(CenterVO vo) {
		// 1:1문의 삭제
		return sqlSession.delete("inquiryDelete", vo);
	}


	@Override
	public int replyInsert() {
		// 리플 등록
		return 0;
	}

	@Override
	public int replyDelete() {
		// 리플 삭제
		return 0;
	}


}
