package com.yedam.storage.storeAdmin.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.store.service.StoreService;
import com.yedam.storage.review.common.Paging;
import com.yedam.storage.review.vo.ReviewVO;
import com.yedam.storage.storeAdmin.serviceImpl.StoreAdminServiceImpl;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@Controller
public class StoreAdminController {

	@Autowired
	private StoreAdminServiceImpl storeAdminDAO;
	
	@Autowired
	private StoreService storeDAO;
	
	// enterStoreAdmin -> StorageInfoPage (각 지점에 대한 스토리지 현황을 위해 Store_code를 불러온다)
	@RequestMapping("storageInfo")
	public String storageInfo(Model model, HttpServletRequest req, StoreAdminVO vo) {
		String store_code = req.getParameter("store_code");
		System.out.println(store_code);
		vo.setStore_code(store_code);
		model.addAttribute("StorageInfoList", storeAdminDAO.selectStorageInfoList(vo));
		model.addAttribute("storageName", storeAdminDAO.storageName());
		return "storeAdmin/StorageInfoPage";
	}
	
	// 사용중인 스토리지 정보
			@RequestMapping("store/usedStorage")
			public String usedStorage(Model model, HttpServletRequest req, StoreAdminVO vo) {
				return "storeAdmin";
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
			
	
	/////////////////////////////////전형민////////////////////////////////////////////
	//지점관리자 홈으로 이동
	@RequestMapping("store/enterStoreAdmin")
	public String storeAdminHome() {
	return "storeAdmin/enterStoreAdmin";
	}
	
	
	// 이용중인 사용자 리스트
	@RequestMapping("store/usingList")
	@ResponseBody
	public List<StoreAdminVO> usingList() {
	// Store - 지점명, 지점주소 (StoreConlloer)
	List<StoreAdminVO> list = storeAdminDAO.usingStrorageList();
	return list;
	}
	
	// 사용종료 사용자 리스트
		@RequestMapping("store/expiredList")
		@ResponseBody
		public List<StoreAdminVO> expiredList() {
		// Store - 지점명, 지점주소 (StoreConlloer)
		List<StoreAdminVO> list = storeAdminDAO.expiredStrorageList();
		return list;
		}
	
	@RequestMapping("store/customerManage2")
	public String LoginIdCheck(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
	return "storeAdmin/customerManage2";
	}
	

	@RequestMapping("store/storageUserDetail")
	public String storageUserDetail(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		String use_num = request.getParameter("use_num");
		StoreAdminVO rvo = storeAdminDAO.storageUserDetail(use_num);
		
		model.addAttribute("selectUserVO", rvo);
		
		return "storeAdmin/storageUserDetail";
	}	
	
	@RequestMapping("store/expiredUserDetail")
	public String expiredUserDetail(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		String member_id = request.getParameter("memberId");
		return "storeAdmin/storageUserDetail";		
	}
	
	/////////////////////////////////전형민////////////////////////////////////////////		
			
}
