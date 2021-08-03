package com.yedam.storage.coupon.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.coupon.map.CouponMap;
import com.yedam.storage.coupon.service.CouponService;
import com.yedam.storage.coupon.vo.CouponVO;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponMap map;
	
	@Override
	public List<CouponVO> selectCouponList() {
		return map.selectCouponList();
	}

}
