package com.yedam.mypage.service;

import java.util.List;

import com.yedam.mypage.vo.MyPageVO;

public interface MyPageService {
	public List<MyPageVO> noticeSelectList();
	public List<MyPageVO> usedStorageList();
}
