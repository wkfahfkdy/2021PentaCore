package com.yedam.storage.mypage.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.mypage.service.MyPageService;
import com.yedam.storage.mypage.vo.MyPageVO;

@Repository("mypageDAO")
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
	public List<MyPageVO> offerSelectList(MyPageVO vo) {
		// 견적서 내역 조회
		return sqlSession.selectList("offerSelectList", vo);
	}

	@Override
	public MyPageVO myOfferSelect(MyPageVO vo) {
		// 견적서 상세 조회
		return sqlSession.selectOne("myOfferSelect", vo);
	}
}
