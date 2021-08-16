package com.yedam.storage.member.serviceImpl;

import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.yedam.storage.member.service.MemberService;
import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.mypage.vo.MyPageVO;
import com.yedam.storage.tour.vo.TourVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSession sqlSession;
	
	
	//로그인
	@Override
	public MemberVO loginCheck(MemberVO vo) {
		return sqlSession.selectOne("loginCheck",vo);
	}
	@Override
	public MemberVO employeeLoginCheck(MemberVO vo) {
		return sqlSession.selectOne("employeeLoginCheck",vo);
	}
	//지점관리자 
	@Override
	public MemberVO StoreAdminLoginCheck(MemberVO vo) {
		return sqlSession.selectOne("StoreAdminLoginCheck",vo);
	}
	
	//로그인(아이디 찾기)
	public MemberVO modalEmailCheck(MemberVO vo) {
		return sqlSession.selectOne("modalEmailCheck",vo);		
	}
	
	//로그인(비밀번호 찾기)
	public MemberVO modalPwCheck(MemberVO vo) {
		return sqlSession.selectOne("modalPwCheck",vo);
	}
	
	//로그인(비밀번호 재설정)
	public int memberNewPwd(HashMap<String, Object> hash) {
		return sqlSession.update("memberNewPwd",hash);
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

	@Override
	public MemberVO memberInfo(MemberVO vo) {
		
		return sqlSession.selectOne("memberInfo", vo);
	}

	@Override
	public MyPageVO UseCodeInfo(MyPageVO vo) {
		
		return sqlSession.selectOne("UseCodeInfo", vo);
	}

	//회원정보 수정
	@Override
	public MemberVO getMemberInfo(@Param("p") String memberId) {
		return sqlSession.selectOne("getMemberInfo", memberId);
	}

	@Override
	public int memberPwUpdate(HashMap<String, Object> hash) {
		return sqlSession.update("memberPwUpdate",hash);
	}

	@Override
	public int memberEmailUpdate(HashMap<String, Object> hash) {
		return sqlSession.update("memberEmailUpdate",hash);
	}

	@Override
	public int memberPhoneUpdate(HashMap<String, Object> hash) {
		return sqlSession.update("memberPhoneUpdate",hash);
	}

	@Override
	public int memberAddrUpdate(HashMap<String, Object> hash) {
		return sqlSession.update("memberAddrUpdate",hash);
	}

	@Override
	public int employeePwUpdate(HashMap<String, Object> hash) {
		return sqlSession.update("employeePwUpdate",hash);
	}

	@Override
	public int employeeEmailUpdate(HashMap<String, Object> hash) {
		return sqlSession.update("employeeEmailUpdate",hash);
	}

	@Override
	public int employeePhoneUpdate(HashMap<String, Object> hash) {
		return sqlSession.update("employeePhoneUpdate",hash);
	}

	@Override
	public int employeeAddrUpdate(HashMap<String, Object> hash) {
		return sqlSession.update("employeeAddrUpdate",hash);
	}

	@Override
	public String empStoreCode(String p) {
		return sqlSession.selectOne("empStoreCode", p);
	}

	@Override
	public MemberVO tourMemberName(String p) {
		return sqlSession.selectOne("tourMemberName", p);
	}


	

}
