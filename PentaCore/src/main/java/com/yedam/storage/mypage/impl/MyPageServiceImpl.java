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
	public List<MyPageVO> noticeSelectList() {
		// 공지사항에 노출 될 정보
		return sqlSession.selectList("noticeList");
	}

	@Override
	public List<MyPageVO> usedStorageList() {
		// 마이페이지 이용 중인 서비스에 노출될 정보
		return sqlSession.selectList("usingInfo");
	}

}
