package com.yedam.storage.mypage.map;

import java.util.List;

import com.yedam.storage.mypage.vo.MyPageVO;

public interface MyPageMap {
	public List<MyPageVO> noticeSelectList();
	public List<MyPageVO> usedStorageList();
}