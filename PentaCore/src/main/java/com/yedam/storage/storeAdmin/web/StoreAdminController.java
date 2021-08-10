package com.yedam.storage.storeAdmin.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	//===============최반야 > 1:1 문의 관리 ============================
	
	// 1:1 문의 관리 페이지 로딩
	@RequestMapping("supervisionAsk")
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
	@RequestMapping(value="custormerAskSelect/{question_num}", method=RequestMethod.GET)
	public List<StoreAdminVO> custormerAskSelect(@PathVariable int question_num, StoreAdminVO vo, HttpServletRequest req) {
		vo.setQuestion_num(question_num);
		
		List<StoreAdminVO> custormerAskSelect = storeAdminDAO.customerAskSelect(vo);
		
		return custormerAskSelect;
	}
	
	
	//==============최반야 > 1:1 문의 관리 끝 ==========================
}
