package com.yedam.storage.storeAdmin.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	
	@RequestMapping("storeNotice")
	public String noticeList(HttpServletRequest req, StoreAdminVO vo, Model model) {
		HttpSession session = req.getSession();
		String s_code = (String) session.getAttribute("stCode");
		System.out.println(s_code);
		
		vo.setStore_code(s_code);
		
		model.addAttribute("storeNotice", storeAdminDAO.storeNoticeList(vo));
		return "storeAdmin/storeNoticeList";
	}
	
	@RequestMapping("noticeForm")
	public String noticeForm() {
		return "storeAdmin/noticeForm";
	}
	
	@RequestMapping("registNotice")
	public String registNotice(StoreAdminVO vo) {
		storeAdminDAO.registNotice(vo);
		return "storeAdmin/enterStoreAdmin";
	}
			
			
		
}
