package com.yedam.storage.coupon.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.coupon.service.CouponService;
import com.yedam.storage.coupon.vo.CouponVO;

@Controller
public class CouponController {
	@Autowired
	private CouponService couponDAO;
	
	@RequestMapping("couponList")
	@ResponseBody
	public List<CouponVO> couponList(Model model){
		return couponDAO.selectCouponList();
	}
	
}
