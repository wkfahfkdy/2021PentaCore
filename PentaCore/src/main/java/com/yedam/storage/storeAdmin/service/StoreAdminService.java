package com.yedam.storage.storeAdmin.service;


import java.util.List;

import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

public interface StoreAdminService {

	// 스토리지 현황 클릭시 정보
	public StoreAdminVO selectStorageInfo(StoreAdminVO vo);
	
	public List<StoreAdminVO> usingStrorageList();
	
	// 스토리지 현황 메인페이지
	public List<StoreAdminVO> selectStorageInfoList(StoreAdminVO vo);
	public List<StoreAdminVO> storageName();
	// 지점별 공지사항 리스트
	public List<StoreAdminVO> storeNoticeList(StoreAdminVO vo);
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo);
	
	// 지점별 공지사항 등록
	public int registNotice(StoreAdminVO vo);
	
	
	
	/*
		public MemberVO loginCheck(MemberVO vo);
		public MemberVO StoreAdminLoginCheck(MemberVO vo);
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
		*/
}