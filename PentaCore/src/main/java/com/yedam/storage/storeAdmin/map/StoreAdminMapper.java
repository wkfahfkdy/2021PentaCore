package com.yedam.storage.storeAdmin.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import com.yedam.storage.store.vo.StoreVO;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@MapperScan
public interface StoreAdminMapper {
	// 동영
	public List<StoreAdminVO> StorageList(StoreAdminVO vo);
	public List<StoreAdminVO> StorageInfo();
	public List<StoreAdminVO> offerInfoList(StoreAdminVO vo);
	public List<StoreAdminVO> selectOfferInfo(StoreAdminVO vo);
	public List<StoreAdminVO> unUseStorageList(StoreAdminVO vo);
	public int updateUseStorage(StoreAdminVO vo);
	public void updateUseProcedure(StoreAdminVO vo);
	public StoreVO storeTemHumInfo(StoreVO vo);
	public int storeTemHumUpdate(StoreVO vo);
	
	//사후보고서 리스트 확인
	public List<StoreAdminVO> premiumReportList(StoreAdminVO vo);
	// 사후보고서 select
	public StoreAdminVO premiumReportSelect(StoreAdminVO vo);
	// 사후보고서 Update
	public int updatePremiumReport(StoreAdminVO vo);
	// 동영
	// 지점별 공지사항 리스트
	public List<StoreAdminVO> storeNoticeList(StoreAdminVO vo);
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
	//스토리지 이용중 고객
	public List<StoreAdminVO> usingStrorageList(@Param("p") String store_code);  
	//스토리지 이용만료 고객
	public List<StoreAdminVO> expiredStrorageList(@Param("p") String store_code);
	
	// 고객관리 스토리지 클릭시 select   
	public StoreAdminVO selectStorageInfo(StoreAdminVO vo);
	
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);  
	public StoreAdminVO storageUserDetail(@Param("p") String use_num );
	public int updateLaundryConsign(StoreAdminVO vo);
	public int updateLaundryCollect(StoreAdminVO vo);
	public int insertReport(StoreAdminVO vo);
	public int insertCoupon(StoreAdminVO vo);
	
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
	// 고객관리 스토리지 이용자 보고서
	
	
}