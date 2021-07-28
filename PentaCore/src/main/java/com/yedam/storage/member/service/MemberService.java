package com.yedam.storage.member.service;


import com.yedam.storage.member.vo.MemberVO;

public interface MemberService {

	public MemberVO loginCheck(MemberVO vo);
	public MemberVO emailCheck(String p);
	public MemberVO telCheck(String p);
	public MemberVO idCheck(String p);
}
