package com.yedam.storage.member.serviceImpl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.member.service.MemberService;
import com.yedam.storage.member.vo.MemberVO;

@Repository("MemberDAO")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public MemberVO memberloginCheck(MemberVO vo) {
		return sqlSession.selectOne("loginCheck",vo);
	}

}
