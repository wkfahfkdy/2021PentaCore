package com.yedam.storage.product.impl;

import java.util.List;

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
	public List<ProductVO> selectProduct(DivisionVO vo) {
		return map.selectList("selectProduct", vo);
	}
	
}