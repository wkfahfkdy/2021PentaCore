package com.yedam.storage.mypage.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.mypage.service.MyPageService;
import com.yedam.storage.mypage.vo.MyPageVO;

@Controller
public class MyPageController {
	@Autowired
	private MyPageService MyPageDAO;
	
	// Mypage 첫화면
	@RequestMapping("myPageInfo")
	public String myPageInfo(HttpServletRequest req, Model model, MyPageVO vo) {	
		HttpSession session = req.getSession();
		
		String s_code = (String) session.getAttribute("loginStore");

		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
	
		String notice = null;
		String useService = null;
		
		if(s_code != null) {
			vo.setStore_code(s_code);
			model.addAttribute("noticeSelectList", MyPageDAO.noticeSelectList(vo));
			model.addAttribute("usedStorageList", MyPageDAO.usedStorageList(vo));
			model.addAttribute("userReview", MyPageDAO.userReview(vo));
		}
		else {
			notice = "아직 이용 중인 지점이 없습니다.";
			useService = "아직 이용 중인 보관 서비스가 없습니다.";
			model.addAttribute("notice", notice);
			model.addAttribute("useService", useService);
		}
		return "myPage/myPageInfo";
	}
	
	//---------------------------------견적서 내역 페이지-----------------------------------------
	
	//	견적서 조회 페이지 실행
	@RequestMapping("offerList")
	public String offerList(HttpServletRequest req, Model model, MyPageVO vo) {
		HttpSession session = req.getSession();
		
		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		
		model.addAttribute("offerSelectList",MyPageDAO.offerSelectList(vo));
		return "myPage/offerList";
	}
	
	// modal창에 보낼 data
	@RequestMapping(value="myOffer/{offer_code}", method=RequestMethod.GET)
	@ResponseBody
	public MyPageVO myOfferSelect(@PathVariable String offer_code, Model model, MyPageVO vo){	
		vo.setOffer_code(offer_code);
		return MyPageDAO.myOfferSelect(vo);
	}
	
	//---------------------------------물품 운송 신청 페이지-----------------------------------------
	
	//	물품 운송 신청 및 내역 페이지 실행
	@RequestMapping("conveyList")
	public String conveyList(HttpServletRequest req, Model model, MyPageVO vo) {
		HttpSession session = req.getSession();

		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		
		model.addAttribute("conveyListAll", MyPageDAO.conveyListAll(vo));
		model.addAttribute("useStore", MyPageDAO.useStore(vo));
		return "myPage/conveyCheck";
	}
	
	// 운송 신청 상세 modal로 보낼 data
	@RequestMapping(value="myConvey/{apply_code}", method=RequestMethod.GET)
	@ResponseBody
	public MyPageVO myConveySelect(@PathVariable String apply_code, Model model, MyPageVO vo) {
		vo.setApply_code(apply_code);
		System.out.println(apply_code);
		return MyPageDAO.myConveySelect(vo);
	}
	
	// 운송 신청 취소
	@RequestMapping(value = "cancelConvey/{apply_code}", method=RequestMethod.POST)
	@ResponseBody
	public int conveyDelete(@PathVariable String apply_code, MyPageVO vo) {
		vo.setApply_addr(apply_code);
		
		return 0;
	}
	
	// 지점명, 지점주소
	@RequestMapping("storeInfo")
	@ResponseBody
	public List<MyPageVO> StoreAddr() {
		List<MyPageVO> list = MyPageDAO.storeInfoSelect();
		return list;
	}
	
	// 운송 신청 등록
	@RequestMapping("registConvey")
	public String conveyInsert(HttpServletRequest req, MyPageVO vo) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		
		String useStore = (String) session.getAttribute("loginStore");
		String uStore = vo.getStore_code();
		System.out.println(useStore);
		System.out.println(uStore);
		
		if(useStore != null && uStore != "") {
			vo.setStore_code(uStore);
		} else if(useStore != null && uStore == "") {
			vo.setStore_code(useStore);
		} else {
			vo.setStore_code(uStore);
		}
		
		System.out.println("값 체크 : "+ vo.toString());
		
		int regConvey = MyPageDAO.conveyInsert(vo);
		System.out.println(regConvey);
		
		return "redirect:conveyList";
	}
	
	//---------------------------------매장 투어 신청 페이지-----------------------------------------
	
	// 투어 신청 페이지 실행
	@RequestMapping("storeTour")
	public String storeTour(HttpServletRequest req, Model model, MyPageVO vo) {
		HttpSession session = req.getSession();

		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		
		model.addAttribute("storeTourListAll", MyPageDAO.storeTourListAll(vo));
		
		return "myPage/tourCheck";
	}
	
	// 투어 신청 등록
	@RequestMapping("registTour")
	public String registTour(HttpServletRequest req, MyPageVO vo) {
		HttpSession session = req.getSession();
		
		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		
		System.out.println("값 체크 : "+vo.toString());
		
		MyPageDAO.storeTourRegist(vo);
		
		return "redirect:storeTour";
	}
	
	// 투어 취소
	@ResponseBody
	@RequestMapping(value = "tourCancel", method=RequestMethod.PUT)
	public int cancelTour(@RequestBody MyPageVO vo) {
		MyPageDAO.cancelTour(vo);
		return 0;
	}
	
	//---------------------------------리뷰 작성 form 페이지-----------------------------------------
	
	// 리뷰 작성 form 페이지 실행
	@RequestMapping("reviewForm")
	public String reviewForm(HttpServletRequest req, Model model, MyPageVO vo) {
		HttpSession session = req.getSession();
		
		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		
		model.addAttribute("useStore", MyPageDAO.useStore(vo));
		return "myPage/reviewRegist";
	}
	
	// 리뷰 작성 등록
	@RequestMapping("reviewRegist")
	public String reviewRegist(HttpServletRequest req, MyPageVO vo) {
		HttpSession session = req.getSession();
		
		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		
		MyPageDAO.reviewRegist(vo);
		return "redirect:myPageInfo";
	}
	
	//---------------------------------공지사항 페이지-----------------------------------------
	
	// 공지사항 리스트
	@RequestMapping("noticeList")
	public String noticeList(HttpServletRequest req, Model model, MyPageVO vo) {
		HttpSession session = req.getSession();
		
		String s_code = (String) session.getAttribute("loginStore");
		vo.setStore_code(s_code);

		String id = (String) session.getAttribute("loginId");
		vo.setMember_id(id);
		
		model.addAttribute("noticeSelectList", MyPageDAO.noticeSelectList(vo));
		
		return "myPage/noticeCheck";
	}
	
	// 공지사항 상세 Modal 창으로 데이터 보내기
	@RequestMapping(value = "notice/{notice_num}", method=RequestMethod.GET)
	@ResponseBody
	public MyPageVO notice(@PathVariable int notice_num, Model model, MyPageVO vo) {
		vo.setNotice_num(notice_num);
		
		return MyPageDAO.noticeSelect(vo);
	}
	
	//---------------------------------쿠폰 페이지-----------------------------------------
	
	// 쿠폰 리스트
	@RequestMapping("couponList")
	public String couponList(Model model, MyPageVO vo) {
		return "myPage/couponList";
	}
}
