package com.yedam.member.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.yedam.member.serviceImpl.MemberServiceImpl;
import com.yedam.member.vo.MemberVO;

@Controller
public class MemberController {

	@Autowired
	private MemberServiceImpl memberDAO;
	
	/*
	@RequestMapping("/userLoginIdCheck.do")
	@ResponseBody
	public String userLoginIdCheck(MemberVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
			
			
			MemberVO rvo = memberDAO.memberLoginCheck(vo);
			
			String id ;
			String userBirth = rvo.getClass();
			String userBirthYear = userBirth.substring(0, 4);
			String userBirthMonth = userBirth.substring(5,7);
			String userBirthDay = userBirth.substring(8,10);
			
			HttpSession session = request.getSession();
	        if(rvo != null) {
	        session.setAttribute("loginUserVO", rvo);
	        session.setAttribute("loginUserId", id);
	        
	        //my page 표시용
	        session.setAttribute("loginUserVOBirth", userBirthYear+"년 " + userBirthMonth+"월 " + userBirthDay +"일 ");
	        } 
	        
	        
	        
	        return id;
	}
	*/
	
}
