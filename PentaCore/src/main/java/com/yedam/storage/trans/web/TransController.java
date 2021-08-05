package com.yedam.storage.trans.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TransController {
	
	@RequestMapping("schedule")
	public String schedule() {
		
		return "empty/empty/schedule";
	}
	
	
	@RequestMapping("customer")
	public String customer() {
		
		return "empty/empty/customer";
	}
	
}
