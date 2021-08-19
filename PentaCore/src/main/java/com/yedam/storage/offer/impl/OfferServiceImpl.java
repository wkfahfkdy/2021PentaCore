package com.yedam.storage.offer.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.offer.map.OfferMap;
import com.yedam.storage.offer.service.OfferService;
import com.yedam.storage.offer.vo.OfferVO;

@Service
public class OfferServiceImpl implements OfferService {

	@Autowired
	private OfferMap map;
	
	@Override
	public int offerInsert(OfferVO vo) {
		return map.insertOffer(vo);
	}
	// 지도 클릭 검증 (빈 스토리지 유무)
	@Override
	public OfferVO useCount(OfferVO vo) {
		return map.useCount(vo);
	}

}
