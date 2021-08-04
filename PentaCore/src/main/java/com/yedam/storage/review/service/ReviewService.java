package com.yedam.storage.review.service;


import java.util.List;

import com.yedam.storage.review.vo.ReviewVO;

public interface ReviewService {

	//리스트 출력
		public List<ReviewVO> reviewList();
		public List<ReviewVO> reviewListPaging(ReviewVO vo);
}
