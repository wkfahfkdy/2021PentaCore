package com.yedam.storage.mypage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.mypage.service.MyPageService;
import com.yedam.storage.mypage.vo.MyPageVO;

@Controller
public class MyPageController {
	@Autowired
	private MyPageService MyPageDAO;
	
	@RequestMapping("myPageInfo")
	public String myPageInfo(Model model, MyPageVO vo) {	// Mypage 첫화면
		
		//test용 data
		String s_code = "ST002";
		vo.setStore_code(s_code);

		String id = "user10";
		vo.setMember_id(id);
		
	
		String notice = null;
		String useService = null;
		
		if(s_code != null) {
			model.addAttribute("noticeSelectList", MyPageDAO.noticeSelectList(vo));
			model.addAttribute("usedStorageList", MyPageDAO.usedStorageList(vo));
		}
		else {
			notice = "아직 이용 중인 지점이 없습니다.";
			useService = "아직 이용 중인 보관 서비스가 없습니다.";
			model.addAttribute("notice", notice);
			model.addAttribute("useService", useService);
		}
		return "myPage/myPageInfo";
	}
	
	@RequestMapping("offerList")
	public String offerList(Model model, MyPageVO vo) {
		//Test data
		String id = "user10";
		vo.setMember_id(id);
		
		model.addAttribute("offerSelectList",MyPageDAO.offerSelectList(vo));
		
		return "myPage/offerList";
	}
}
