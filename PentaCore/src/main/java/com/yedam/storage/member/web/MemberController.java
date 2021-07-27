package com.yedam.storage.member.web;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

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
	        
	        
	        /*
			 * String member_birth = rvo.getMember_birth(); String memberBirthYear =
			 * member_birth.substring(0, 4); String memberBirthMonth =
			 * member_birth.substring(5,7); String memberBirthDay =
			 * member_birth.substring(8,10);
			 */
	        //년 월 일 표시
	        //session.setAttribute("loginMemberBirth", memberBirthYear+"년 " + memberBirthMonth+"월 " + memberBirthDay +"일 ");
	        //}
	        
	        }
	        return Id;
	}
	
	@RequestMapping("memberLoginForm")
	public String loginForm(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String referer = request.getHeader("Referer");
        session.setAttribute("redirectURI", referer);
        
		return "member/memberLoginForm";
	}
	
	
	//------------------------------- 회원가입 ------------------------------ //
	
	/*
	 * @RequestMapping("memberJoinForm") public String joinForm() { return
	 * "member/memberJoinForm"; }
	 * 
	 * @RequestMapping("sameEmailCheck")
	 * 
	 * @ResponseBody public int emailCheck(HttpServletRequest request) {
	 * 
	 * String email = request.getParameter("email");
	 * 
	 * int cnt = 0; if(UsersDAO.emailCheck(email) != null) { cnt = 1; }
	 * 
	 * return cnt; }
	 * 
	 * @RequestMapping("/userIdCheck.do")
	 * 
	 * @ResponseBody public int userIdCheck(HttpServletRequest request) {
	 * 
	 * String id = request.getParameter("id");
	 * 
	 * int cnt = 0; if(UsersDAO.idCheck(id) != null) { cnt = 1; }
	 * 
	 * return cnt; }
	 * 
	 * @RequestMapping("/userJoin.do") public String userJoin(UsersVO vo,
	 * HttpServletRequest request) throws ParseException {
	 * 
	 * //테이블양식에 맞게 birth 수정 String birthYear =
	 * request.getParameter("user_BirthYear"); String birthMonth =
	 * request.getParameter("user_BirthMonth"); String birthDay =
	 * request.getParameter("user_BirthDay");
	 * 
	 * String user_Birth = birthDay + "/" + birthMonth + "/" +birthYear; Date
	 * user_Birth1 =new SimpleDateFormat("dd/MM/yyyy").parse(user_Birth);
	 * 
	 * //테이블양식에 맞게 address 수정 String user_post =
	 * request.getParameter("userAddressZip"); String user_addr =
	 * request.getParameter("userAddress"); String user_detailedAddr =
	 * request.getParameter("userAddressDetail");
	 * 
	 * String user_Addr = user_addr + " " + user_detailedAddr + " " + user_post ;
	 * 
	 * 
	 * HashMap<String, Object> param = new HashMap<>(); param.put("user_Id",
	 * vo.getUser_Id()); param.put("user_Name", vo.getUser_Name());
	 * param.put("user_Pw", vo.getUser_Pw()); param.put("user_Gender",
	 * vo.getUser_Gender()); param.put("user_Email", vo.getUser_Email());
	 * param.put("user_Phone", vo.getUser_Phone()); param.put("user_Addr",
	 * user_Addr); param.put("user_Birth", user_Birth1);
	 * 
	 * UsersDAO.userInsert(param);
	 * 
	 * return "redirect:userLoginForm.do"; }
	 */
}
