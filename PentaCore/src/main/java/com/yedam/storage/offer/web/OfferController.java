package com.yedam.storage.offer.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.yedam.storage.product.impl.ProductServiceImpl;
import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.product.vo.ProductVO;

@RestController
public class OfferController {

   @Autowired
   private ProductService productDAO;
   @Autowired
   private ProductServiceImpl impl;
   
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
   
   
}