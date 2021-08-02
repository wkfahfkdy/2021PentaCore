package com.yedam.storage.laundryinfo.service;

import java.util.List;

import com.yedam.storage.laundryinfo.vo.LaundryInfoVO;

public interface LaundryInfoService {
	List<LaundryInfoVO> selectLaundryInfoList();
}
