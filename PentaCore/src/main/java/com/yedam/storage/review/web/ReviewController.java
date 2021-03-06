package com.yedam.storage.review.web;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.paging.paging;
import com.yedam.storage.review.serviceImpl.ReviewServiceImpl;
import com.yedam.storage.review.vo.ReviewVO;


@Controller
public class ReviewController {

	@Autowired
	private ReviewServiceImpl reviewDAO;
	
	
	
	// ------------------------------- 이용후기 ------------------------------ //
	
	//이용후기 페이지 이동
		
		@RequestMapping("reviewList")
		public String newBook(Model model , ReviewVO vo , HttpServletRequest req) {
			String page = req.getParameter("page");
			//요청받은 페이지번호
			if(page == null) {
				page = "1";
			}
			//10개씩 페이징
			int pageCnt = Integer.parseInt(page);
			int firstCnt = (pageCnt - 1) * 8 + 1; // 1 , 11 ,21
			int lastCnt = (pageCnt * 8); // 10 , 20 , 30
			vo.setFirstCnt(firstCnt);
			vo.setLastCnt(lastCnt);
			
			List<ReviewVO> total = reviewDAO.reviewList();//전체 검색결과
			paging paging = new paging();
			paging.setPageNo(pageCnt);//요청받은 페이지
			paging.setPageSize(8);//한페이지에 보여줄 값
			paging.setTotalCount(total.size());//페이지에 필요한 변수 생성
			
			
			
		    
			model.addAttribute("paging", paging);//페이징에 필요한 값
			model.addAttribute("reviewList", reviewDAO.reviewListPaging(vo));//검색 결과중 페이지에 요청된 페이지에 띄울 결과들
			return "review/reviewList";
		}
		
		//이용후기 상세페이지
		
		@RequestMapping("reviewDetail")
			public String reviewDetail(Model model , HttpServletRequest req ) {
			String review_num = req.getParameter("review_num");
			ReviewVO rvo = reviewDAO.selectReview(review_num);
			
			String content="";
			
			if(rvo.getReview_content() == null) {
				rvo.setReview_content("   ");
				content = rvo.getReview_content().substring(0,3);
			}
			
			if(rvo.getReview_content().length() >=3) {
				content = rvo.getReview_content().substring(0,3);
			}
			
			
			model.addAttribute("imageCheck",content); //사용자가 이미지 파일 첨부했으면 상세보기에 지점사진 안들어가게하기.
			
			
			model.addAttribute("reviewVO",rvo);
			model.addAttribute("review_num", review_num);// 리뷰 번호 넘기기
			
			return "review/reviewDetail";
			}
		
		
		// 리뷰 업데이트 페이지 이동
			@RequestMapping("reviewUpdateForm")
			public String reviewUpdateForm(Model model, HttpServletRequest req, ReviewVO vo) {
				
				String review_title = req.getParameter("review_title");
				String review_content = req.getParameter("review_content");
				String review_num = req.getParameter("review_num");
				
				model.addAttribute("review_title",review_title);
				model.addAttribute("review_content",review_content);
				model.addAttribute("review_num",review_num);
				
				return "review/reviewUpdateForm";
			}

			
		// 리뷰 업데이트
		@RequestMapping("reviewUpdate")
		public String reviewRegist(HttpServletRequest req, ReviewVO vo) {
			
			if(vo.getReview_content() == null) {
				vo.setReview_content("");
			}
			
			reviewDAO.reviewUpdate(vo);
			return "redirect:reviewList";
		}
		
		// 리뷰 삭제
		@RequestMapping("reviewDelete")
		public String reviewDelete(HttpServletRequest req, ReviewVO vo) {
			String review_num = req.getParameter("review_num");
			vo.setReview_num(Integer.parseInt(review_num));	
					
			reviewDAO.reviewDelete(vo);
			return "redirect:reviewList";
			}
	
}
