package com.yedam.storage.member.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.*;

/*
MEMBER_ID	VARCHAR2(20 BYTE)	No		1	고객ID
MEMBER_PWD	VARCHAR2(20 BYTE)	Yes		2	패스워드
MEMBER_NAME	VARCHAR2(21 BYTE)	Yes		3	고객이름
MEMBER_ADDR	VARCHAR2(150 BYTE)	Yes		4	주소
MEMBER_TEL	VARCHAR2(14 BYTE)	Yes		5	연락처
MEMBER_EMAIL	VARCHAR2(40 BYTE)	Yes		6	이메일
MEMBER_BIRTH	VARCHAR2(8 BYTE)	Yes		7	생년월일
MEMBER_ENABLE	VARCHAR2(1 BYTE)	Yes	'N'  	8	탈퇴여부
*/

@Data
@Getter @Setter
public class MemberVO implements UserDetails {
	
// MEMBER
private String member_id;
private String member_pwd;
private String member_name;
private String member_addr;
private String member_tel;
private String member_email;
private String member_birth;
private String member_disable;
private String role_name;
// EMPLOYEES
private String employee_id;
private String employee_pwd;
private String employee_name;
private String employee_addr;
private String employee_tel;
private String employee_email;
private String employee_disable;
private String department_id;
private String store_code;

@Override
public Collection<? extends GrantedAuthority> getAuthorities() {
	
	List<GrantedAuthority> auth = new ArrayList<>();
	auth.add(new SimpleGrantedAuthority(this.role_name.toUpperCase()));
	
	return auth;
}
@Override
public String getPassword() {
	return member_pwd;
}
@Override
public String getUsername() {
	return member_id;
}
@Override
public boolean isAccountNonExpired() {
	return true;
}
@Override
public boolean isAccountNonLocked() {
	return true;
}
@Override
public boolean isCredentialsNonExpired() {
	return true;
}
@Override
public boolean isEnabled() {
	return true;
}

}
