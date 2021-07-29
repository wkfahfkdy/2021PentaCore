package com.yedam.storage.member.serviceImpl;

import java.util.HashMap;

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
	
	
	//로그인
	@Override
	public MemberVO loginCheck(MemberVO vo) {
		return sqlSession.selectOne("loginCheck",vo);
	}
	
	//로그인(비밀번호 찾기)
	public MemberVO pwEmailCheck(MemberVO vo) {
		return sqlSession.selectOne("pwEmailCheck",vo);		
	}
	
	

	//회원가입
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
	
	@Override
	public int memberInsert(HashMap<String,Object> hash) {
		return sqlSession.insert("memberInsert",hash);
	}


	

}
