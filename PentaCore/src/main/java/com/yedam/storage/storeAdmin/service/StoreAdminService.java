package com.yedam.storage.storeAdmin.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

public interface StoreAdminService {

	
	
	
	// 스토리지 현황 메인페이지
	public List<StoreAdminVO> selectStorageInfoList(StoreAdminVO vo);
	public List<StoreAdminVO> storageName();
	// 지점별 공지사항 리스트
	public List<StoreAdminVO> storeNoticeList(StoreAdminVO vo);
	//public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);
	
	// 지점별 공지사항 등록
	public int registNotice(StoreAdminVO vo);
	
	//지점 고객관리 
	public List<StoreAdminVO> usingStrorageList(); 
	public List<StoreAdminVO> expiredStrorageList();
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo); 
	public StoreAdminVO storageUserDetail(@Param("p") String use_num );
}
