package com.yedam.storage.coupon.service;

import java.util.List;

import com.yedam.storage.coupon.vo.CouponVO;

public interface CouponService {
	List<CouponVO> selectCouponList();
}
