package com.yedam.storage.trans.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	
	@RequestMapping("customer")
	public String customer(Model model, TransVO vo) {

		model.addAttribute("customerListAll", transDAO.coustomerListAll(vo));
		System.out.println(vo);
		
		return "empty/empty/customer";
	}
	
	@RequestMapping(value="myCustomer/{apply_code}", method=RequestMethod.GET)
	@ResponseBody
	public TransVO myCustomer(@PathVariable String apply_code, Model model, TransVO vo) {
		
		vo.setApply_code(apply_code);
		System.out.println(apply_code);
		
		model.addAttribute("myCoustomerSelect", transDAO.myCoustomerSelect(vo));
		
		return transDAO.myCoustomerSelect(vo);
	}
	
}
