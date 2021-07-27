package com.yedam.storage.mypage.service;

import java.util.List;

import com.yedam.storage.mypage.vo.MyPageVO;

public interface MyPageService {
	public List<MyPageVO> noticeSelectList(MyPageVO vo);
	public List<MyPageVO> usedStorageList(MyPageVO vo);
}
