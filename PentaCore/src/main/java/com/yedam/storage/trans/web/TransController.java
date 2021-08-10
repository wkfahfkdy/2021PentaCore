package com.yedam.storage.trans.web;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.trans.service.TransService;
import com.yedam.storage.trans.vo.TransVO;

@Controller
public class TransController {
	@Autowired
	private TransService transDAO;
	
	// 스케줄
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
	@RequestMapping(value="myCustomer", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> myCustomerSelect(Model model, TransVO vo) {
		System.out.println("123");
		System.out.println(vo.getApply_code() + vo.getStore_code());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cus", transDAO.myCustomerSelect(vo));
		map.put("list", transDAO.cuStorage(vo));
		System.out.println("1 : " + transDAO.myCustomerSelect(vo));
		System.out.println("2 : " + transDAO.cuStorage(vo));
		return map;
	}
	
	//추가입력
	@RequestMapping("customerInsert")
	public String customerInsert(TransVO vo) {
		
		transDAO.customerInsert(vo);
		
		return "redirect:customer";
	}

	// 사후관리 페이지이동
	@RequestMapping("FileupSelect")
	public String FileupPage(@RequestParam("apply_code") String apply_code, Model model, TransVO vo) {
		
		model.addAttribute("apply_code", apply_code);
		System.out.println(apply_code);
		model.addAttribute("FileupSelect", transDAO.FileupSelect(vo));
		System.out.println(vo);
		
		return "empty/empty/customerFileup";
	}
	
	
	// file upload
	@RequestMapping("customerFileup")
	public String customerFileup(TransVO vo) {
		
		System.out.println("123");
		transDAO.customerFileup(vo);
		
		
		return "redirect:customer";
	}
}
