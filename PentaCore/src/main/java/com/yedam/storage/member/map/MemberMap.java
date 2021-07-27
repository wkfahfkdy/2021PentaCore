package com.yedam.storage.member.map;

import java.util.ArrayList;

import com.yedam.storage.member.vo.MemberVO;

public interface MemberMap {
	
	public ArrayList<MemberVO> selectMemberList();
	
	public MemberVO memberloginCheck(MemberVO vo);
	
	public MemberVO selectMember();
	public int insertMember();
	public int updateMember();
	public int deleteMember();

}
