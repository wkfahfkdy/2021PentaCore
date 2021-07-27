package com.yedam.storage;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.division.service.DivisionService;
import com.yedam.storage.division.vo.DivisionVO;
import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.product.vo.ProductVO;
import com.yedam.storage.store.service.StoreService;
import com.yedam.storage.store.vo.StoreVO;
import com.yedam.storage.storage.service.StorageService;

@Controller
public class HomeController {
	
	@Autowired
	private DivisionService divisionDAO;
	@Autowired
	private ProductService productDAO;
	@Autowired
	private StoreService storeDAO;
	private StorageService storageDAO;
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "common/section";
	}
	
	// 캘린더 API TEST
	@RequestMapping("calendarTest")
	public String calendarTest() {
		
		return "test/calendar";
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
		return "offer/selfOfferPage";
	}
	
	// Division_code 받아서 물품별 이미지 + 이름 나오는 method
	@RequestMapping("productList")
	@ResponseBody
	public List<ProductVO> productList(Model model, HttpServletRequest req) {
		DivisionVO vo = new DivisionVO();
		String data = req.getParameter("division_code");
		System.out.println(data);
		vo.setDivision_code(data);
		return productDAO.selectProduct(vo);
	}
}
