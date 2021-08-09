package com.yedam.storage.trans.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	// 신청내역
	@RequestMapping("customer")
	public String customer(Model model, TransVO vo) {

		model.addAttribute("customerListAll", transDAO.customerListAll(vo));
		System.out.println(vo);
		
		return "empty/empty/customer";
	}
	
	// 모달창 list
	@RequestMapping(value="myCustomer/{apply_code}", method=RequestMethod.GET)
	@ResponseBody
	public TransVO myCustomerSelect(@PathVariable String apply_code, Model model, TransVO vo) {
		

		vo.setApply_code(apply_code);
		System.out.println(apply_code);

		model.addAttribute("cuStorage", transDAO.cuStorage(vo));
		System.out.println("123");
		System.out.println(vo);
		
		return transDAO.myCustomerSelect(vo);
	}
	
}
