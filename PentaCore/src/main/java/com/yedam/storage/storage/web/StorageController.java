package com.yedam.storage.storage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.storage.service.StorageService;

@Controller
public class StorageController {
	
	@Autowired
	private StorageService storageDAO;
	
	@RequestMapping("/storageList")
	public String storageList(Model model) {
		model.addAttribute("TestList", storageDAO.storageSelectList());
		return "storage/storageList";
	}
	
}
