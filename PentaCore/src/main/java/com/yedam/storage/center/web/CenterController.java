package com.yedam.storage.center.web;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.center.service.CenterService;
import com.yedam.storage.center.vo.CenterVO;

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
	
	// 내가쓴글 조회
	@RequestMapping("replyList")
	public String replyList(Model model) {
		
		model.addAttribute("replyList", CenterDAO.replyList());
		
		return "inquiry/replyList";
	}
	
	// 1:1문의 
	@RequestMapping("inquiryInsert")
	public String inquiryInsert(HttpServletRequest req, CenterVO vo) {
		
		//HttpSession session = req.getSession();
		
		//String userId = (String) session.getAttribute("loginMemberId");
		vo.setMember_id("user1");
		
		//System.out.println(vo.getMember_id());
		//System.out.println(vo.getQuestion_content());
		
		CenterDAO.inquiryInsert(vo);
		
		return "redirect:iqList";
	}
	
}
