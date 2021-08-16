package com.yedam.storage.member.web;

import java.io.IOException;
import java.text.ParseException;
import java.util.HashMap;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	
	// 로그인 페이지 이동
	@RequestMapping("memberLoginForm")
	public String loginForm(HttpServletRequest request, Model model) {
		String error = request.getParameter("error");
		if(error != null && error.equals("true")) {
			model.addAttribute("errorMsg", "아이디 혹은 비밀번호를 확인해주세요");
		}
		
		HttpSession session = request.getSession();
		String referer = request.getHeader("Referer");
		session.setAttribute("redirectURI", referer);

		return "member/memberLoginForm";
	}


	// 로그인하는 아이디 패스워드 맞는지 확인
	@RequestMapping("/memberLoginIdCheck1")
	@ResponseBody
	public String LoginIdCheck1(MemberVO vo, HttpServletRequest request, HttpServletResponse response, Model model)
			throws IOException {

		MemberVO rvo = memberDAO.loginCheck(vo);
		MemberVO employeeVO = memberDAO.employeeLoginCheck(vo);

		String id = "";

		//HttpSession session = request.getSession();
		if (rvo != null || employeeVO != null) {
			id = "valid";
		} else {
			id = "invalid";
		}

		return id;
	}

	//로그인계정 정보 확인
	@RequestMapping("/memberLoginIdCheck")
	@ResponseBody
	public String LoginIdCheck(MemberVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
			
			
			MemberVO rvo = memberDAO.loginCheck(vo);
			MemberVO employeeVO = memberDAO.StoreAdminLoginCheck(vo);
			
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
			
			/* hash map에 session 넣기 (session.invalidate()시 전체 session이 날라가서 만들었지만 사용x)
			HashMap<String, HttpSession> hash = new HashMap<String, HttpSession>();
			hash.put("session", session);
			hash.get("session").setAttribute("modalId", rvo.getMember_id());
			hash.get("session").getAttribute("modalId");
			*/
			cnt = 1;
		}
		
		return cnt;
	}
	//

	// ------------------------------- 로그인 화면 아이디 찾기 Modal ------------------------------ //
	
	// 로그인 페이지 이동
		@RequestMapping("memberLoginIdShowModal")
		public String memberLoginIdShowModal(HttpServletRequest request, Model model) {
			HttpSession session = request.getSession();
			String referer = request.getHeader("Referer");
			session.setAttribute("redirectURI", referer);

			return "member/memberLoginIdShowModal";
		}
	
		// ------------------------------- 로그인 화면 패스워드 찾기 Modal ------------------------------ //

		// 비밀번호 찾기 입력값 확인
		@RequestMapping("memberPwFindCheck")
		@ResponseBody
		public int memberPwFindCheck(MemberVO vo, HttpServletRequest request, Model model) {

			HttpSession session = request.getSession();

			// 입력한 이름 가져오기
			String name = request.getParameter("member_name");
			vo.setMember_name(name);

			// 입력한 휴대폰 번호 가져오기
			String tel = request.getParameter("member_tel");
			int telLength = tel.length();

			if (telLength == 11) {
				tel = vo.getMember_tel().substring(0, 3) + "-" + vo.getMember_tel().substring(3, 7) + "-"
						+ vo.getMember_tel().substring(7);
			} else if (telLength == 10) {
				tel = vo.getMember_tel().substring(0, 3) + "-" + vo.getMember_tel().substring(3, 6) + "-"
						+ vo.getMember_tel().substring(6);
			}
			vo.setMember_tel(tel);

			// 입력한 아이디 가져오기
			String member_id = request.getParameter("member_id");
			vo.setMember_id(member_id);

			// 해당 고객 DB에서 검색 -> rvo에 저장
			MemberVO rvo = memberDAO.modalPwCheck(vo);
			
			int cnt = 0;
			if (rvo != null) {
			// 해당 고객의 아이디 가져옴(아이디에 새로운 비밀번호 업데이트 위해)
			String pwdFindingId = rvo.getMember_id();
			session.setAttribute("pwdFindingId", pwdFindingId);
			cnt = 1;
			}
			return cnt;
		}

		// 비밀번호 재설정 창 이동
		@RequestMapping("memberLoginPwShowModal")
		public String memberLoginPwShowModal(MemberVO vo, HttpServletRequest request, Model model) {
			
			HttpSession session = request.getSession();
			String referer = request.getHeader("Referer");
			session.setAttribute("redirectURI", referer);

			return "member/memberLoginPwShowModal";
		}
		
		// 새롭게 입력한 비밀번호로 업데이트
		@RequestMapping("updateNewPwd")
		@ResponseBody
		public int updateNewPwd(MemberVO vo, HttpServletRequest request, Model model) {
			
			
			
			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("pwdFindingId");
			
			// 비밀번호 암호화
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(16);
			String EncodePwd = encoder.encode(request.getParameter("member_pwd"));
			
			
			HashMap<String, Object> param = new HashMap<>();
			
			param.put("member_id", id);
			param.put("member_pwd", EncodePwd);
			
			
			
			int cnt = 0;
			if (memberDAO.memberNewPwd(param) != 0) {
				memberDAO.memberNewPwd(param);
				cnt = 1;
			}
			
			System.out.println("fasfasfasdgasdgsadgsdagsadgsdg           " + cnt);
			return cnt;
			
			
		
		}
	
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
		
		// 비밀번호 암호화
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(16);
		String EncodePwd = encoder.encode(vo.getMember_pwd());
		vo.setMember_pwd(EncodePwd);

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

		String member_Addr = member_addr + " " + member_detailedAddr + " (우편번호:" + member_post + ")";

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
		public String memberInfoEdit(HttpServletRequest request, Model model) {
			HttpSession session = request.getSession();
		    //아이디 확인
			String id = (String) session.getAttribute("loginId");
			
			//member + employee view
			MemberVO rvo = memberDAO.getMemberInfo(id);
			
			//model에 이름 저장
			String name = rvo.getMember_name();
			String email = rvo.getMember_email();
			model.addAttribute("name", name);
			model.addAttribute("email", email);
			
			//id가 member일 경우 model에 생일 추가
			MemberVO rvo1 = memberDAO.idCheck(id);
			if(rvo1 != null) {
				String birth = rvo1.getMember_birth();
				model.addAttribute("birth", birth);
			}
			
			return "myPage/memberInfoEdit";
		}
		
		@RequestMapping("userUpdate")
		public String memberUpdate(MemberVO vo, HttpServletRequest request) {
			
			String id = request.getParameter("member_id");
			
			
			// 테이블양식에 맞게 address 수정
			String member_post = request.getParameter("memberAddressZip");
			String member_addr = request.getParameter("member_addr");
			String member_detailedAddr = request.getParameter("member_detailedAddr");

			String member_Addr = member_addr + " " + member_detailedAddr + " (우편번호:" + member_post + ")";

			// 비밀번호 암호화
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(16);
			String EncodePwd = encoder.encode(vo.getMember_pwd());
			vo.setMember_pwd(EncodePwd);
			
			
			HashMap<String, Object> param = new HashMap<>();
			
			//회원정보수정 요청자가 직원일때 
			MemberVO rvo1 = memberDAO.idCheck(id); 
			if(rvo1 == null) {
				
				param.put("employee_id", id);
				
				if(!vo.getMember_pwd().equals("")) {
					param.put("employee_pwd", vo.getMember_pwd());
					memberDAO.employeePwUpdate(param);
				} 
				if (!vo.getMember_email().equals("")) {
					param.put("employee_email", vo.getMember_email());
					memberDAO.employeeEmailUpdate(param);
				} 
				
				if(!vo.getMember_tel().equals("")) { 
					param.put("employee_tel", vo.getMember_tel());
					memberDAO.employeePhoneUpdate(param); 
				} 
				
				if (!member_post.equals("")) {
					param.put("employee_addr", member_Addr); 
					memberDAO.employeeAddrUpdate(param); 
				}
			//회원정보수정 요청자가 회원일때 	
			} else {
				param.put("member_id", id);
				
				if(!vo.getMember_pwd().equals("")) {
					param.put("member_pwd", vo.getMember_pwd());
					memberDAO.memberPwUpdate(param);
				} 
				if (!vo.getMember_email().equals("")) {
					param.put("member_email", vo.getMember_email());
					memberDAO.memberEmailUpdate(param);
				} 
				
				if(!vo.getMember_tel().equals("")) { 
					param.put("member_tel", vo.getMember_tel());
					memberDAO.memberPhoneUpdate(param); 
				} 
				
				if (!member_post.equals("")) {
					param.put("member_addr", member_Addr); 
					memberDAO.memberAddrUpdate(param); 
				} 	
			}
			
			return "redirect:memberInfoEdit";
			

		}
		
}
