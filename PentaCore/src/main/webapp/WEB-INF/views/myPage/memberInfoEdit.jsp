<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>정보수정페이지</title>
<head>

<style>

	select {
	  width: 6em;
	}

	.tab1 {
		float: left;
	}

	.tab2 {
		float: left;
		padding-left: 30px;
	}
	
</style>

<!--  
private String member_id;
private String member_pwd;
private String member_name;
private String member_addr;
private String member_tel;
private String member_email;
private String member_birth;
private String member_disable;
-->

<script>
	$(function() {
		$('#sendEmail').click(function() {

			if ($('#member_email').val() == "") {
				alert('이메일을 입력하세요.');
				$('#member_email').focus();
				return false;
			}
			//email 중복확인 ajax
			$.ajax({
				url : 'sameEmailCheck',
				data : {
					email : $('#member_email').val()
				},
				type : 'post',
				success : function(data) {
					if (data > 0) {
						alert('등록된 이메일이 존재합니다. 새로운 이메일을 입력하세요');
						$('#member_email').val('');
						$('#member_email').focus();
					} else {
						alert('사용가능한 이메일입니다!');
						$('#sendEmail').val('checked');
						$('#emailCode').focus();
						//중복확인 통과후 인증코드 메일보내는 ajax
						$.ajax({
							url : 'sendEmail.do',
							data : {
								email : $('#member_email').val()
							},
							type : 'post',
							success : function(code) {
								alert('메일이 전송되었습니다.');
								$('#checkEmail').click(function() { // 성공해서 이메일에서 값을 건네받은 경우에, 인증번호 버튼을 클릭 시 값을 검사
									if ($('#emailCode').val() == code) { // 사용자의 입력값과 sendSMS에서 받은 값이 일치하는 경우
										alert('인증되었습니다');
										frm.checkEmail.value = 'checked';
									} else {
										alert('인증번호가 틀립니다');
										frm.checkEmail.value = 'unChecked';
									}
								})
							},
							error : function(err) {
								alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
							}
						});
					}
				},
				error : function(err) {
					console.log(err);
				}
			});
		});

	});
</script>


<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
	//주소입력 스크립트
</script>

<script>
	//주소입력
	function findAddr() {
		new daum.Postcode({
			oncomplete : function(data) {

				console.log(data);

				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var jibunAddr = data.jibunAddress; // 지번 주소 변수
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('member_post').value = data.zonecode;
				if (roadAddr !== '') {
					document.getElementById("member_addr").value = roadAddr;
				} else if (jibunAddr !== '') {
					document.getElementById("member_addr").value = jibunAddr;
				}
			}
		}).open();
	}
</script>

<script>
	//휴대폰 번호입력 ajax
	$(function() {
		$('#sendSMS').click(function() { // 클릭하면 인증 번호 보내기
			var tel = $('#member_tel').val(); // 인증번호를 보낼 사용자가 입력한 tel

			if (tel == "") {
				alert('휴대폰번호를 입력하세요.');
				$('#member_tel').focus();
				return false;
			}

			//휴대폰번호 중복확인 ajax
			$.ajax({
				url : 'samePhoneCheck',
				data : {
					tel : tel
				},
				type : 'post',
				success : function(data) {
					if (data > 0) {
						alert('등록된 휴대폰번호가 존재합니다. 새로운 휴대폰번호를 입력하세요');
						$('#member_tel').val('');
						$('#member_tel').focus();
					} else {
						alert('사용가능한 휴대폰번호입니다!');
						$('#sendSMS').val('checked');
						$('#smsKey').focus();

						//사용가능한 휴대폰일때 인증번호 전송 ajax
						if (tel != "") {
							$.ajax({
								url : 'sendSMS',
								data : {
									tel : tel
								},
								type : 'post',
								success : function(code) {
									alert('인증번호가 전송되었습니다');
									$('#checkSMS').click(function() { // 성공해서 sendSMS에서 값을 건네받은 경우에, 인증번호 버튼을 클릭 시 값을 검사
										if ($('#smsKey').val() == code) { // 사용자의 입력값과 sendSMS에서 받은 값이 일치하는 경우
											alert('인증되었습니다');
											frm.checkSMS.value = 'checked';
										} else {
											alert('인증번호가 틀립니다');
										}
									});
								}
							});
						}
					}
				},
				error : function(err) {
					alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
				}
			});
		});
	});
	function formCheck() {

		if (frm.member_pwd.value == "" && frm.member_pwd.value == ""
				&& frm.member_tel.value == "" && frm.member_post.value == "") {
			var delConfirm = confirm("수정할 내용이 없습니다. 홈으로 돌아가시겠습니까?");
			if (delConfirm) {
				alert('수정을 취소하고 홈화면으로 이동합니다.');
				window.location = "home";
			} else {
			}
			return false;
		}

		if (frm.member_pwd.value != frm.member_pwd2.value) {
			alert("비밀번호를 재확인하세요.");
			frm.member_pwd2.focus();
			return false;
		}

		if (frm.member_post.value != "") {
			if (frm.member_detailedAddr.value == "") {
				alert("상세주소를 입력하세요");
				frm.member_detailedAddr.focus();
				return false;
			}
		}

		 if (frm.member_email.value != "") {
		if (frm.checkEmail.value == "unChecked") {
			alert("이메일을 인증 하세요");
			frm.emailCode.focus();
			return false;
			}
		}
		
		if (frm.member_tel.value != "") {
		if (frm.checkSMS.value == "unChecked") {
			alert("문자 인증을 하세요");
			frm.smsKey.focus();
			return false;
			}
		}  
		
		//일부 정보만 수정할 경우 
		if (frm.member_pwd.value == "" || frm.member_email.value == ""
				|| frm.member_tel.value == "" || frm.member_post.value == "") {
			var delConfirm = confirm("작성하지 않은 부분이 있습니다. 입력한 정보만 수정하시겠습니까?");
			if (delConfirm) {
				alert("회원정보가 정상적으로 수정되었습니다");
				frm.submit();
			} else {
			}
			return false;
		}
		//모든 정보 수정할 경우
		frm.submit();
		alert("회원정보가 정상적으로 수정되었습니다");
	}
</script>
<body>
	<div align="center" style="margin-top: 5%;">
		<img  style="width: 250px;" 
				src="${pageContext.request.contextPath }/resources/img/all_logo.png"><br>
		<h5>내정보 수정</h5>

				<!--회원가입 화면-->
			<div align="center" style="display: inline-block;">
				<div align="center" style="padding-top: 3%; ">
				</div>
						<div class="tab1">
						<form id="frm" action="userUpdate" method="post">
							<table style="border: 1; border-collapse: collapse;">
								<tr>
									<td width="300" style=" height: 60px;">
									<input  class="form-control"  type="text" id="member_id" name="member_id" value="${loginId}" readonly
											style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400; cursor:not-allowed;">
									</td>
									<td></td>
								</tr>
								<tr>
									<td style=" height: 60px;">
									<input class="form-control" type="text" id="member_pwd" name="member_pwd" value="password" onfocus="this.value=''; type='password';"
												style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
									<td></td>
								</tr>
								<tr>
									<td style=" height: 60px;">
									<input class="form-control" type="text" id="member_pwd2" name="member_pwd2" value="password 확인" onfocus="this.value=''; type='password';"
									style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
									<td></td>
								</tr>
								<tr>
									<td style=" height: 60px;">
									<input class="form-control" type="text" value="${name }" readonly
											style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;cursor:not-allowed;"></td>
									<td></td>
								</tr>
								
								<c:if test="${birth ne null}">
									<tr>
										<td style=" height: 60px;">
										<input class="form-control" type="text" value="${birth }" readonly
												style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;cursor:not-allowed;"></td>
									<td></td>
									</tr>
								</c:if>
							</table>
							</div>
							<div class="tab2">
							<table style="border: 1; border-collapse: collapse;">
								<tr>
									<td style=" height: 60px;">
									<input class="form-control" type="text" placeholder="${email }" 
												style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
									<td>
										<button class="btn btn-default" style="margin-left: 10%; height: 60%;" type="button" id="sendEmail" value="unChecked">인증코드 전송</button>
									</td>
								</tr>
								<tr>
									<td style=" height: 60px;">
									<input class="form-control" type="text" placeholder="이메일 인증코드" id="emailCode" value=""
											style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td></td>
									<td>
										<button class="btn btn-default" style="margin-left: 10%; height: 60%;" type="button" id="checkEmail"
											value="unChecked">인증코드 확인</button>
									</td>
								</tr>


								<tr>
									<td style=" height: 60px;">
									<input class="form-control" type="text" placeholder="${loginTel }" 
											style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
									<td>
										<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="checkSMS"
											value="unChecked">인증번호 확인</button>
									</td>
								</tr>

								<tr>
									<td style=" height: 60px;">
									<input class="form-control" type="text" placeholder="문자 인증번호" id="smsKey" value=""
											style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
									<td>
									<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="sendSMS"
											value="unChecked">인증번호 전송</button>
									</td>
								</tr>

								<tr>
									<td style="display:flex; ">
									<input class="form-control" id="member_post" type="text" name="memberAddressZip" placeholder="검색" onclick="findAddr()"
											style="width:70px; background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
									<input class="form-control" id="member_addr" type="text" name="member_addr" placeholder="${loginAddr }" 
											style="margin-left:10px; width: 220px; float: right; background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
									</td>
								</tr>
								<tr>
									<td style=" height: 60px;">
									<input class="form-control" id="member_detailedAddr" type="text" placeholder="상세주소" name="member_detailedAddr"
											style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
									<td></td>
								</tr>
							</table>
						</form>
						</div> <br> <br>
						<div style="clear: both; padding-top:7%;"> </div>
						
						<div style="margin-bottom: 10%;">
						<button class="btn btn-primary btn-lg" type="button" onclick="formCheck()">정보수정</button> &nbsp; &nbsp;
						<button class="btn btn-default btn-lg" type="button" onclick="location.href='memberSignOutForm'" >탈퇴하기</button>
						</div>
					</div>
			</div>
</body>