package com.yedam.storage.center.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.center.service.CenterService;
import com.yedam.storage.center.vo.CenterVO;

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
	public List<CenterVO> inquirySelectList() {
		// 1:1문의 조회
		return sqlSession.selectList("inquirySelectList");
	}

	@Override
	public int inquiryInsert() {
		// 1:1문의 작성
		return 0;
	}

	@Override
	public int inquiryUpdate() {
		// 1:1문의 수정
		return 0;
	}

	@Override
	public int inquiryDelete() {
		// 1:1문의 삭제
		return 0;
	}

	@Override
	public List<CenterVO> replyList() {
		// 리플 조회
		return null;
	}

	@Override
	public int replyInsert() {
		// 리플 등록
		return 0;
	}

	@Override
	public int replyUpdate() {
		// 리플 수정
		return 0;
	}

	@Override
	public int replyDelete() {
		// 리플 삭제
		return 0;
	}
	
}
