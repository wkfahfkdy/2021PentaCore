package com.yedam.storage.rental.service;

import java.util.List;

import com.yedam.storage.rental.vo.RentalVO;

public interface RentalService {
	List<RentalVO> selectRentalList();
}
