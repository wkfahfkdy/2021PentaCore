package com.yedam.storage.mystorage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.storage.service.StorageService;

@Controller
public class MyStorageController {
	
	@Autowired
	private StorageService storageDAO;
	
	
	@RequestMapping("keep")
	public String gokeep() {
		
		return "myStorage/keep";
	}
	
	@RequestMapping("useForm")
	public String useForm(Model model) {
		
		model.addAttribute("storageList", storageDAO.storageSelectList());
		
		return "myStorage/infoUse";
	}

}
