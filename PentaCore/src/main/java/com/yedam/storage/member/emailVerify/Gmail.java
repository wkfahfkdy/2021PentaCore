package com.yedam.storage.member.emailVerify;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("wjsgudals6@gmail.com", "Project1!");
	}

}
