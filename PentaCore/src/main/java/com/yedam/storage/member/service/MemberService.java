package com.yedam.storage.member.service;


import java.util.HashMap;

import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.mypage.vo.MyPageVO;

public interface MemberService {

	public MemberVO loginCheck(MemberVO vo);
	public MemberVO emailCheck(String p);
	public MemberVO telCheck(String p);
	public MemberVO idCheck(String p);
	public int memberInsert(HashMap<String, Object> hash);
	
	public MemberVO modalEmailCheck(MemberVO vo);
	public MemberVO memberInfo(MemberVO vo);
	public MyPageVO UseCodeInfo(MyPageVO vo);
}
