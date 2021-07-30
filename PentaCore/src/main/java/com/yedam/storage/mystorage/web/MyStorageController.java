package com.yedam.storage.mystorage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.mystorage.service.MyStorageService;

@Controller
public class MyStorageController {
	
	@Autowired
	private MyStorageService MyStorageDAO;
	
	@RequestMapping("infofUse")
	public String goinfofUse() {
		
		return "myStorage/infoUse";
	}
	
	@RequestMapping("keep")
	public String gokeep() {
		
		return "myStorage/keep";
	}

}
