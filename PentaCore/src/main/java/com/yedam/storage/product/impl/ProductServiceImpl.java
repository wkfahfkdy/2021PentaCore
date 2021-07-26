package com.yedam.storage.product.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.division.vo.DivisionVO;
import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.product.vo.ProductVO;

@Repository("productDAO")
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private SqlSessionTemplate map;

	@Override
	public ProductVO selectProduct(DivisionVO vo) {
		return map.selectOne("selectProduct", vo);
	}
	
}
