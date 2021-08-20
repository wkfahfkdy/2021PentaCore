package com.yedam.storage.common;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import com.yedam.storage.member.map.MemberMapper;
import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.mypage.vo.MyPageVO;


public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

	@Autowired MemberMapper memberDAO;
	
	public CustomSuccessHandler() {}
	
	public CustomSuccessHandler(String defaultTargetUrl) {
		super.setDefaultTargetUrl(defaultTargetUrl);
	}
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		super.onAuthenticationSuccess(request, response, authentication);
		
		// Security에 기본적으로 UserDetails에 User라는 VO가 존재한다.
		// 수업중에 UserVO를 사용한 이유는 커스텀으로 하기 위해서고 CustomUserDetailsService를 사용하지 않는다면
		// 아래와 같이 기본적으로 제공하는 User를 사용하면 된다.
		User vo = (User) authentication.getPrincipal();
		
		// View에서 값 가져오기
		MemberVO vo2 = new MemberVO();
		vo2.setMember_id(vo.getUsername());
		vo2 = memberDAO.memberInfo(vo2);
		
		// 이용 중인 지점 값 가져오기(Member)
		MyPageVO vo3 = new MyPageVO();
		vo3.setMember_id(vo.getUsername());
		vo3 = memberDAO.UseCodeInfo(vo3);
		
		
		// 아무튼 null이 아닐 때
		if(vo2 != null) {
			// session 값들 저장
			request.getSession().setAttribute("loginId", vo2.getMember_id());
			request.getSession().setAttribute("loginName", vo2.getMember_name());
			request.getSession().setAttribute("loginTel", vo2.getMember_tel());
			request.getSession().setAttribute("loginAddr", vo2.getMember_addr());
			
			// getAuthorities 타입이 이렇더라. List로 되는 것 같은데 잘은 모르겠음. HomeController에서는 List 사용
			Set<GrantedAuthority> authorities = (Set<GrantedAuthority>) vo.getAuthorities();
			String auth = authorities.iterator().next().toString();
			
			// 이용 중인 지점이 없다면 에러가 떠서 ROLE_USER일 시 + Store_code 값이 존재할 시에만 저장
			if(auth.equals("ROLE_USER") && vo3 != null) { 
				// 이용 중인 지점 코드 값 저장 (만료일이 가장 가까운)
				request.getSession().setAttribute("loginStore", vo3.getStore_code());
			}
			
		}
		
		//로그인한 사람이 Store 직원일 때
		MemberVO vo4 = new MemberVO();
		vo4.setMember_id(vo.getUsername());
		vo4 = memberDAO.StoreAdminLoginCheck(vo4);
		
		
		// Store 직원일 때
				if(vo4 != null) {
					// 직원 session 값 저장
					request.getSession().setAttribute("employeeVO", vo4);
					request.getSession().setAttribute("stCode", vo4.getStore_code());
					request.getSession().setAttribute("store_code", vo4.getStore_code());
					request.getSession().setAttribute("empId", vo4.getEmployee_id());
				}
	}

}
