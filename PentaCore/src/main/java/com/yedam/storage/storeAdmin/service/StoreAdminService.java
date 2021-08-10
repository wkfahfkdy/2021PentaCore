package com.yedam.storage.storeAdmin.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

public interface StoreAdminService {
	// 동영
	// 스토리지 현황 클릭시 정보
	public StoreAdminVO selectStorageInfo(StoreAdminVO vo);
	
	// 스토리지 현황 메인페이지
	public List<StoreAdminVO> selectStorageInfoList(StoreAdminVO vo);
	public List<StoreAdminVO> storageName();
	// 미사용 고객 정보 service
	public List<StoreAdminVO> selectOfferInfo(StoreAdminVO vo);
	// 현재 예약되어 있는 정보 List
	public List<StoreAdminVO> offerInfoList(StoreAdminVO vo);
	// 미사용중인 스토리지 정보 출력
	public List<StoreAdminVO> unUseStorageList(StoreAdminVO vo);
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
	
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);
	
	//지점 고객관리 
	public List<StoreAdminVO> usingStrorageList(); 
	public List<StoreAdminVO> expiredStrorageList();
	public StoreAdminVO storageUserDetail(@Param("p") String use_num );
	
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
	
	// 고객관리 스토리지 이용자 보고서
	public int insertReport(StoreAdminVO vo);
}
