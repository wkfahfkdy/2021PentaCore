package com.yedam.storage.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import com.yedam.storage.member.map.MemberMapper;
import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.mypage.vo.MyPageVO;


public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

	@Autowired MemberMapper memberDAO;
	
	public CustomSuccessHandler() {}
	
	public CustomSuccessHandler(String defaultTargetUrl) {
		setDefaultTargetUrl(defaultTargetUrl);
	}
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		super.onAuthenticationSuccess(request, response, authentication);
		
		// Security에 기본적으로 UserDetails에 User라는 VO가 존재한다.
		// 수업중에 UserVO를 사용한 이유는 커스텀으로 하기 위해서고 CustomUserDetailsService를 사용하지 않는다면
		// 아래와 같이 기본적으로 제공하는 User를 사용하면 된다.
		
		User vo = (User) authentication.getPrincipal();
		
		MemberVO vo2 = new MemberVO();
		vo2.setMember_id(vo.getUsername());
		vo2 = memberDAO.memberInfo(vo2);
		
		MyPageVO vo3 = new MyPageVO();
		vo3.setMember_id(vo.getUsername());
		vo3 = memberDAO.UseCodeInfo(vo3);
		
		request.getSession().setAttribute("loginId", vo2.getMember_id());
		request.getSession().setAttribute("loginName", vo2.getMember_name());
		request.getSession().setAttribute("loginTel", vo2.getMember_tel());
		request.getSession().setAttribute("loginAddr", vo2.getMember_addr());
		// 이용 중인 지점이 없다면 에러가 떠서 != null일 시
		if(vo3 != null) {
			request.getSession().setAttribute("loginStore", vo3.getStore_code());
		}
		
	}

}
