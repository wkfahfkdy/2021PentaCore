<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberLoginForm.jsp</title>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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

<style>
/* Center the image and position the close button */
 		#modal-input {
           
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            color: -internal-light-dark(black, white);
            background-color: -internal-light-dark(rgb(255, 255, 255), rgb(59, 59, 59));
        }
        
        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
            position: relative;
        }

        .btn-confirm {
            display: block;
		    background: #5b87da;
		    width: 30%;
		    padding: 15px 10px;
		    text-align: center;
		    color: #fff !important;
		    font-size: 18px;
		    border-radius: 100px;
		    cursor: pointer;
        }

        .container {
            padding: 16px;
        }

        span.psw {
            float: right;
            padding-top: 16px;
        }

        /* The Modal (background) */
        .modal {
            display: none;
            /* Hidden by default */
            position: fixed;
            /* Stay in place */
            z-index: 1;
            /* Sit on top */
            left: 0;
            top: 0;
            width: 100%;
            /* Full width */
            height: 100%;
            /* Full height */
            overflow: auto;
            /* Enable scroll if needed */
            background-color: rgb(0, 0, 0);
            /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4);
            /* Black w/ opacity */
            padding-top: 60px;
        }

        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto 15% auto;
            /* 5% from the top, 15% from the bottom and centered */
            border: 1px solid #888;
            width: 50%;
            /* Could be more or less, depending on screen size */
        }

        /* The Close Button (x) */
        .close {
            position: absolute;
            right: 25px;
            top: 0;
            color: #000;
            font-size: 35px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: red;
            cursor: pointer;
        }

        /* Add Zoom Animation */
        .animate {
            -webkit-animation: animatezoom 0.6s;
            animation: animatezoom 0.6s
        }

        @-webkit-keyframes animatezoom {
            from {
                -webkit-transform: scale(0)
            }

            to {
                -webkit-transform: scale(1)
            }
        }

        @keyframes animatezoom {
            from {
                transform: scale(0)
            }

            to {
                transform: scale(1)
            }
        }

        /* Change styles for span and cancel button on extra small screens */
        @media screen and (max-width: 300px) {
            span.psw {
                display: block;
                float: none;
            }

            .cancelbtn {
                width: 100%;
            }
        }
</style>




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
		
		frmMember.submit();
	}
	

</script>
<script>

//비밀번호 찾기 모달(이름입력 확인)
$(function() {
	$('#member_email2').click.(function() {
		
		//이름 공백확인
		if($('#member_name2').val() == "") {
			alert('이름을 입력해주세요.');
			$('#member_name2').focus();
		 	return false;
		}
	}


//비밀번호 찾기 모달(이메일 확인)
$(function() {
	$('#checkEmail').click.(function() {
		
		//이메일 공백확인
		if($('#member_email2').val() == "") {
			alert('이메일을 입력하세요.');
			$('#member_email2').focus();
		 	return false;
		}
		
		$.ajax {(
				url : 'pwModalEmailCheck',  
				data: {
					member_name : $('#member_name2').val(),
					member_email : $('#member_email2').val()
					},
				type: 'post',
				success: function(success) {
					alert('유효한 이메일입니다.');
				},
				error : function(err) {
					alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
				}
		)};
	});
});


</script>

<script>
	//휴대폰 번호입력 ajax
	$(function() {
		$('#sendSMS').click(function() { // 클릭하면 인증 번호 보내기
			var tel = $('#user_Phone').val(); // 인증번호를 보낼 사용자가 입력한 tel

			if (tel == "") {
				alert('휴대폰번호를 입력하세요.');
				$('#user_Phone').focus();
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
					if (data < 0) {
						alert('등록된 휴대폰번호가 존재하지 않습니다.');
						$('#user_Phone').val('');
						$('#user_Phone').focus();
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



<script>
/* 보안위해 로그인 후 다시 로그인 화면으로 못돌아가게 하기  */
 window.history.forward();
 function noBack(){window.history.forward();}
</script>



</head>
<!--로그인 후 다시 로그인 화면으로 못돌아가게 하기 -->
<body onload="noBack();" onpageshow="if(event.persisted) noBack();"
	onunload="">



						<!--로그인 화면-->
						<div align="center">
							<div>
								<h2>
									<b>로그인</b>
								</h2>
								<br>
							</div>
							<form name="frmMember" id="frm" action="memberLoginIdCheck" method="post">
								<input type="text" id="member_id" name="member_id"
									placeholder="ID" value=""> 
								<input type="password" id="member_pwd" name="member_pwd" 
								placeholder="PASSWORD" onkeyup="if(window.event.keyCode==13)
								{loginCheck()}" value="">
								<div>
									<br>
									<button class="btn btn-light" type="button"
										onclick="loginCheck()"
										style="width: 370px; background: #89ba10; color: white;">로그인</button>
									<!-- <button class="btn btn-light" type="button"
										onclick="location.href='memberJoinForm'"
										style="width: 185px; background: #89ba10; color: white;">회원가입</button> -->
									<br> <br>
									<br> <br>
								</div>
							</form>
									<span onclick="document.getElementById('id01').style.display='block'" style="width:auto;">아이디 찾기 | </span> 
									<span onclick="document.getElementById('pw01').style.display='block'">비밀번호 찾기 | </span> 
									<span onclick="location.href=''">회원가입 </span>
									<br> <br>
									<br> <br>
						</div>
						
						
						
						<!--  
						<div id="id01" class="modal">

				        <form class="modal-content animate" action="/action_page.php" method="post">
				            <div class="imgcontainer">
				                <span onclick="document.getElementById('id01').style.display='none'" class="close"
				                    title="Close Modal">&times;</span>
				                <>
				            </div>
				
				            <div class="container">
				                <label for="uname"><b>Email</b></label>
				                <input type="text" placeholder="Enter Username" name="uname" required>
				
				                <label for="psw"><b>Password</b></label>
				                <input type="password" placeholder="Enter Password" name="psw" required>
				
				                <button type="submit">Login</button>
				                <label>
				                    <input type="checkbox" checked="checked" name="remember"> Remember me
				                </label>
				            </div>
				
				            <div class="container" style="background-color:#f1f1f1">
				                <button type="button" onclick="document.getElementById('id01').style.display='none'"
				                    class="cancelbtn">Cancel</button>
				                <span class="psw">Forgot <a href="#">password?</a></span>
				            </div>
				        </form>
				    </div>
				    -->
				    
				    <div id="pw01" class="modal">
						<div align="center">
				        <form id="pwModal" class="modal-content animate" action="/action_page.php" method="post">
				            <div class="imgcontainer">
				                <span onclick="document.getElementById('pw01').style.display='none'" class="close"
				                    title="Close Modal">&times;</span>
				                <h3>비밀번호 찾기</h3>
				                <h5>회원정보에 등록한 휴대전화로 인증</h5>
				            </div>
				            <br><br>
				
				            <div align="center">
				            <table style="border:1; border-collapse:collapse;">
				            
				            <tr>
							<th width="100">이름</th>
							<td width="300" colspan="2">
							<input class="form-control" type="text" id="member_name2"
								name="member_name2"></td>
							</tr>
							<tr>
							<th width="100">이메일</th>
							<td width="350" colspan="2">
	 						<input class="form-control" type="text" id="member_email2" name="member_email2" value="">
	 						</td>
	 						<td>
	 						<button class="btn btn-light" 
	 						type="button" value="unChecked" onclick="" id="checkEmail" name="checkEmail">이메일 확인</button>
							</td>
	 						</tr>
	 						
						
							<tr>
							<th width="100">휴대폰 번호</th>
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
							
				            </table>
				            
				            <br><br>
				            </div>
				            <div style = "margin-top :'20px';">
							<button class="btn-confirm">비밀번호 찾기</a></button>
							</div>
				
				            <br><br>
				            
				            <button type="button" onclick="document.getElementById('pw01').style.display='none'"
				               class="cancelbtn">Cancel</button>
				            
				        </form>
				    </div>
</div>
				    
<script>
/* 모달창 띄우기 */
        var modal = document.getElementById('id01');
        var modal2 = document.getElementById('pw01');
        // 모달창 화면 밖 클릭시 모달창 닫기
        window.onclick = function (event) {
            console.log(event.target);
            if (event.target == modal || event.target == modal2) {
                modal.style.display = "none";
                modal2.style.display = "none";
            }
        }
</script>

</body>
</html>



