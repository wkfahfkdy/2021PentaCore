package com.yedam.storage.mypage.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
	public String myPageInfo(Model model, MyPageVO vo) {	
		
		//test용 data
		String s_code = "ST002";
		vo.setStore_code(s_code);

		String id = "user10";
		vo.setMember_id(id);
		
	
		String notice = null;
		String useService = null;
		
		if(s_code != null) {
			model.addAttribute("noticeSelectList", MyPageDAO.noticeSelectList(vo));
			model.addAttribute("usedStorageList", MyPageDAO.usedStorageList(vo));
		}
		else {
			notice = "아직 이용 중인 지점이 없습니다.";
			useService = "아직 이용 중인 보관 서비스가 없습니다.";
			model.addAttribute("notice", notice);
			model.addAttribute("useService", useService);
		}
		return "myPage/myPageInfo";
	}
	
	//	견적서 조회 페이지
	@RequestMapping("offerList")
	public String offerList(Model model, MyPageVO vo) {
		//Test data
		String id = "user10";
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
	
	//	물품 운송 신청 및 내역 페이지
	@RequestMapping("conveyList")
	public String conveyList(Model model, MyPageVO vo) {
		//test data
		String id = "user10";
		vo.setMember_id(id);
		
		model.addAttribute("conveyListAll", MyPageDAO.conveyListAll(vo));
		return "myPage/conveyCheck";
	}
	
	// 운송 신청 상세 modal로 보낼 data
	@RequestMapping(value="myConvey/{apply_code}", method=RequestMethod.GET)
	@ResponseBody
	public MyPageVO myConveySelect(@PathVariable String apply_code, Model model, MyPageVO vo) {
		vo.setApply_code(apply_code);
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
}
