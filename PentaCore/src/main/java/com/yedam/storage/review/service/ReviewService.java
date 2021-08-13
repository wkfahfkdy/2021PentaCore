package com.yedam.storage.review.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yedam.storage.review.vo.ReviewVO;

public interface ReviewService {

	//리스트 출력
		public List<ReviewVO> reviewList();
		public List<ReviewVO> reviewListPaging(ReviewVO vo);
		public ReviewVO selectReview(@Param("p") String reviewNum);
		
	// 메인 리뷰 리스트
		public List<ReviewVO> mainPageReviewList();
}
