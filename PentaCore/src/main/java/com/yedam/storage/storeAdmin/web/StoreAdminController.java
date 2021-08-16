package com.yedam.storage.storeAdmin.web;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yedam.storage.review.common.Paging;
import com.yedam.storage.store.vo.StoreVO;
import com.yedam.storage.storeAdmin.service.StoreAdminService;
import com.yedam.storage.storeAdmin.serviceImpl.StoreAdminServiceImpl;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@Controller
public class StoreAdminController {

	@Autowired
	private StoreAdminServiceImpl storeAdminDAO;
	@Autowired
	private StoreAdminService storeService;
	
	// ===================== 정동영 ===================================
	// enterStoreAdmin -> StorageInfoPage (각 지점에 대한 스토리지 현황을 위해 Store_code를 불러온다) + 현재 예약되어있는 정보 List
	@RequestMapping("storageInfo")
	public String storageInfo(HttpServletRequest req , Model model, StoreAdminVO vo, StoreVO vo1) {
		HttpSession session = req.getSession();
		String store_code = (String) session.getAttribute("store_code");
		vo.setStore_code(store_code);
		vo1.setStore_code(store_code);
		model.addAttribute("StorageInfoList", storeAdminDAO.selectStorageInfoList(vo));
		model.addAttribute("storageName", storeAdminDAO.storageName());
		// 현재 예약되어있는 정보 List
		model.addAttribute("offerInfoList", storeService.offerInfoList(vo));
		// 현재 지점의 온습도 저보
		model.addAttribute("stroeTemHumInfo", storeService.storeTemHumInfo(vo1));
		return "storeAdmin/StorageInfoPage";
	}
	
	// 사용중인 스토리지 정보
	@RequestMapping("usedStorage")
	@ResponseBody
	public StoreAdminVO usedStorage(Model model,  StoreAdminVO vo) {
		System.out.println(vo.getOffer_code() + vo.getStore_code());
		return storeAdminDAO.selectStorageInfo(vo);
	}
	
	// 현재 예약되어 있는 정보 (Ajax)
	@RequestMapping("ajaxOfferInfoList")
	@ResponseBody
	public List<StoreAdminVO> offerInfoList(StoreAdminVO vo){
		return storeService.offerInfoList(vo);
	}
	
	// 미사용 스토리지 및 스토리지 예약을 한 정보 (Ajax)
	@RequestMapping("offerInfo")
	@ResponseBody
	public Map<String, Object> offerInfo(Model model, StoreAdminVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selectOfferInfo", storeService.selectOfferInfo(vo));
		map.put("unUseStorage", storeService.unUseStorageList(vo));
		return map;
	}
	
	// use_storage 업데이트
	@RequestMapping("updateUseStorage")
	public String updateUseStorage(@RequestParam("store_code") String store_code , StoreAdminVO vo, RedirectAttributes red) {
		storeService.useStroageUpdate(vo);
		red.addAttribute("store_code", store_code);
		return "redirect:storageInfo";
	}
	
	// 온습도 관리 update
	@RequestMapping("temHumUpdate")
	public String updateStoreTemHum(@RequestParam("store_code") String store_code , StoreVO vo, RedirectAttributes red) {
		storeService.storeTemHumUpdate(vo);
		red.addAttribute("store_code", store_code);
		return "redirect:storageInfo";
	}
	
	//================= 정동영 ===================================
	//====================== 최반야 ====================================
	// 지점 공지사항 리스트
	@RequestMapping("storeNotice")
	public String noticeList(HttpServletRequest req, StoreAdminVO vo, Model model) {
		HttpSession session = req.getSession();
		String s_code = (String) session.getAttribute("stCode");
		System.out.println(s_code);
		
		vo.setStore_code(s_code);
		model.addAttribute("storeNotice", storeAdminDAO.storeNoticeList(vo));
		return "storeAdmin/storeNoticeList";
	}
	
	// 지점 공지사항 등록 form 페이지 이동
	@RequestMapping("noticeForm")
	public String noticeForm(StoreAdminVO vo) {
		return "storeAdmin/noticeForm";
	}
	
	// 지점 공지사항 등록
	@RequestMapping("registNotice")
	public String registNotice(HttpServletRequest req, StoreAdminVO vo) {
		HttpSession session = req.getSession();
		String s_code = (String)session.getAttribute("stCode");
		vo.setStore_code(s_code);
		storeAdminDAO.registNotice(vo);
		return "redirect:storeNotice";
	}
	
	// 지점 공지사항 상세 및 수정 페이지 모달로 전송
	@ResponseBody
	@RequestMapping(value="storeNoticeSelect/{notice_num}", method=RequestMethod.GET)
	public StoreAdminVO storeNoticeSelect(@PathVariable int notice_num, Model model, StoreAdminVO vo) {
		vo.setNotice_num(notice_num);
		
		return storeAdminDAO.storeNoticeSelect(vo);
	}  
	
	// 지점 공지사항 수정
	@ResponseBody
	@RequestMapping("editNotice")
	public String storeNoticeEdit(StoreAdminVO vo) {
		String result = "";
		
		int up = storeAdminDAO.storeNoticeEdit(vo);
		
		if(up > 0)
			result = "update success";
		
		return result;
	}
	
	// 지점 공지사항 삭제
	@ResponseBody
	@RequestMapping(value="deleteNotice/{notice_num}", method=RequestMethod.GET)
	public String storeNoticeDelete(StoreAdminVO vo) {
		String result = "";
		
		int del = storeAdminDAO.storeNoticeDelete(vo);
		
		if(del > 0)
			result = "delete success";
		return result;
	}
	
	//====================== 최반야 ====================================
	
	/*
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
	*/
	/////////////////////////////////전형민////////////////////////////////////////////
	//지점관리자 홈으로 이동
	@RequestMapping("store/enterStoreAdmin")
	public String storeAdminHome() {
	return "storeAdmin/enterStoreAdmin";
	}
	
	
	// 이용중인 사용자 리스트
	@RequestMapping("usingList")
	@ResponseBody
	public List<StoreAdminVO> usingList(HttpServletRequest request, HttpServletResponse response) {
	// Store - 지점명, 지점주소 (StoreConlloer)
		HttpSession session = request.getSession();
		String storeCode = (String) session.getAttribute("stCode");
		
	List<StoreAdminVO> list = storeAdminDAO.usingStrorageList(storeCode);
	return list;
	}
	
	// 사용종료 사용자 리스트
		@RequestMapping("expiredList")
		@ResponseBody
		public List<StoreAdminVO> expiredList(HttpServletRequest request, HttpServletResponse response) {
		// Store - 지점명, 지점주소 (StoreConlloer)
		HttpSession session = request.getSession();
		String storeCode = (String) session.getAttribute("stCode");
		
		List<StoreAdminVO> list = storeAdminDAO.expiredStrorageList(storeCode);
		return list;
		}
	
	@RequestMapping("customerManage")
	public String LoginIdCheck(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		
		
		
	return "storeAdmin/customerManage";
	}
	

	@RequestMapping("storageUserDetail")
	public String storageUserDetail(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		String use_num = request.getParameter("use_num");
		StoreAdminVO rvo = storeAdminDAO.storageUserDetail(use_num);
		
		model.addAttribute("selectUserVO", rvo);
		
		return "storeAdmin/storageUserDetail";
	}	
	
	//세탁물 위탁날짜 입력
	@RequestMapping("laundryConsignUpdate")
	@ResponseBody
	public String laundryConsignUpdate(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException, ParseException {
		 
		String laundry_consign = request.getParameter("laundry_consign");

		vo.setLaundry_consign(laundry_consign);

		
		
			System.out.println(vo.getLaundry_consign());
			String result = "";
			
		 	int i = storeAdminDAO.updateLaundryConsign(vo);
			
			if(i > 0)
				result = "update success";
			
			return result;
	}
	
	//세탁물 회수날짜 입력
		@RequestMapping("laundryCollectUpdate")
		@ResponseBody
		public String userLoginIdCheck(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException, ParseException {
			 
			String laundry_collect = request.getParameter("laundry_collect");

			vo.setLaundry_collect(laundry_collect);
			
				System.out.println(vo.getLaundry_collect());
				String result = "";
				
			 	int i = storeAdminDAO.updateLaundryCollect(vo);
				
				if(i > 0)
					result = "update success";
				
				return result;
		}
	
	
	
		// 고객관리 보고서 입력
		@ResponseBody
		@RequestMapping("insertReport")
		public String insertReport(StoreAdminVO vo) {
			String result = "";

			int up = storeAdminDAO.insertReport(vo);

			if (up > 0)
				result = "insert success";

			return result;
		}

		// 쿠폰정보 입력
		@ResponseBody
		@RequestMapping("insertCoupon")
		public String insertCoupon(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response)  {
			
			//int getCoupon_discount= Integer.parseInt(request.getParameter("coupon_discount"));
			//int coupon_discount =1-getCoupon_discount;
			//String coupon_discountToString= String.valueOf(coupon_discount);

			//vo.setCoupon_discount(coupon_discount);
			String result = "";

			int i = storeAdminDAO.insertCoupon(vo);

			if (i > 0)
				result = "insert success";

			return result;
		}
	

	/////////////////////////////////전형민////////////////////////////////////////////		
	//===============최반야 > 1:1 문의 관리 ============================
	
	// 1:1 문의 관리 페이지 로딩
	@RequestMapping("store/supervisionAsk")
	public String supervisionAsk(StoreAdminVO vo, HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String s_code = (String) session.getAttribute("stCode");
		vo.setStore_code(s_code);
		System.out.println(s_code);
		
		model.addAttribute("customerAskList",storeAdminDAO.customerAskList(vo));
		
		return "storeAdmin/answerAsk";
	}
	
	// 1:1 문의 상세
	@ResponseBody
	@RequestMapping(value="store/custormerAskSelect/{question_num}", method=RequestMethod.GET)
	public List<StoreAdminVO> custormerAskSelect(@PathVariable int question_num, StoreAdminVO vo, HttpServletRequest req) {
		vo.setQuestion_num(question_num);
		
		List<StoreAdminVO> custormerAskSelect = storeAdminDAO.customerAskSelect(vo);
		
		return custormerAskSelect;
	}
	
	// 1:1 문의 답변 등록
	@ResponseBody
	@RequestMapping(value="store/answerAsk", method=RequestMethod.POST)
	public String answerAsk(HttpServletRequest req, StoreAdminVO vo) {
		HttpSession session = req.getSession();
		String empId = (String) session.getAttribute("empId");
		String s_code = (String) session.getAttribute("stCode");
		System.out.println(empId+"====="+s_code);
		vo.setMember_id(empId);
		vo.setStore_code(s_code);
		
		String result = "";

		int answer = storeAdminDAO.answerAsk(vo);
		
		if(answer > 0)
			result = "success";
		
		return result;
	}
	
	
	//==============최반야 > 1:1 문의 관리 끝 ==========================
}
