package com.yedam.storage.member.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.member.serviceImpl.MemberServiceImpl;
import com.yedam.storage.member.vo.MemberVO;

@Controller
public class MemberController {

	@Autowired
	private MemberServiceImpl memberDAO;
	
	
	@RequestMapping("memberLoginIdCheck")
	@ResponseBody
	public String userLoginIdCheck(MemberVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
			
			
			MemberVO rvo = memberDAO.memberloginCheck(vo);
			
			String Id = rvo.getMember_id();
			String member_birth = rvo.getMember_birth();
			String memberBirthYear = member_birth.substring(0, 4);
			String memberBirthMonth = member_birth.substring(5,7);
			String memberBirthDay = member_birth.substring(8,10);
			
			HttpSession session = request.getSession();
	        if(rvo != null) {
	        session.setAttribute("loginMemberVO", rvo);
	        session.setAttribute("loginMemberId", Id);
	        
	        //년 월 일 표시
	        session.setAttribute("loginMemberBirth", memberBirthYear+"년 " + memberBirthMonth+"월 " + memberBirthDay +"일 ");
	        }
	        
	        return Id;
	}
	
	@RequestMapping("memberLoginForm")
	public String userLoginForm(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String referer = request.getHeader("Referer");
        session.setAttribute("redirectURI", referer);
        
		return "member/memberLoginForm";
	}
	
}
