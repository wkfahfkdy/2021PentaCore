package com.yedam.storage.product.map;

import java.util.List;

import com.yedam.storage.product.vo.ProductVO;

public interface ProductMap {
	List<ProductVO> selectProductList();
	List<ProductVO> getProduct(ProductVO vo);
}
