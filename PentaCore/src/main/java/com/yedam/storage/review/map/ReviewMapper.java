package com.yedam.storage.review.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import com.yedam.storage.mypage.vo.MyPageVO;
import com.yedam.storage.review.vo.ReviewVO;


@MapperScan
public interface ReviewMapper {
	
	//리스트 출력
	public List<ReviewVO> reviewList();
	public List<ReviewVO> reviewListPaging(ReviewVO vo);
	
	//리뷰 상세보기
	public ReviewVO selectReview(@Param("p") String reviewNum);
	
	//리뷰 수정
	public int reviewUpdate(ReviewVO vo);
	
	//리뷰 삭제
	public int reviewDelete(ReviewVO vo);
	
	// 메인 리뷰 리스트
	public List<ReviewVO> mainPageReviewList();
}