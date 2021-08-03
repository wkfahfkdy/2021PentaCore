package com.yedam.storage.review.web;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.review.serviceImpl.ReviewServiceImpl;
import com.yedam.storage.review.vo.ReviewVO;


@Controller
public class ReviewController {

	@Autowired
	private ReviewServiceImpl reviewDAO;
	
	
	
	// ------------------------------- 이용후기 ------------------------------ //
	
	//이용후기 페이지 이동
		@RequestMapping("reviewList")
		public String loginForm(HttpServletRequest request, Model model) {
			
			List<ReviewVO> list1 = reviewDAO.reviewList(0);
			List<ReviewVO> list2 = reviewDAO.reviewList(6);
			List<ReviewVO> list3 = reviewDAO.reviewList(12);
			

			request.setAttribute("list1", list1);
			request.setAttribute("list2", list2);
			request.setAttribute("list3", list3);
			
			return "review/reviewList";
		}
		
	
	
	
}
