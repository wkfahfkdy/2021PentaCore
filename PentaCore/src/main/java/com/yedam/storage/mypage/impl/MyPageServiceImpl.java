package com.yedam.storage.mypage.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.mypage.service.MyPageService;
import com.yedam.storage.mypage.vo.MyPageVO;

@Service("mypageDAO")
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
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
		return 0;
	}


}
