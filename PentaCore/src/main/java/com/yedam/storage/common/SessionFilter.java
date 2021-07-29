package com.yedam.storage.common;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.GenericFilterBean;

import com.yedam.storage.member.vo.MemberVO;

@WebFilter(urlPatterns = "/memberLoginIdCheck")
public class SessionFilter extends GenericFilterBean{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("1번");
		chain.doFilter(request, response);
		
		if (SecurityContextHolder.getContext().getAuthentication() != null) {
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			// 이 이후로 session 하나씩 등록하면 될듯.
			System.out.println("이게뭐지 : " + principal.getClass().getSimpleName());
			
			if(!principal.getClass().getSimpleName().equals("String")) {
				
				HttpServletRequest req = (HttpServletRequest) request;
				
				HttpSession session = req.getSession();
				
				MemberVO member = (MemberVO) principal;
				
				Object isUser = session.getAttribute("user");
				
				if (isUser == null ) {
					
					req.getSession().setAttribute("user", member);
					
				} else {
					MemberVO oldUser = (MemberVO) isUser;
					if (oldUser.getMember_id() != member.getMember_id()) {
						req.getSession().setAttribute("user", member);
					}
				}
				 
			}
		}
		
		
		
	}

}
