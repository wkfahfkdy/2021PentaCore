package com.yedam.storage.member.map;

import java.util.ArrayList;

import com.yedam.storage.member.vo.MemberVO;

public interface MemberMap {
	
	public ArrayList<MemberVO> selectMemberList();
	
	public MemberVO memberLoginCheck(MemberVO vo);
	public MemberVO selectMember();
	public MemberVO loginCheck();
	public int insertMember();
	public int updateMember();
	public int deleteMember();

}
