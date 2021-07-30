package com.yedam.storage.member.map;

import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;

import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.mypage.vo.MyPageVO;

@MapperScan
public interface MemberMapper {

	public MemberVO loginCheck(MemberVO vo);
	public MemberVO emailCheck(String p);
	public MemberVO telCheck(String p);
	public MemberVO idCheck(String p);
	public int memberInsert(HashMap<String, Object> hash);
	
	public MemberVO modalEmailCheck(MemberVO vo);
	public MemberVO memberInfo(MemberVO vo);
	public MyPageVO UseCodeInfo(MyPageVO vo);
}