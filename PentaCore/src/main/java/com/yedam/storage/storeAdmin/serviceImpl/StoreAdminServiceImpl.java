package com.yedam.storage.storeAdmin.serviceImpl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.store.vo.StoreVO;
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
	
	// 지점별 온습도 정보 select
	@Override
	public StoreVO storeTemHumInfo(StoreVO vo) {
		return map.storeTemHumInfo(vo);
	}
	
	// use_storage update 작업
	@Override
	public int useStroageUpdate(StoreAdminVO vo) {
		return map.updateUseStorage(vo);
	}
	
	@Override
	public int storeTemHumUpdate(StoreVO vo) {
		return map.storeTemHumUpdate(vo);
	}
	
	// 사후보고서 리스트 확인
	@Override
	public List<StoreAdminVO> premiumReportList(StoreAdminVO vo) {
		return map.premiumReportList(vo);
	}
	
	// 사후보고서 select
	@Override
	public StoreAdminVO premiumReportSelect(StoreAdminVO vo) {
		return map.premiumReportSelect(vo);
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

	// ------------------------------------------------전형민
	@Override
	public List<StoreAdminVO> usingStrorageList(@Param("p") String store_code) {
		return sqlSession.selectList("usingStrorageList",store_code);
	}

	@Override
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo) {
		return sqlSession.selectList("usingStrorageListPaging", vo);
	}

	@Override
	public List<StoreAdminVO> expiredStrorageList(@Param("p") String store_code) {
		return sqlSession.selectList("expiredStrorageList",store_code);
	}
	

	@Override
	public int updateLaundryConsign(StoreAdminVO vo) {
		return sqlSession.update("updateLaundryConsign",vo);
	} 

	@Override
	public int updateLaundryCollect(StoreAdminVO vo) {
		return sqlSession.update("updateLaundryCollect",vo);
	}

	@Override
	public StoreAdminVO storageUserDetail(String use_num) {
		return sqlSession.selectOne("storageUserDetail", use_num);
	}
	
	@Override
	public int insertReport(StoreAdminVO vo) {
		return sqlSession.insert("insertReport",vo);
	}
	
	@Override
	public int insertCoupon(StoreAdminVO vo) {
		return sqlSession.insert("insertCoupon",vo);
	}
	
	// ------------------------------------------------전형민

	// ================반야 -> 1:1 문의 관리=================
	@Override
	public List<StoreAdminVO> customerAskList(StoreAdminVO vo) {
		// 1:1 문의 내역
		return sqlSession.selectList("customerAskList",vo);
	}

	@Override
	public int answerAsk(StoreAdminVO vo) {
		// 1:1 문의 답변 등록
		return sqlSession.insert("answerAsk", vo);
	}

	@Override
	public int editnAnswer(StoreAdminVO vo) {
		// 문의 답변 수정
		return sqlSession.update("editnAnswer", vo);
	}

	@Override
	public int deleteAnswer(StoreAdminVO vo) {
		// 문의 답변 삭제
		return sqlSession.delete("deleteAnswer", vo);
	}

	@Override
	public List<StoreAdminVO> customerAskSelect(StoreAdminVO vo) {
		// 문의 상세 조회
		return sqlSession.selectList("customerAskSelect", vo);
	}
	// =================================================

}
