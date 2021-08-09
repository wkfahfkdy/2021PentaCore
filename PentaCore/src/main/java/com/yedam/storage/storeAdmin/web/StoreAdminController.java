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

import com.yedam.storage.review.common.Paging;
import com.yedam.storage.storeAdmin.serviceImpl.StoreAdminServiceImpl;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@Controller
public class StoreAdminController {

	@Autowired
	private StoreAdminServiceImpl storeAdminDAO;
	
	
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
	@RequestMapping("usedStorage")
	@ResponseBody
	public StoreAdminVO usedStorage(Model model, HttpServletRequest req, StoreAdminVO vo) {
		System.out.println(vo.getOffer_code() + vo.getStore_code());
		return storeAdminDAO.selectStorageInfo(vo);
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

	//고객관리 페이지 이동
	@RequestMapping("store/customerManage")
	public String LoginIdCheck(Model model , StoreAdminVO vo , HttpServletRequest req) {
				
		
				//이용중인 고객 리스트  
		
				String page = req.getParameter("page");
				//요청받은 페이지번호
				if(page == null) {
					page = "1";
				}
				//10개씩 페이징
				int pageCnt = Integer.parseInt(page);
				int firstCnt = (pageCnt - 1) * 5 + 1; // 1 , 11 ,21
				int lastCnt = (pageCnt * 5); // 10 , 20 , 30
				vo.setFirstCnt(firstCnt);
				vo.setLastCnt(lastCnt);
				
				List<StoreAdminVO> total = storeAdminDAO.usingStrorageList();//전체 검색결과
				Paging paging = new Paging();
				paging.setPageNo(pageCnt);//요청받은 페이지
				paging.setPageSize(8);//한페이지에 보여줄 값
				paging.setTotalCount(total.size());//페이지에 필요한 변수 생성
				
				
				
			    
				model.addAttribute("paging", paging);//페이징에 필요한 값
				model.addAttribute("usingStorageList", storeAdminDAO.usingStrorageListPaging(vo));//검색 결과중 페이지에 요청된 페이지에 띄울 결과들
				return "storeAdmin/customerManage";
			
	
	}
	
	// 카카오 지도 API TEST - DATA
		@RequestMapping("store/usingList")
		@ResponseBody
		public List<StoreAdminVO> usingList() {
			// Store - 지점명, 지점주소 (StoreConlloer)
			List<StoreAdminVO> list = storeAdminDAO.usingStrorageList();
			return list;
		}
	
				
	
	
	
	@RequestMapping("store/customerManage2")
	public String LoginIdCheck(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		return "storeAdmin/customerManage2";
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