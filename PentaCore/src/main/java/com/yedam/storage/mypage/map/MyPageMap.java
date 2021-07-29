package com.yedam.storage.mypage.map;

import java.util.List;

import com.yedam.storage.mypage.vo.MyPageVO;

public interface MyPageMap {
	// 사용자가 이용 중인 스토리지가 있는지 검증
	public MyPageVO useStorage(MyPageVO vo);
	
	public List<MyPageVO> noticeSelectList();
	public List<MyPageVO> usedStorageList();
	
	// 견적서 리스트 조회
	public List<MyPageVO> offerSelectList(MyPageVO vo);
	// 견적서 상세 조회
	public List<MyPageVO> myOfferSelect(MyPageVO vo);
	
	// 물품 운송 신청내역 조회
	public List<MyPageVO> conveyListAll(MyPageVO vo);
	// 스토어 정보 : 신청form select option에서 사용.
	public List<MyPageVO>storeList(MyPageVO vo);
}
