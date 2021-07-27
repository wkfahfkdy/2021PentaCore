package com.yedam.storage.member.vo;

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
public class MemberVO {
private String member_id;
private String member_pwd;
private String member_name;
private String member_addr;
private String member_tel;
private String member_email;
private String member_birth;
private String member_disable;

}
