package com.yedam.storage.member.emailVerify;

import java.security.MessageDigest;

public class SHA256 {

	public static void main(String[] args) {
		//인증코드 콘솔출력 테스트
		String a = getSHA256("wjsgudals7@naver.com");
		System.out.println(a);
	}
	
	//인증코드 구하기
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] salt = "Hello This is Salt.".getBytes();
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(input.getBytes("UTF-8"));
			for (int i = 0; i<3; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length()==1) result.append("0");
				result.append(hex);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result.toString(); 
		
	}
	
	
	
}
