package com.yedam.storage.member.serviceImpl;

import org.apache.ibatis.annotations.Param;
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
	public MemberVO loginCheck(MemberVO vo) {
		return sqlSession.selectOne("loginCheck",vo);
	}


	@Override
	public MemberVO emailCheck(@Param("p") String email) {
		return sqlSession.selectOne("emailCheck",email) ;
	}


	@Override
	public MemberVO telCheck(@Param("p") String tel) {
		return sqlSession.selectOne("telCheck",tel);
	}

	@Override
	public MemberVO idCheck(@Param("p") String id) {
		return sqlSession.selectOne("idCheck",id);
	}

}
