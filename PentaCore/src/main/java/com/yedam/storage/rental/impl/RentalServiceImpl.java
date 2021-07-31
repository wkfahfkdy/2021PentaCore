package com.yedam.storage.rental.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.rental.map.RentalMap;
import com.yedam.storage.rental.service.RentalService;
import com.yedam.storage.rental.vo.RentalVO;

@Service
public class RentalServiceImpl implements RentalService {

	@Autowired
	private RentalMap map;
	
	@Override
	public List<RentalVO> selectRentalList() {
		return map.selectRentalList();
	}

}
