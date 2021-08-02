
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	//비밀번호 실시간체크
	$(function() {
		var password = $('input[type=password]');
		var chkNotice = $('#chkNotice');
		var pswd = $('#pw');
		var pswd2 = $('#pw2');

		password.keyup(function() {
			if (pswd2.val() == "") {
				chkNotice.html('');
			} else {
				if (pswd2.val() != pswd.val()) {
					chkNotice.html('비밀번호 일치하지 않음<br><br>').attr('color',
							'#f82a2aa3');
					$('#passwordCheck').val('unChecked');
				} else {
					chkNotice.html('비밀번호 일치함<br><br>').attr('color',
							'#199894b3');
					$('#passwordCheck').val('Checked');
				}
			}
		});
	});
	function checkId() {
		$.ajax({
			url : 'userIdCheck.do',
			data : {
				id : $('#id').val(),
			},
			type : 'post',
			success : function(data) {
				console.log(data);
				if (data == 1) {
					$('#chkNotice2').html('이미 가입중이거나, 회원 탈퇴한 회원입니다.').attr('color',
					'#f82a2aa3');
					$('#idCheck').val('unChecked');
				} else {
					$('#chkNotice2').html('사용가능한 아이디 입니다.').attr('color',
					'#f82a2aa3');
					$('#idCheck').val('Checked');
				}
			},
			error : function(err) {
				console.log(err);
				console.log("중복검사 에러");
			}
		})
	};
	function formCheck() {
		if (frm.id.value == "") {
			alert("아이디를 입력하세요.");
			frm.id.focus();
			return false;
		}
		if (frm.pw.value == "") {
			alert("비밀번호를 입력하세요.");
			frm.pw.focus();
			return false;
		}
		if (frm.pw2.value == "") {
			alert("비밀번호를 재입력하세요.");
			frm.pw2.focus();
			return false;
		}
		if (frm.name.value == "") {
			alert("이름를 입력하세요.");
			frm.name.focus();
			return false;
		}
		if(frm.hp.value =="") {
			alert("핸드폰 번호를 입력해주세요.");
			frm.hp.focus();
			return false;
		}
		if(frm.gender.value=="") {
			alert("성별 확인 해주세요.");
			frm.gender.focus();
		}
		if (frm.idCheck.value == 'unChecked') {
			alert("탈퇴한 아이디이거나, 이미 사용중인 아이디입니다.");
			frm.id.val("");
			frm.id.focus();
			return false;
		}

		if (frm.passwordCheck.value == 'unChecked') {
			alert("비밀번호를 다시 한번 똑같이 입력해주세요.");
			frm.pw2.focus();
			return false;
		}
		frm.submit();
	}
			
	
	
</script>
<div class="container margin-bottom-100px">
	<!--======= log_in_page =======-->
	<div id="log-in"
		class="site-form log-in-form box-shadow border-radius-10">

		<div class="form-output">

			<form id="frm" action="memberInsert.do" method="post">
				<div class="form-group label-floating">
					<label class="control-label">이름</label> <input class="form-control"
						placeholder="이름을 입력해주세요." type="text" name="name" id="name">
				</div>
				<div class="form-group label-floating">
					<label class="control-label">ID</label> <input class="form-control" oninput = "checkId()"
						placeholder="사용 하실 아이디를 입력해주세요." type="text" name="id" id="id">
						<input type="hidden" id="idCheck" name="idCheck" value="unChecked">
						
				</div>
				<div style="text-align: left">
					<font id="chkNotice2" size="2"></font>
				</div>
				<div class="form-group label-floating">
					<label class="control-label">Password</label> <input
						class="form-control" placeholder="비밀번호 입력" type="password" id="pw"
						name="pw">
				</div>
				<div class="form-group label-floating">
					<label class="control-label">Password Check</label> <input
						class="form-control" placeholder="비밀번호 확인" type="password"
						id="pw2" name="pw2">
						<input type="hidden" id="passwordCheck" name="passwordCheck" value="unChecked">
				</div>
				<div style="text-align: left">
					<font id="chkNotice" size="2"></font>
				</div>
				<div class="form-group label-floating">
					<label class="control-label">생년월일</label> <input
						class="form-control" placeholder="우측 달력을 눌러주세요" type="date"
						id="birth" name="birth" max="9999-12-31">
				</div>

				<div class="form-group label-floating is-select">
					<label class="control-label">성별</label> <select
						class="selectpicker form-control" id="gender" name="gender">
						<option value="MALE">Male</option>
						<option value="FEMALE">Female</option>
					</select>
				</div>
				<div class="form-group label-floating">
					<label class="control-label">핸드폰 번호</label> <input
						class="form-control" placeholder="핸드폰번호입력" type="text" name="hp"
						id="hp">
				</div>
				<div class="remember">
					<div class="checkbox">
						<label> <input name="optionsCheckboxes" type="checkbox">
							I accept the <a href="#">Terms and Conditions</a> of the website
						</label>
					</div>
				</div>

				<button type="button" onclick="formCheck()" class="btn btn-md btn-primary full-width">가입하기</button>>

				<div class="or"></div>

				<a href="#" class="btn btn-md bg-facebook full-width btn-icon-left"><i
					class="fab fa-facebook margin-right-8px" aria-hidden="true"></i>
					Login with Facebook</a> <a href="#"
					class="btn btn-md bg-twitter full-width btn-icon-left"><i
					class="fab fa-twitter margin-right-8px" aria-hidden="true"></i>
					Login with Twitter</a>


				<p>
					you have an account? <a href="page-login.html"> Sing in !</a>
				</p>
			</form>

		</div>
	</div>
</div>
<!--======= // log_in_page =======-->