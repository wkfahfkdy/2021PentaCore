package com.yedam.storage.member.service;


import java.util.HashMap;

import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.mypage.vo.MyPageVO;

public interface MemberService {

	//로그인 시
		public MemberVO loginCheck(MemberVO vo);
		public MemberVO emailCheck(String p);
		public MemberVO telCheck(String p);
		public MemberVO idCheck(String p);
		
		//아이디/비밀번호 찾기
		public MemberVO modalEmailCheck(MemberVO vo);
		
		//회원가입
		public int memberInsert(HashMap<String, Object> hash);
		public MemberVO memberInfo(MemberVO vo);
		public MyPageVO UseCodeInfo(MyPageVO vo);
		
		//회원정보 수정
		public MemberVO getMemberInfo(String p);
}
