package com.yedam.storage.center.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.center.service.CenterService;

@Controller
public class CenterController {
	
	@Autowired
	private CenterService CenterDAO;
	
	@RequestMapping("faqList")
	public String faqList(Model model) {
		
		model.addAttribute("faqSelectList", CenterDAO.faqSelectList());
	
		return "faq/faqList";
	}
}