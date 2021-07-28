package com.yedam.storage.product.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.product.vo.ProductVO;

@Repository("productDAO")
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private SqlSessionTemplate map;

	@Override
	public List<ProductVO> selectProductList() {
		return map.selectList("selectProductList");
	}

	@Override
	public List<ProductVO> getProduct(ProductVO vo) {
		return map.selectList("getProduct", vo);
	}
	
}
