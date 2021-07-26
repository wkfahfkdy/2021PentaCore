package com.yedam.mypage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.mypage.service.MyPageService;

@Controller
public class MyPageController {
	@Autowired
	private MyPageService MyPageDAO;
	
	@RequestMapping("/myPageInfo")
	public String myPageInfo(Model model) {
		model.addAttribute("noticeList", MyPageDAO.noticeSelectList());
		model.addAttribute("usingInfo", MyPageDAO.usedStorageList());
		return "myPage/myPageInfo";
	}
}
