package com.yedam.storage.mypage.service;

import java.util.List;

import com.yedam.storage.mypage.vo.MyPageVO;

public interface MyPageService {
	// 사용자가 이용 중인 스토리지가 있는지 검증
	public MyPageVO useStorage(MyPageVO vo);
	
	// 마이페이지 첫화면
	public List<MyPageVO> noticeSelectList(MyPageVO vo);
	public List<MyPageVO> usedStorageList(MyPageVO vo);
	
	// 견적서 리스트 조회
	public List<MyPageVO> offerSelectList(MyPageVO vo);
	// 견적서 상세 조회
	public MyPageVO myOfferSelect(MyPageVO vo);
	
	// 물품 운송 신청 조회
	public List<MyPageVO> conveyListAll(MyPageVO vo);
	// 운송 신청서 상세
	public MyPageVO myConveySelect(MyPageVO vo);
	// 지도 api 사용 위해 지점명, 지점 주소 조회
	public List<MyPageVO> storeInfoSelect();
	// 운송 신청 등록
	public int conveyInsert(MyPageVO vo);
	// 운송 신청 취소
	//public int conveyDelete(MyPageVO vo);
}
