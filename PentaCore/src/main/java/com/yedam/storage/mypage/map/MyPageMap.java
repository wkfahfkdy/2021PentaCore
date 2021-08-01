package com.yedam.storage.mypage.map;

import java.util.List;

import com.yedam.storage.mypage.vo.MyPageVO;

public interface MyPageMap {
	// 사용자가 이용 중인 스토리지가 있는지 검증
	public MyPageVO useStorage(MyPageVO vo);
	
	// 고객이 이용 중인 스토어 이름, 스토리지 번호 가져오기
	public MyPageVO useStore(MyPageVO vo);
	
	public List<MyPageVO> noticeSelectList();
	public List<MyPageVO> usedStorageList();
	
	//--------------견적서 내역 페이지-----------------
	
	// 견적서 리스트 조회
	public List<MyPageVO> offerSelectList(MyPageVO vo);
	// 견적서 상세 조회
	public List<MyPageVO> myOfferSelect(MyPageVO vo);
	
	//--------------물품 운송 페이지-----------------
	
	// 물품 운송 신청내역 조회
	public List<MyPageVO> conveyListAll(MyPageVO vo);
	// 스토어 정보 : 신청form select option에서 사용.
	public List<MyPageVO>storeList(MyPageVO vo);
	// 운송 신청서 상세
	public MyPageVO myConveySelect(MyPageVO vo);
	// 지도 api 사용 위해 지점명, 지점 주소 조회
	public List<MyPageVO> storeInfoSelect();
	// 운송 신청 등록
	public int conveyInsert(MyPageVO vo);
	// 운송 신청 취소
//	public int conveyDelete(MyPageVO vo);
	
	//--------------지점 투어 페이지-----------------
	
	// 지점 투어 신청 조회
	public List<MyPageVO> storeTourListAll(MyPageVO vo);
	// 투어 신청 등록
	public int storeTourRegist(MyPageVO vo);
	// 투어 신청 취소
	public int storeTourCancel(MyPageVO vo);
	
	//--------------리뷰 페이지-----------------
	public int reviewRegist(MyPageVO vo);
	
	//--------------공지사항 페이지----------------------
	
	// 공지사항 상세
	public MyPageVO noticeSelect(MyPageVO vo);
}
