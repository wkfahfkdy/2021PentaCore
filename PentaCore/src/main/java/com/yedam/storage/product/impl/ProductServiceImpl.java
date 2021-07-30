package com.yedam.storage.product.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.product.map.ProductMap;
import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.product.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMap map;

	@Override
	public List<ProductVO> selectProductList() {
		return map.selectProductList();
	}

	@Override
	public List<ProductVO> getProduct(ProductVO vo) {
		return map.getProduct(vo);
	}
	
}
