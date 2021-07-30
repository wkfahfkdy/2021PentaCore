package com.yedam.storage.member.web;

import java.io.IOException;
import java.text.ParseException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.member.serviceImpl.MemberServiceImpl;
import com.yedam.storage.member.vo.MemberVO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class MemberController {

	@Autowired
	private MemberServiceImpl memberDAO;
	
	
	
	// ------------------------------- 로그인 ------------------------------ //
	
	//로그인 페이지 이동
		@RequestMapping("memberLoginForm")
		public String loginForm(HttpServletRequest request, Model model) {
			HttpSession session = request.getSession();
			String referer = request.getHeader("Referer");
			session.setAttribute("redirectURI", referer);

			return "member/memberLoginForm";
		}
		
	//로그인계정 정보 확인
	@RequestMapping("/memberLoginIdCheck")
	@ResponseBody
	public String LoginIdCheck(MemberVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
			
			
			MemberVO rvo = memberDAO.loginCheck(vo);
			System.out.println(rvo.getMember_id());
			String Id = rvo.getMember_id();
			
			
			HttpSession session = request.getSession();
	        if(rvo != null) {
	        session.setAttribute("loginMemberVO", rvo);
	        session.setAttribute("loginMemberId", Id);
	        
	        }
	        return Id;
	}
	
	// ------------------------------- 로그인 화면 아이디/비밀번호 찾기 Modal ------------------------------ //
	
	@RequestMapping("modalEmailCheck")
	@ResponseBody
	public int modalEmailCheck(MemberVO vo, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO rvo = memberDAO.modalEmailCheck(vo);
		
		
		int cnt = 0;
		if (memberDAO.modalEmailCheck(vo) != null) {
			session.setAttribute("modalId", rvo.getMember_id());
			cnt = 1;
		}
		
		System.out.println(session.getAttribute("modalId"));
		
		return cnt;
	}
	//

	// ------------------------------- 로그인 화면 아이디 찾기 Modal ------------------------------ //
	
	
	
	// ------------------------------- 패스워드 찾기 Modal ------------------------------ //
	
	
	
	
	// ------------------------------- 회원가입 ------------------------------ //
	
	//회원가입 화면 이동
	@RequestMapping("memberJoinForm")
	public String joinForm() {
		return "member/memberJoinForm";
	}

	//이메일 중복 체크
	@RequestMapping("sameEmailCheck")
	@ResponseBody
	public int emailCheck(HttpServletRequest request) {

		String email = request.getParameter("email");
		int cnt = 0;
		if (memberDAO.emailCheck(email) != null) {
			cnt = 1;
		}

		return cnt;
	}

	//회원 아이디 중복체크
	@RequestMapping("memberIdCheck")
	@ResponseBody
	public int memberIdCheck(HttpServletRequest request) {

		String id = request.getParameter("id");

		int cnt = 0;
		if (memberDAO.idCheck(id) != null) {
			cnt = 1;
		}

		return cnt;
	}
	
	//휴대폰번호 중복체크
	@RequestMapping("samePhoneCheck")
	@ResponseBody
	public int samePhoneCheck(HttpServletRequest request) {

		String tel = request.getParameter("tel");

		int cnt = 0;
		if (memberDAO.telCheck(tel) != null) {
			cnt = 1;
		}

		return cnt;
	}

	//휴대폰번호 확인문자 전송
	@RequestMapping("sendSMS")
	@ResponseBody
	public String sendSMS(HttpServletRequest req) {

		String targetNum = req.getParameter("tel");

		double rValue = Math.random();
		String code = Double.toString(rValue);
		String textCode = code.substring(2, 7);

		String api_key = "";
		String api_secret = "";
		Message coolsms = new Message(api_key, api_secret);

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", targetNum);
		params.put("from", "01029532154");
		params.put("type", "SMS");
		params.put("text", "인증번호를 입력해주세요: " + textCode);
		params.put("yedamLib", "yedamLib v1.0"); // application name and version

		System.out.println(params.get("text"));

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		return textCode;

	}
	
	
	//회원정보 DB입력
	@RequestMapping("memberJoin")
	public String userJoin(MemberVO vo, HttpServletRequest request) throws ParseException {

		// 테이블양식에 맞게 birth 수정 
		String birthYear = request.getParameter("member_BirthYear");
		String birthMonth = request.getParameter("member_BirthMonth");
		String birthDay = request.getParameter("member_BirthDay");

		String user_Birth = birthYear + "/" + birthMonth + "/" + birthDay;
		
		// 테이블양식에 맞게 tel 수정 
		String tel = null;
		int telLength = vo.getMember_tel().length();
		
		if (telLength == 11) {
			tel = vo.getMember_tel().substring(0,3) + "-"+ vo.getMember_tel().substring(3,7) + "-" + vo.getMember_tel().substring(7);
		} else if (telLength == 10) {
			tel = vo.getMember_tel().substring(0,3) + "-"+ vo.getMember_tel().substring(3,6) + "-" + vo.getMember_tel().substring(6);
		}

		// 테이블양식에 맞게 address 수정 
		String member_post = request.getParameter("memberAddressZip");
		String member_addr = request.getParameter("memberAddress");
		String member_detailedAddr = request.getParameter("memberAddressDetail");

		String member_Addr = member_addr + " " + member_detailedAddr + " " + member_post;

		HashMap<String, Object> hash = new HashMap<>();
		hash.put("member_id", vo.getMember_id());
		hash.put("member_name", vo.getMember_name());
		hash.put("member_pwd", vo.getMember_pwd());
		hash.put("member_addr", member_Addr);
		hash.put("member_tel", tel);
		hash.put("member_email", vo.getMember_email());
		hash.put("member_birth", user_Birth);

		memberDAO.memberInsert(hash);

		return "member/memberLoginForm";
	}
	
	
	
	
	// ------------------------------- 정보수정 ------------------------------ //
	
		@RequestMapping("memberInfoEdit")
		public String memberInfoEdit() {
			return "myPage/memberInfoEdit";
		}
}
