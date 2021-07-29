package com.yedam.storage.center.web;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.center.service.CenterService;
import com.yedam.storage.center.vo.CenterVO;
import com.yedam.storage.paging.paging;

@Controller
public class CenterController {
	
	@Autowired
	private CenterService CenterDAO;
	
	// FAQ 리스트 조회
	@RequestMapping("faqList")
	public String faqList(Model model) {
		
		model.addAttribute("faqSelectList", CenterDAO.faqSelectList());
	
		return "faq/faqList";
	}
	
	// 1:1문의 리스트 조회
	@RequestMapping("iqList") 
	public String inquirySelectList(Model model) {
		
		model.addAttribute("inquirySelectList", CenterDAO.inquirySelectList());
		
		return "inquiry/iqList";
	}
	
	// paging
	@RequestMapping("inquiryPaging")
	public String inquiryPaging(Model model, HttpServletRequest request) {
		
		String page = request.getParameter("page");
		
		List<paging> list = new ArrayList<>();
		List<paging> total = new ArrayList<>();
		
		if (page == null) page = "1";
		
		int ipage = Integer.parseInt(page);

		CenterVO vo = new CenterVO();
		vo.setFirstRecordIndex(1+(ipage-1)*10);
		vo.setLastRecordIndex(10*ipage);
		vo.setTotalCnt(CenterDAO.tableCnt());
		
		list = CenterDAO.inquiryPaging(vo);
		total = CenterDAO.inquirySelectList();
		
		paging paging = new paging();
		paging.setPageNo(ipage);
		paging.setPageSize(10);
		paging.setTotalCount(total.size());
		
		model.addAttribute("bolist", list);
		model.addAttribute("paging", paging);
		
		return "inquiry/iqPaging";
		
	}
	
	
	// 내가쓴글 조회
	@RequestMapping("replyList")
	public String replyList(Model model, CenterVO vo) {

		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		vo.setMember_id(userDetails.getUsername());
		
		model.addAttribute("replyList", CenterDAO.replyList());
		
		return "inquiry/replyList";
	}
	
	
	// 1:1문의 
	@RequestMapping("inquiryInsert")
	public String inquiryInsert(HttpServletRequest req, CenterVO vo) {
		
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		vo.setMember_id(userDetails.getUsername());
		
		CenterDAO.inquiryInsert(vo);
		
		return "redirect:iqList";
	}
	
}
