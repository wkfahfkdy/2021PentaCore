package com.yedam.storage.member.service;


import java.util.HashMap;

import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.mypage.vo.MyPageVO;
import com.yedam.storage.tour.vo.TourVO;

public interface MemberService {

	//로그인 시
		public MemberVO loginCheck(MemberVO vo);
		public MemberVO employeeLoginCheck(MemberVO vo);
		public MemberVO StoreAdminLoginCheck(MemberVO vo);
		public MemberVO emailCheck(String p);
		public MemberVO telCheck(String p);
		public MemberVO idCheck(String p);
		
		//아이디/비밀번호 찾기
		public MemberVO modalEmailCheck(MemberVO vo);
		public MemberVO modalPwCheck(MemberVO vo);
		
		//회원가입
		public int memberInsert(HashMap<String, Object> hash);
		public MemberVO memberInfo(MemberVO vo);
		public MyPageVO UseCodeInfo(MyPageVO vo);
		
		//회원정보 수정
		public MemberVO getMemberInfo(String p);
		//member수정
		public int memberPwUpdate(HashMap<String, Object> hash);
		public int memberEmailUpdate(HashMap<String, Object> hash);
		public int memberPhoneUpdate(HashMap<String, Object> hash);
		public int memberAddrUpdate(HashMap<String, Object> hash);
		//employee수정
		public int employeePwUpdate(HashMap<String, Object> hash);
		public int employeeEmailUpdate(HashMap<String, Object> hash);
		public int employeePhoneUpdate(HashMap<String, Object> hash);
		public int employeeAddrUpdate(HashMap<String, Object> hash);
		//employee 지점코드값
		public String empStoreCode(String p);
		//tour member_id값
		public MemberVO tourMemberName(String p);
}
