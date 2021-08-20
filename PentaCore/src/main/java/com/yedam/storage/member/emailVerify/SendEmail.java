package com.yedam.storage.member.emailVerify;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.util.*;

@WebServlet("/sendEmail.do")
public class SendEmail extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

//사용자에게 보낼 메시지를 기입합니다.
		String host = "http://13.124.174.114:8080/storage/home";
		String from = "wjsgudals6@gmail.com";
		String email = request.getParameter("email");
		
		int dValue = (int) (Math.random()*10);
		String iValue = Integer.toString(dValue);

		String to = "MS" + iValue + email;
		String subject = "[My Storage] 이메일 인증 코드";
		String code = new SHA256().getSHA256(to);
		String content = "입력하실 코드는 " + code + " 입니다.";

// SMTP에 접속하기 위한 정보를 기입합니다.

		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtp.googlemail.com");
		p.put("mail.smtp.port", "456");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		// EC2에서 안보내져서 추가한 내용 
		//p.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		//p.put("mail.smtp.ssl.protocols", "TLSv1.2");
	    // EC2에서 안보내져서 추가한 내용 + 그래도 안보내질 시에는 https://annyeongworld.tistory.com/78 참고
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");

		try {
			Authenticator auth = new Gmail();
			Session ses = Session.getInstance(p, auth);
			ses.setDebug(true);
			MimeMessage msg = new MimeMessage(ses);
			msg.setSubject(subject);
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(email);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(content, "text/html;charset=UTF8");
			Transport.send(msg);

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("오류가 발생했습니다.");
			return;
		}
		response.getWriter().print(code);
	}

}


