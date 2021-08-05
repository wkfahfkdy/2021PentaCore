package com.yedam.storage.review.serviceImpl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.review.service.ReviewService;
import com.yedam.storage.review.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public List<ReviewVO> reviewList() {
		return sqlSession.selectList("reviewList");
	}


	@Override
	public List<ReviewVO> reviewListPaging(ReviewVO vo) {
		return sqlSession.selectList("reviewListPaging", vo);
	}


	@Override
	public ReviewVO selectReview(String reviewNum) {
		return sqlSession.selectOne("selectReview", reviewNum);
	}
	
	
	
	/*
	 * @Override public List<ReviewVO> reviewList(@Param("count") int count) {
	 * return sqlSession.selectList("reviewList", count); }
	 */	
	
}
