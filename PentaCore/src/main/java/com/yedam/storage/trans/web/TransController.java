package com.yedam.storage.trans.web;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.trans.service.TransService;
import com.yedam.storage.trans.vo.TransVO;

@Controller
public class TransController {
	@Autowired
	private TransService transDAO;
	
	@RequestMapping("schedule")
	public String schedule() {
		
		return "empty/empty/schedule";
	}
	
	
	@RequestMapping("admin/customer")
	public String customer(Model model, TransVO vo) {

		model.addAttribute("customerListAll", transDAO.coustomerListAll(vo));
		List<TransVO> vo2 = transDAO.coustomerListAll(vo);
		System.out.println(vo2);
		
		return "empty/empty/customer";
	}
	
}
