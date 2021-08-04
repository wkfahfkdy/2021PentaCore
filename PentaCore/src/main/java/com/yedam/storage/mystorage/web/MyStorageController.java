package com.yedam.storage.mystorage.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.mystorage.service.MyStorageService;
import com.yedam.storage.mystorage.vo.MyStorageVO;
import com.yedam.storage.storage.service.StorageService;

@Controller
public class MyStorageController {
	
	@Autowired
	private MyStorageService myStorageDAO;

	@Autowired
	private StorageService storageDAO;

	// 이용안내 페이지
	@RequestMapping("useForm")
	public String useForm(Model model, HttpServletRequest request) {
		
		String id = null;
		if(request.getSession().getAttribute("loginId") == null) {
			id = "no";
		}

		model.addAttribute("chk", id);
		model.addAttribute("storageList", storageDAO.storageSelectList());
		
		return "myStorage/infoUse";
	}	
	
	// 안심보관이사 페이지
	@RequestMapping("keep")
	public String gokeep(HttpServletRequest request, Model model) {
		
		String id = null;
		if(request.getSession().getAttribute("loginId") == null) {
			id = "no";
		}

		model.addAttribute("chk", id);
		
		return "myStorage/keep";
	}
	
	// 안심보관이사 신청
	@RequestMapping("keepInsert")
	public String keepInsert(HttpServletRequest req, MyStorageVO vo) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		System.out.println(vo);
		
		myStorageDAO.keepInsert(vo);
		
		return "redirect:keep";
	}

}
