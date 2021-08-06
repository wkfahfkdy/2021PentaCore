package com.yedam.storage.offer.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.yedam.storage.offer.service.OfferService;
import com.yedam.storage.offer.vo.OfferVO;
import com.yedam.storage.product.impl.ProductServiceImpl;
import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.product.vo.ProductVO;

@Controller
public class OfferController {

	@Autowired
	private ProductService productDAO;
	@Autowired
	private ProductServiceImpl impl;
	@Autowired
	private OfferService offerService;
	
	@RequestMapping("productList")
	@ResponseBody
	public List<ProductVO> productList(Model model) {
		return productDAO.selectProductList(); 
	}
	// Division_code 받아서 물품별 이미지 + 이름 Ajax처리
	@RequestMapping(value = "productList/{division_code}", method = RequestMethod.GET)
	public List<ProductVO> getProduct(@PathVariable String division_code, Model model, ProductVO vo) {
		vo.setDivision_code(division_code);
		return productDAO.getProduct(vo);
	}
	
	@RequestMapping("insertOffer")
	public String insertOffer(Model model, OfferVO vo) {
		System.out.println(vo);
		offerService.offerInsert(vo);
		return "redirect:offerList";
	}
	
}
