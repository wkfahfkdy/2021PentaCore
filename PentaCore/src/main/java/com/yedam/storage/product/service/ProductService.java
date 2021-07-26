package com.yedam.storage.product.service;

import com.yedam.storage.division.vo.DivisionVO;
import com.yedam.storage.product.vo.ProductVO;

public interface ProductService {
	ProductVO selectProduct(DivisionVO vo);
}
