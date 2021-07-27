<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberLoginForm.jsp</title>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!--  
private String member_id;
private String member_pwd;
private String member_name;
private String member_addr;
private String member_tel;
private String member_email;
private String member_birth;
private String member_enable;
-->

<script>
	//로그인 function 변수로 지정
	function loginCheck() {
		
		if (frm.member_id.value == "") {
			alert("아이디를 입력하세요.");
			frm.member_id.focus();
			return false;
		}
		if (frm.member_pwd.value == "") {
			alert("비밀번호를 입력하세요.");
			frm.member_pwd.focus();
			return false;
		}
	
		$.ajax({
			url : 'memberLoginIdCheck',
			data : $('#frm').serialize(),
			type : 'post',
			success : function(member) {
			},
			error : function(err) {
				alert("해당하는 회원정보가 없습니다. 다시 시도해주세요.");
			}
		});
	}
	

</script>

<script>
 window.history.forward();
 function noBack(){window.history.forward();}
</script>


</head>
<!--로그인 후 다시 로그인 화면으로 못돌아가게 하기 -->
<body onload="noBack();" onpageshow="if(event.persisted) noBack();"
	onunload="">


	<!-- =========================
     PRE LOADER       
	============================== -->

	<!-- =========================
     END PRE LOADER       
	============================== -->



	<!-- =========================
		END TOP MAIN NAVBAR
	============================== -->

						<!--로그인 화면-->
							<div>
								<h2>
									<b>로그인</b>
								</h2>
								<br>
							</div>
							<form id="frm" action="loginCheck()" method="post">
								<input type="text" id="member_id" name="member_id"
									placeholder="ID" value=""> 
								<input type="password" id="member_pwd" name="member_pwd" 
								placeholder="PASSWORD" onkeyup="if(window.event.keyCode==13)
								{loginCheck()}" value="">
								<div>
									<br>
									<button class="btn btn-light" type="button"
										onclick="loginCheck()"
										style="width: 185px; background: #89ba10; color: white;">로그인</button>
									<button class="btn btn-light" type="button"
										onclick="location.href='memberJoinForm'"
										style="width: 185px; background: #89ba10; color: white;">회원가입</button>
									<br> <br>
									<br> <br>
								</div>
							</form>
</body>
</html>


