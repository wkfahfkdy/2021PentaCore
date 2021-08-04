package com.yedam.storage.review.web;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.review.common.Paging;
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
			int firstCnt = (pageCnt - 1) * 10 + 1; // 1 , 11 ,21
			int lastCnt = (pageCnt * 10); // 10 , 20 , 30
			vo.setFirstCnt(firstCnt);
			vo.setLastCnt(lastCnt);
			
			List<ReviewVO> total = reviewDAO.reviewList();//전체 검색결과
			Paging paging = new Paging();
			paging.setPageNo(pageCnt);//요청받은 페이지
			paging.setPageSize(10);//한페이지에 보여줄 값
			paging.setTotalCount(total.size());//페이지에 필요한 변수 생성
		    
			model.addAttribute("paging", paging);//페이징에 필요한 값
			model.addAttribute("reviewList", reviewDAO.reviewListPaging(vo));//검색 결과중 페이지에 요청된 페이지에 띄울 결과들
			return "review/reviewList";
		}
	
	
}
