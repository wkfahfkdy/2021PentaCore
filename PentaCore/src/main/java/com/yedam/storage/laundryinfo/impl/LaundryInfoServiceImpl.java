package com.yedam.storage.laundryinfo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.laundryinfo.map.LaundryInfoMap;
import com.yedam.storage.laundryinfo.service.LaundryInfoService;
import com.yedam.storage.laundryinfo.vo.LaundryInfoVO;

@Service
public class LaundryInfoServiceImpl implements LaundryInfoService {

	@Autowired
	private LaundryInfoMap map;
	
	@Override
	public List<LaundryInfoVO> selectLaundryInfoList() {
		return map.selectLaundryInfoList();
	}

}
