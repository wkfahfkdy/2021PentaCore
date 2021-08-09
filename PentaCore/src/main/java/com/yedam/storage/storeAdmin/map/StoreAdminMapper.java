package com.yedam.storage.storeAdmin.map;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.yedam.storage.storage.vo.StorageVO;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@MapperScan
public interface StoreAdminMapper {
	
	public List<StoreAdminVO> StorageList(StoreAdminVO vo);
	public List<StoreAdminVO> StorageInfo();
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
	
	public List<StoreAdminVO> usingStrorageList(); 
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);
}