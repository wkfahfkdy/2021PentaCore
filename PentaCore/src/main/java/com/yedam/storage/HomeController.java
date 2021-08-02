package com.yedam.storage;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.division.service.DivisionService;
import com.yedam.storage.laundryinfo.service.LaundryInfoService;
import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.rental.service.RentalService;
import com.yedam.storage.storage.service.StorageService;
import com.yedam.storage.store.service.StoreService;
import com.yedam.storage.store.vo.StoreVO;

@Controller
public class HomeController {
	
	@Autowired
	private LaundryInfoService laundryInfoDAO;
	@Autowired
	private RentalService rentalDAO;
	@Autowired
	private DivisionService divisionDAO;
	@Autowired
	private ProductService productDAO;
	@Autowired
	private StoreService storeDAO;
	@Autowired
	private StorageService storageDAO;
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home() {
		
		// ~~.getAuthentication() = 우선 로그인 했을 때
		if(SecurityContextHolder.getContext().getAuthentication() != null) {
			// CustomSuccessHandler에서는 Set<GrantedAuthority> 타입을 썼었는데 List도 된다. 원래는 Collection 타입이다.
			List<GrantedAuthority> auth =
					(List<GrantedAuthority>) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
			
			// 관리자일 시에 해당 페이지로 이동
			if("ROLE_STORE".equals(auth.get(0).toString()) || "ROLE_TRANS".equals(auth.get(0).toString()) ) {
				System.out.println("컨트롤러 : " + auth.get(0).toString());
				return "common/enterAdmin";
			}
		}
		
		// admin이나 고객일 경우 메인으로 이동
		return "common/section";
	}
	
	// 캘린더 API TEST
	@RequestMapping("calendarTest")
	public String calendarTest() {
		
		return "test/calendar2";
	}
	
	// 카카오 지도 API TEST 이동
	@RequestMapping("kakaoMapTest")
	public String kakaoMapTest() {
		
		return "test/kakaoMapTest";
	}
	
	// 카카오 지도 API TEST - DATA
	@RequestMapping("storeAddr")
	@ResponseBody
	public List<StoreVO> StoreAddr() {
		// Store - 지점명, 지점주소 (StoreConlloer)
		List<StoreVO> list = storeDAO.SelectStoreAddr();
		return list;
	}
	
	@RequestMapping("selfOffer")
	public String selfOfferPage(Model model) {
		// 물품 카테고리 출력
		model.addAttribute("divisionList", divisionDAO.divisionSelectList());
		// 스토리지 정보 출력
		model.addAttribute("storageList", storageDAO.storageSelectList());
		// 물품 정보
		model.addAttribute("getProductList", productDAO.selectProductList());
		// 렌탈 물품 정보
		model.addAttribute("rentalList", rentalDAO.selectRentalList());
		// 세탁 물품 리스트
		model.addAttribute("laundryInfoList", laundryInfoDAO.selectLaundryInfoList());
		return "offer/selfOfferPage";
	} 
	
}
