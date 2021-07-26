package com.yedam.storage.product.service;

import java.util.List;

import com.yedam.storage.division.vo.DivisionVO;
import com.yedam.storage.product.vo.ProductVO;

public interface ProductService {
	List<ProductVO> selectProduct(DivisionVO vo);
}
