package com.yedam.storage;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yedam.storage.division.service.DivisionService;
import com.yedam.storage.division.vo.DivisionVO;
import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.product.vo.ProductVO;

@Controller
public class HomeController {
	
	@Autowired
	private DivisionService divisionDAO;
	@Autowired
	private ProductService productDAO;
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "common/section";
	}
	
	
	@RequestMapping("calendarTest.do")
	public String calendarTest() {
		
		return "test/calendar";
	@RequestMapping("selfOffer")
	public String selfOfferPage(Model model) {
		// 물품 카테고리 출력
		model.addAttribute("divisionList", divisionDAO.divisionSelectList());
		return "offer/selfOfferPage";
	}
	@RequestMapping("productList")
	public String productList(Model model) {
		DivisionVO vo = new DivisionVO();
		HttpServletRequest req = null;
		String data = req.getParameter("division_code");
		vo.setDivision_code(data);
		model.addAttribute("productList", productDAO.selectProduct(vo));
		return selfOfferPage(model);
	}
}
