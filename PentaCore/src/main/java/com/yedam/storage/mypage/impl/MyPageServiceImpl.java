package com.yedam.storage.mypage.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.mypage.map.MyPageMap;
import com.yedam.storage.mypage.service.MyPageService;
import com.yedam.storage.mypage.vo.MyPageVO;
import com.yedam.storage.offer.vo.OfferVO;

@Service("mypageDAO")
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	MyPageMap mMap;
	
	@Override
	public List<MyPageVO> noticeSelectList(MyPageVO vo) {
		// 공지사항에 노출 될 정보
		return sqlSession.selectList("noticeSelectList",vo);
	}

	@Override
	public List<MyPageVO> usedStorageList(MyPageVO vo) {
		// 마이페이지 이용 중인 서비스에 노출될 정보
		return sqlSession.selectList("usedStorageList",vo);
	}

	@Override
	public MyPageVO useStorage(MyPageVO vo) {
		// 사용자가 이용 중인 스토리지가 있는지 체크
		return sqlSession.selectOne("useStorage", vo);
	}

	@Override
	public MyPageVO useStore(MyPageVO vo) {
		// 사용자가 이용 중인 지점 이름
		return sqlSession.selectOne("useStore", vo);
	}
	
	@Override
	public MyPageVO userReview(MyPageVO vo) {
		// 사용자가 이용 중인 지점에 대한 리뷰를 작성했는지 체크
		return sqlSession.selectOne("userReview", vo);
	}

	// 마이페이지 중 이용중인 스토리지 모두 보기 클릭시
	@Override
	public List<MyPageVO> TotalUseStorageListInfo(MyPageVO vo) {
		return mMap.TotalUseStorageListInfo(vo);
	}
	//--------------견적서 내역 페이지-----------------	
	
	@Override
	public List<MyPageVO> offerSelectList(MyPageVO vo) {
		// 견적서 내역 조회
		return sqlSession.selectList("offerSelectList", vo);
	}

	@Override
	public MyPageVO myOfferSelect(MyPageVO vo) {
		// 견적서 상세 조회
		return sqlSession.selectOne("myOfferSelect", vo);
	}
	
	@Override
	public int goPayY(OfferVO vo) {
		// OFFER_PAY 값 'Y'로 update
		return sqlSession.update("goPayY", vo);
	}

	//--------------물품 운송 페이지-----------------		
	
	@Override
	public List<MyPageVO> conveyListAll(MyPageVO vo) {
		// 운송 신청 내역 조회
		return sqlSession.selectList("conveyListAll", vo);
	}

	@Override
	public MyPageVO myConveySelect(MyPageVO vo) {
		// 운송 신청 상세
		return sqlSession.selectOne("myConveySelect", vo);
	}

//	@Override
//	public int conveyDelete(MyPageVO vo) {
//		// 운송 신청 취소
//		return sqlSession.delete("conveyDelete", vo);
//	}

	@Override
	public List<MyPageVO> storeInfoSelect() {
		// 지도api 사용 위한 지점명, 지점주소 조회
		return sqlSession.selectList("storeInfoSelect");
	}

	@Override
	public int conveyInsert(MyPageVO vo) {
		// 운송 신청 등록
		return sqlSession.insert("conveyInsert", vo);
	}

	//--------------지점 투어 페이지-----------------	
	
	@Override
	public List<MyPageVO> storeTourListAll(MyPageVO vo) {
		// 투어 신청 내역 조회
		return sqlSession.selectList("storeTourListAll", vo);
	}

	@Override
	public int storeTourRegist(MyPageVO vo) {
		// 투어 신청 등록
		return sqlSession.insert("storeTourRegist", vo);
	}

	@Override
	public int cancelTour(MyPageVO vo) {
		// Grid에서 바로 취소..
		for(int i = 0; i < vo.getUpdatedRows().size();i++) {
			mMap.cancelTour(vo.getUpdatedRows().get(i));
		}
		return 0;
	}
	
	//--------------리뷰 작성 페이지-----------------	

	@Override
	public int reviewRegist(MyPageVO vo) {
		// 리뷰 작성 등록
		return sqlSession.insert("reviewRegist", vo);
	}
	
	//--------------공지사항 페이지-----------------	

	@Override
	public MyPageVO noticeSelect(MyPageVO vo) {
		// 공지사항 상세글 조회
		return sqlSession.selectOne("noticeSelect", vo);
	}
	
	//--------------쿠폰 페이지-----------------	

	@Override
	public List<MyPageVO> couponList(MyPageVO vo) {
		// 쿠폰 및 프로모션 조회
		return sqlSession.selectList("couponList", vo);
	}
	
	//--------------컨디션 보고서 페이지-----------------	

	@Override
	public List<MyPageVO> reportList(MyPageVO vo) {
		// 컨디션 보고서 리스트
		return sqlSession.selectList("reportList", vo);
	}

	@Override
	public MyPageVO reportSelect(MyPageVO vo) {
		// 보고서 상세보기
		return sqlSession.selectOne("reportSelect", vo);
	}

	//--------------1:1 문의 페이지-----------------	
	
	@Override
	public List<MyPageVO> myAskList(MyPageVO vo) {
		// 사용자의 1:1 문의 내역 리스트
		return sqlSession.selectList("myAskList", vo);
	}

	@Override
	public int registAsk(MyPageVO vo) {
		// 1:1 문의 등록
		return sqlSession.insert("registAsk", vo);
	}

	@Override
	public List<MyPageVO> myAskSelect(MyPageVO vo) {
		// 1:1 문의 상세
		return sqlSession.selectList("myAskSelect", vo) ;
	}
	
	//--------------세탁 처리 내역 페이지-----------------	

	@Override
	public List<MyPageVO> myLaundry(MyPageVO vo) {
		// 세탁 처리 내역 리스트
		return sqlSession.selectList("myLaundry", vo);
	}

	@Override
	public MyPageVO myLaundrySelect(MyPageVO vo) {
		// 세탁 처리 내역 상세
		return sqlSession.selectOne("myLaundrySelect", vo);
	}

}
