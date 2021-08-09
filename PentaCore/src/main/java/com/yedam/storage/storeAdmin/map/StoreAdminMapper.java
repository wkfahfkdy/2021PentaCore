package com.yedam.storage.storeAdmin.map;

import java.util.List;
import org.mybatis.spring.annotation.MapperScan;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@MapperScan
public interface StoreAdminMapper {
	
	public List<StoreAdminVO> StorageList(StoreAdminVO vo);
	public List<StoreAdminVO> StorageInfo();
	// 지점별 공지사항 리스트
	public List<StoreAdminVO> storeNoticeList(StoreAdminVO vo);
	
	// 지점별 공지사항 등록
	public int registNotice(StoreAdminVO vo);
	
	public List<StoreAdminVO> usingStrorageList(); 
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);
	
	// 스토리지 클릭시 select
	public StoreAdminVO selectStorageInfo(StoreAdminVO vo);
}