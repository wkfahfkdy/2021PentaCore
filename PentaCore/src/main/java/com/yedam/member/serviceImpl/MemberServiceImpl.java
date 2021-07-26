package com.yedam.member.serviceImpl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.member.service.MemberService;
import com.yedam.member.vo.MemberVO;

@Repository("MemberDAO")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public MemberVO memberLoginCheck(MemberVO vo) {
		return sqlSession.selectOne("loginCheck",vo);
	}

}
