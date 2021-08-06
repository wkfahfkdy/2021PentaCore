package com.yedam.storage.storeAdmin.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yedam.storage.storeAdmin.serviceImpl.StoreAdminServiceImpl;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@Controller
public class StoreAdminController {

	@Autowired
	private StoreAdminServiceImpl storeAdminDAO;
	
	
	@RequestMapping("store/customerManage")
	public String LoginIdCheck(Model model) {
		
		
		List<StoreAdminVO> usingStorageList = storeAdminDAO.usingStrorageList();
		model.addAttribute("usingStorageList", usingStorageList);
		
		return "storeAdmin/customerManage";
		
	}
	
	
	@RequestMapping("")
	public String LoginIdCheck(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		return null;
		
	}
			
			
		
}
