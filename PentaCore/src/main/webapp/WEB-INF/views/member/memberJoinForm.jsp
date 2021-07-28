<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>회원가입 페이지</title>
<head>

<style>
td {
  width: 150px;
}
select {
  width: 6em;
}

input {
  width: 150px;
}
</style>

<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
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
				data : {email : $('#member_email').val() },
				type : 'post',
				success : function(data) {
					if (data > 0) {
						alert('등록된 이메일이 존재합니다. 새로운 이메일을 입력하세요');
						$('#member_email').val('');
						$('#member_email').focus();
					} else {
						alert('등록가능한 이메일입니다.');
						$('#sendEmail').val('checked');
						$('#emailCode').focus();
						//이메일 중복확인 통과후 인증코드 메일보내는 ajax
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

<script>
	//아이디 중복체크
	$(function() {
		$('#idCheck').click(function() {
			if($('#member_id').val()=="") {
				alert('아이디를 입력하세요.');
				$('#member_id').focus();
				return;
			}
			$.ajax({
				url:'memberIdCheck',
				data: {id: $('#member_id').val()},
				type: 'post',
				success: function(data){
					if(data>0) {
						alert('등록된 아이디가 존재합니다. 새로운 아이디를 입력하세요');
						$('#member_id').val('');
						$('#member_id').focus();
					} else{
						alert('사용가능한 아이디입니다.');
						$('#idCheck').val("checked");
						$('#member_pwd').focus();
					}
				},
				error: function(err){
					alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
				}
			});
		});
	});
</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"> //주소입력 스크립트
</script>

<script>
//주소입력
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {        	
        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('member_post').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("member_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
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
						alert('등록가능한 휴대폰번호입니다.');
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
		if (frm.member_id.value == "") {
			alert("아이디를 입력하세요.");
			frm.user_Id.focus();
			return false;
		}
		if (frm.idCheck.value == 'UnChecked') {
			alert("ID 중복체크를 하세요.");
			return false;
		}
		if (frm.member_pwd.value == "") {
			alert("비밀번호를 입력하세요.");
			frm.user_Pw.focus();
			return false;
		}

		if (frm.member_pwd.value != frm.member_pwd2.value) {
			alert("비밀번호를 재확인하세요.");
			frm.user_Pw2.focus();
			return false;
		}
		if (frm.member_name.value == "") {
			alert("이름을 입력하세요.");
			return false;
		}
		if (frm.member_email.value == "") {
			alert("이메일을 입력하세요.");
			return false;
		}
		if (frm.member_tel.value == "") {
			alert("휴대폰번호를 입력하세요.");
			return false;
		}
		if (frm.member_post.value == "") {
			alert("주소를 입력하세요");
			frm.smsKey.focus();
			return false;
		}
		if (frm.member_detailedAddr.value == "") {
			alert("상세주소를 입력하세요");
			frm.member_detailedAddr.focus();
			return false;
		}
		/*
		if (frm.checkEmail.value == "unChecked") {
			alert("이메일을 인증 하세요");
			frm.emailCode.focus();
			return false;
		}
		*/
		/*
		if (frm.checkSMS.value == "unChecked") {
			alert("문자 인증을 하세요");
			frm.smsKey.focus();
			return false;
		}    
		*/
		frm.submit();
		alert("정상적으로 회원가입 되었습니다");
	}
</script>
</head>
<body>
			<!--회원가입 화면-->
			
			<div align="center">
					<h2><b>회원가입</b></h2>
			<br>
			<form id="frm" action="memberJoin" method="post">
			<table style="border:1; border-collapse:collapse;">
					<tr>
						<th width="150">아이디</th>
						<td width="300">
							<input class="form-control" type="text" id="member_id" name="member_id">
						</td>
						<td width="300">
							<button class="btn btn-light" type="button" id="idCheck" value="unChecked">중복체크</button>
						</td>
					</tr>
					<tr>
						<th width="150">비밀번호</th>
						<td width="300" colspan="2">
						<input class="form-control" type="password" id="member_pwd"
							name="member_pwd"></td>
					</tr>
					<tr>
						<th width="150">비밀번호 재확인</th>
						<td width="300" colspan="2">
						<input class="form-control" type="password" id="member_pwd2"
							name="member_pwd2"></td>
					</tr>
					<tr>
						<th width="150">이름</th>
						<td width="300" colspan="2">
						<input class="form-control" type="text" id="member_name"
							name="member_name"></td>
					</tr>
					
					<tr>
						<th width="150">생년월일</th>
							<td width="100" colspan="2" >
							<select class="custom-select"
								name="member_BirthYear" id="member_BirthYear" >
										<option selected>----</option>
										<% for (int i=2021; i>1900; i--) { %>
											<option value= "<%=i%>"><%=i%></option>
											<% } %>
							</select><b>년</b> &nbsp;&nbsp;&nbsp;
							
							
						<select class="custom-select" name="member_BirthMonth" id= "member_BirthMonth">
								<option selected>--</option>
										<% for (int i=1; i<=12; i++) { %>
											<option value= "<%=i%>"><%=i%></option>
											<% } %>
						</select><b>월</b> &nbsp;&nbsp;&nbsp;
						
						
						<select class="custom-select" name="member_BirthDay" id="member_BirthDay">
								<option selected>--</option>
								<% for (int i=1; i<=31; i++) { %>
											<option value= "<%=i%>"><%=i%></option>
											<% } %>
						</select><b>일</b>
						</td>
					</tr>

					<tr>
						<th>이메일</th>
						<td width="350" colspan="2">
 						<input class="form-control" type="text" id="member_email" name="member_email" value="">
 						</td>
 						<td>
 						<button class="btn btn-light" type="button" id="sendEmail" value="unChecked">인증코드 전송</button>
 						</td>
 						</tr>
 						<tr>
 						<th></th>
 						<td width="350" colspan="2">
 						<input class="form-control" type="text" placeholder="이메일 인증코드" id="emailCode" value="">
 						</td>
 						<td>
 						<button class="btn btn-light" type="button" id="checkEmail" value="unChecked">인증코드 확인</button>
						</td>
					</tr>
					
					<tr><td colspan="2">&nbsp;</td></tr>
					
					<tr>
						<th width="150">휴대폰 번호</th>
						<td width="350" colspan="2"><input class="form-control" type="text" id="member_tel"
							name="member_tel" placeholder ="'-'없이 숫자만 입력" >
						</td>
						<td>
							<button class="btn btn-light" type="button" id="sendSMS" value="unChecked">인증번호 전송</button>
						</td>
					</tr>
					<tr>
						<th></th>
						<td width="350" colspan="2">
 						<input class="form-control" type="text" placeholder="문자 인증번호" id="smsKey" value="">
 						</td>
 						<td>
 						<button class="btn btn-light" type="button" id="checkSMS" value="unChecked">인증번호 확인</button>
						</td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<th width="150">주소
						</th>
						<td width="300">
						<input class="form-control" id="member_post" type="text" name="memberAddressZip" placeholder="Zip Code" readonly onclick="findAddr()">
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
  						<input class="form-control" id="member_addr" type="text" name="memberAddress" placeholder="Address" readonly>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
 						<input class="form-control" id="member_detailedAddr" type="text" placeholder="Detailed Address" name="memberAddressDetail">
						</td>
					</tr>
			</table>
			</form>
			<br>
				<button class="btn btn-light" type="button"
					onclick="formCheck()" style="width: 110px; height: 45px; background: #89ba10; color: white;">회원가입</button>
			</div>
			
</body>
</html>