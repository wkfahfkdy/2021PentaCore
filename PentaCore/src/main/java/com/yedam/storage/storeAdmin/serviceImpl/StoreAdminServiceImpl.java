package com.yedam.storage.storeAdmin.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.storeAdmin.map.StoreAdminMapper;
import com.yedam.storage.storeAdmin.service.StoreAdminService;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@Service
public class StoreAdminServiceImpl implements StoreAdminService {

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private StoreAdminMapper map;

	// 스토리지 현황 리스트 동영
	@Override
	public List<StoreAdminVO> selectStorageInfoList(StoreAdminVO vo) {
		return map.StorageList(vo);
	}

	@Override
	public List<StoreAdminVO> storageName() {
		return map.StorageInfo();
	}

	// 클릭시 스토리지 현황 정보
	@Override
	public StoreAdminVO selectStorageInfo(StoreAdminVO vo) {
		return map.selectStorageInfo(vo);
	}
	// 미사용 클릭시 예약정보 출력
	@Override
	public List<StoreAdminVO> selectOfferInfo(StoreAdminVO vo) {
		return map.selectOfferInfo(vo);
	}

	// 현재 예약되어 있는 정보 List
	@Override
	public List<StoreAdminVO> offerInfoList(StoreAdminVO vo) {
		return map.offerInfoList(vo);
	}
	
	// 미사용중인 스토리지 정보
	@Override
	public List<StoreAdminVO> unUseStorageList(StoreAdminVO vo) {
		return map.unUseStorageList(vo);
	}
	// end
	// 공지 파트 시작

	@Override
	public List<StoreAdminVO> storeNoticeList(StoreAdminVO vo) {
		// 지점별 공지사항 리스트
		return sqlSession.selectList("storeNoticeList", vo);
	}

	@Override
	public int registNotice(StoreAdminVO vo) {
		// 지점별 공지사항 등록
		return sqlSession.insert("registNotice", vo);
	}

	@Override
	public StoreAdminVO storeNoticeSelect(StoreAdminVO vo) {
		// 공지사항 상세
		return sqlSession.selectOne("storeNoticeSelect", vo);
	}

	@Override
	public int storeNoticeEdit(StoreAdminVO vo) {
		// 공지사항 수정
		return sqlSession.insert("storeNoticeEdit", vo);
	}

	@Override
	public int storeNoticeDelete(StoreAdminVO vo) {
		// 공지 삭제
		return sqlSession.delete("storeNoticeDelete", vo);
	}
	// 공지 파트 끝

	// 전형민
	@Override
	public List<StoreAdminVO> usingStrorageList() {
		return sqlSession.selectList("usingStrorageList");
	}

	@Override
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo) {
		return sqlSession.selectList("usingStrorageListPaging", vo);
	}

	@Override
	public List<StoreAdminVO> expiredStrorageList() {
		return sqlSession.selectList("expiredStrorageList");
	}

	@Override
	public StoreAdminVO storageUserDetail(String use_num) {
		return sqlSession.selectOne("storageUserDetail", use_num);
	}

}
