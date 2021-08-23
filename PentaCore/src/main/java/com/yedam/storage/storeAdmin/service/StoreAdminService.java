package com.yedam.storage.storeAdmin.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yedam.storage.mypage.vo.MyPageVO;
import com.yedam.storage.store.vo.StoreVO;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

public interface StoreAdminService {
	// 동영
	
	// 스토리지 현황 메인페이지
	public List<StoreAdminVO> selectStorageInfoList(StoreAdminVO vo);
	public List<StoreAdminVO> storageName();
	// 미사용 고객 정보 service
	public List<StoreAdminVO> selectOfferInfo(StoreAdminVO vo);
	// 현재 예약되어 있는 정보 List
	public List<StoreAdminVO> offerInfoList(StoreAdminVO vo);
	// 미사용중인 스토리지 정보 출력
	public List<StoreAdminVO> unUseStorageList(StoreAdminVO vo);
	// use_storage update 작업
	public int useStroageUpdate(StoreAdminVO vo);
	// 위에꺼 실행 후 동작 되는 프로시저
	public void updateUseProcedure(StoreAdminVO vo);
	// 온습도 정보 select
	public StoreVO storeTemHumInfo(StoreVO vo);
	// 온습도 정보 update
	public int storeTemHumUpdate(StoreVO vo);
	// 사후보고서 List ajax
	public List<StoreAdminVO> premiumReportList(StoreAdminVO vo);
	// 사후보고서 Select Ajax
	public StoreAdminVO premiumReportSelect(StoreAdminVO vo);
	// 사후보고서 Update
	public int updatePremiumReport(StoreAdminVO vo);
	// 동영
	// 지점별 공지사항 리스트
	public List<StoreAdminVO> storeNoticeList(StoreAdminVO vo);
	//public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);
	
	// 지점별 공지사항 등록
	public int registNotice(StoreAdminVO vo);
	// 지점별 공지사항 확인
	public StoreAdminVO storeNoticeSelect(StoreAdminVO vo);
	// 공지사항 수정
	public int storeNoticeEdit(StoreAdminVO vo);

	// 공지사항 삭제
	public int storeNoticeDelete(StoreAdminVO vo);

	// ==============형민====================
	// -- 지점 고객관리
	// 스토리지 이용중 고객
	public List<StoreAdminVO> usingStrorageList(@Param("p") String store_code);

	// 스토리지 이용만료 고객
	public List<StoreAdminVO> expiredStrorageList(@Param("p") String store_code);

	// 고객관리 스토리지 클릭시 select
	public StoreAdminVO selectStorageInfo(StoreAdminVO vo);

	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);

	public StoreAdminVO storageUserDetail(@Param("p") String use_num);

	public int updateLaundryConsign(StoreAdminVO vo);

	public int updateLaundryCollect(StoreAdminVO vo);
	
	// 고객관리 스토리지 이용자 보고서
	public int insertReport(StoreAdminVO vo);
	// 쿠폰 입력
	public int insertCoupon(StoreAdminVO vo);
	
	//투어관리
	public List<MyPageVO> storeTourList(MyPageVO vo);
	public int updateTour(MyPageVO vo);
	// ==============형민====================

	// ==============반야====================
	// 1:1 문의 관리
	// 문의 내역
	public List<StoreAdminVO> customerAskList(StoreAdminVO vo);
	// 문의 답변 등록
	public int answerAsk(StoreAdminVO vo);
	// 답변 수정
	public int editnAnswer(StoreAdminVO vo);
	// 답변 삭제
	public int deleteAnswer(StoreAdminVO vo);
	// 문의 상세 조회
	public List<StoreAdminVO> customerAskSelect(StoreAdminVO vo);
	// =============끝=======================
	
	
}
