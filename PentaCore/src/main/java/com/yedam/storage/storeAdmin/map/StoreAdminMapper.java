package com.yedam.storage.storeAdmin.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@MapperScan
public interface StoreAdminMapper {
	// 동영
	public List<StoreAdminVO> StorageList(StoreAdminVO vo);
	public List<StoreAdminVO> StorageInfo();
	public List<StoreAdminVO> offerInfoList(StoreAdminVO vo);
	public List<StoreAdminVO> selectOfferInfo(StoreAdminVO vo);
	public List<StoreAdminVO> unUseStorageList(StoreAdminVO vo);
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
	
	//지점 고객관리 
	public List<StoreAdminVO> usingStrorageList(); 
	
	// 스토리지 클릭시 select
	public StoreAdminVO selectStorageInfo(StoreAdminVO vo);
	public List<StoreAdminVO> expiredStrorageList();
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);  
	public StoreAdminVO storageUserDetail(@Param("p") String use_num );
	
}