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
		
		String msg = null;
		
		if(vo.getStore_code() != null) {
			model.addAttribute("noticeSelectList", MyPageDAO.noticeSelectList(vo));
			model.addAttribute("usedStorageList", MyPageDAO.usedStorageList(vo));
		}
		else {
			msg = "아직 이용 중인 지점이 없습니다.";
			model.addAttribute("notUsedStore", msg);
		}
		
	
		return "myPage/myPageInfo";
	}
}
