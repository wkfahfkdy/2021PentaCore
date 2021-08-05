package com.yedam.storage.offer.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.yedam.storage.offer.map.OfferMap;
import com.yedam.storage.offer.service.OfferService;
import com.yedam.storage.offer.vo.OfferVO;

public class OfferServiceImpl implements OfferService {

	@Autowired
	private OfferMap map;
	
	@Override
	public int insertOffer(OfferVO vo) {
		return map.insertOffer(vo);
	}

}
