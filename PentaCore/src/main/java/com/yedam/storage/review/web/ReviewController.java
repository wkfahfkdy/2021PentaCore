package com.yedam.storage.review.web;

import java.io.IOException;
import java.text.ParseException;
import java.util.HashMap;

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
import com.yedam.storage.review.serviceImpl.ReviewServiceImpl;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class ReviewController {

	@Autowired
	private ReviewServiceImpl reviewDAO;
	
	
	
	// ------------------------------- 이용후기 ------------------------------ //
	
	//이용후기 페이지 이동
		@RequestMapping("reviewList")
		public String loginForm(HttpServletRequest request, Model model) {
			return "review/reviewList";
		}
		
	
	
	
	// ------------------------------- 정보수정 ------------------------------ //
	
		@RequestMapping("memberInfoEdit")
		public String memberInfoEdit(HttpServletRequest request, Model model) {
			/*
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
			*/
			
			return "redirect:memberInfoEdit";
			

		}
		
}
