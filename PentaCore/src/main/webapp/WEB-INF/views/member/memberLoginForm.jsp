<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberLoginForm.jsp</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

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
			url : 'userLoginIdCheck.do',
			data : $('#frm').serialize(),
			type : 'post',
			success : function(user) {
				
				if(user_Id != null) {
					window.location.href="${redirectURI}"
					
			}
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

<style>
/* STRUCTURE */
.wrapper {
	display: flex;
	align-items: center;
	flex-direction: column;
	justify-content: center;
	width: 100%;
	height: 60%;
	padding: 20px;
}

a {
	text-decoration: none;
	outline: none;
	color: #000;	
}

a:hover,
a:focus {
	text-decoration: none;
	outline: none;
	color: #000;
}

.swal-text {
 	color: #212529;
}

.swal-button{
  padding: 7px 19px;
  border-radius: 2px;
  background-color: #212529;
  font-size: 12px;
  font-color: #212529;
  text-shadow: 0px -1px 0px rgba(0, 0, 0, 0.3);
}

#formContent {
	-webkit-border-radius: 10px 10px 10px 10px;
	border-radius: 10px 10px 10px 10px;
	background: #fff;
	padding: 30px;
	width: 90%;
	max-width: 450px;
	position: relative;
	padding: 0px;
	-webkit-box-shadow: 0 30px 60px 0 rgba(0, 0, 0, 0.3);
	box-shadow: 0 30px 60px 0 rgba(0, 0, 0, 0.3);
	text-align: center;
}

/* FORM TYPOGRAPHY*/
input[type=button], input[type=submit], input[type=reset] {
	background-color: #56baed;
	border: none;
	color: white;
	padding: 15px 80px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	text-transform: uppercase;
	font-size: 13px;
	-webkit-box-shadow: 0 10px 30px 0 rgba(95, 186, 233, 0.4);
	box-shadow: 0 10px 30px 0 rgba(95, 186, 233, 0.4);
	-webkit-border-radius: 5px 5px 5px 5px;
	border-radius: 5px 5px 5px 5px;
	margin: 5px 20px 40px 20px;
	-webkit-transition: all 0.3s ease-in-out;
	-moz-transition: all 0.3s ease-in-out;
	-ms-transition: all 0.3s ease-in-out;
	-o-transition: all 0.3s ease-in-out;
	transition: all 0.3s ease-in-out;
}

input[type=button]:active, input[type=submit]:active, input[type=reset]:active,
	input[type=password]:active {
	-moz-transform: scale(0.95);
	-webkit-transform: scale(0.95);
	-o-transform: scale(0.95);
	-ms-transform: scale(0.95);
	transform: scale(0.95);
}

input[type=text], input[type=password] {
	background-color: #f6f6f6;
	border: none;
	color: #0d0d0d;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 5px;
	width: 60%;
	border: 2px solid #f6f6f6;
	-webkit-transition: all 0.5s ease-in-out;
	-moz-transition: all 0.5s ease-in-out;
	-ms-transition: all 0.5s ease-in-out;
	-o-transition: all 0.5s ease-in-out;
	transition: all 0.5s ease-in-out;
	-webkit-border-radius: 5px 5px 5px 5px;
	border-radius: 5px 5px 5px 5px;
}

input[type=text]:focus, input[type=password]:focus {
	background-color: #fff;
	border-bottom: 2px solid #212529;
}

input[type=text]:placeholder, input[type=password]:placeholder {
	color: #cccccc;
}

</style>
</head>
<!--로그인 후 다시 로그인 화면으로 못돌아가게 하기 -->
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<!-- 상단배너 -->
<section class="section-hero overlay inner-page bg-image"
	style="background-image: url('resources/images/main.jpg');" id="home-section">
	<div class="container">
		<div class="row">
			<div class="col-md-12" align="center">
				<h1 class="text-white font-weight-bold">회원정보</h1>
				<div class="custom-breadcrumbs">
					<a href="home.do">Home</a> <span class="mx-2 slash">/</span> <span
						class="text-white"><strong>로그인</strong></span>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="site-section block__18514" id="next-section">
	<div class="container">
		<div class="row">
			<div class="col-lg-3 mr-3">
				<div class="rounded">
					<div class="sidenav">
						<ul class="list-unstyled">
							<li class="sideactive"><a href="userLoginForm.do">로그인</a></li>
							<li><a href="userJoinForm.do">회원가입</a></li>
						</ul>
					</div>
				</div>
			</div>
			<!--로그인 화면-->
		 		<div class="col-lg-7" align = "center">
			<div class="container">
				<h2><b>로그인</b></h2>
				<br>
			</div>
			<form id="frm" action="loginCheck()" method="post">
				<input type="text" id="user_Id" name="user_Id" class="fadeIn first" placeholder="ID" value="">
				<input type="password" id="user_Pw" name="user_Pw" class="fadeIn first" placeholder="PASSWORD"
				 onkeyup="if(window.event.keyCode==13){loginCheck()}" value="">
				<div class="fadeIn Second">
					<br>
					<button class="btn btn-light" type="button"
						onclick="location.href='home.do'" style="width: 185px;" >HOME</button>
					<button class="btn btn-light" type="button"
						onclick="loginCheck()" style="width: 185px; background: #89ba10; color: white;">로그인</button>
					<br> <br>
					<p>아직 회원이 아니신가요? <a href="userJoinForm.do"> > 가입하기</a></p>
					<br> <br>
				</div>
			</form>
		</div> 
			</div>
		</div>
</section>
</body>

</html>