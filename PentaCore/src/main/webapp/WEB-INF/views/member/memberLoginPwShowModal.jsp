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
        
        #member_pwd, #member_pwd2, #member_pwd3 {
		   	background-color: #fff;
		    border: solid 1px #999;
		    border-radius: 3px;
		   	padding: 18px 19px;
		    font-family: Montserrat;
		    font-size: 13px;
		    font-weight: 400;
		}
		#member_id {
		   	background-color: #fff;
		    border: solid 1px #999;
		    border-radius: 3px;
		   	padding: 18px 19px;
		    font-family: Montserrat;
		    font-size: 13px;
		    font-weight: 400;
		}
		
		.btnLogin  {
			width: 400px;
			background: #478FEB; 
			color: white;
		    border-radius: 3px;
		   	padding: 18px 20px;
		}
		
		.form-control {
		   	background-color: #fff;
		    border: solid 1px #999;
		    border-radius: 3px;
		   	padding: 18px 19px;
		    font-family: Montserrat;
		    font-size: 13px;
		    font-weight: 400;
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
		
		/* $.ajax({
			url : 'memberLoginIdCheck1',
			data : {
				member_id : $('#member_id').val(),
				member_pwd : $('#member_pwd').val() },
			type : 'post',
			success : function(id) {
				console.log(id);
				if (id == 'invalid') {
					alert('이름과 패스워드를 다시 확인해주세요.');	
				} else {
					frmMember.submit();	
				}
			},
			error : function(err) {
				console.log(err);
			}
		});	 */
		frmMember.submit();	
		
	}
	

</script>


<!-- =================================== 아이디 찾기 모달 ======================================== -->

<script>
//이메일 인증코드 전송시 이메일 공백확인
$(function() {
	$('#member_email_input').click(function() {		
		
		//이름 공백확인
		if($('#member_name').val() == "") {
			alert('이름을 입력해주세요.');
			$('#member_name').focus();
		 	return false;
		}
	});
});

</script>
<script>
$(function() {
		$('#sendEmail').click(function() {
		
		//이메일 공백확인
		if($('#member_email').val() == "") {
			alert('이메일을 입력하세요.');
			$('#member_email').focus();
		 	return false;
		}
		
		//email 중복확인 ajax
		$.ajax({
			url : 'modalEmailCheck',
			data : {
				member_name : $('#member_name').val(),
				member_email : $('#member_email').val() },
			type : 'post',
			success : function(data) {
				if (data < 0) {
					alert('가입한 내역이 없습니다. 이름과 이메일을 확인해주세요.');	
					
				} else {
					
					alert('유효한 이메일입니다.');
					$('#member_email').focus();
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
									idModal.checkEmail.value = 'checked';
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
//아이디 찾기버튼 클릭 
$(function() {
	$('#findId').click(function() {
		if (idModal.member_name.value == "") {
			alert("이름을 입력하세요.");
			idModal.member_name.focus();
			return false;
		}
		if (idModal.member_email.value == "") {
			alert("이메일을 입력하세요.");
			return false;
		}
		/* 
		if (idModal.checkEmail.value == "unChecked") {
			alert("이메일을 인증 하세요");
			idModal.emailCode.focus();
			return false;
		}
		 */
		//새로운 모달 띄워서 아이디 보여주기
			        
		idModal.submit(); 
	 	
	});	
});
</script>



<script>
//id찾기 modal close
function closeModal() {
		document.getElementById('idShow').style.display='none';
	}
	
</script>	


<!-- =================================== 비밀번호 찾기 모달 ======================================== -->

<!-- 
<script>
//비밀번호 찾기 모달(이름입력 확인)
$(function() {
	$('#member_email_input2').click(function() {		
		
		//이름 공백확인
		if($('#member_name2').val() == "") {
			alert('이름을 입력해주세요.');
			$('#member_name2').focus();
		 	return false;
		}
	});
});
</script>
 -->
<!-- 
<script>
//비밀번호 찾기 모달(이메일 확인)
$(function() {
	$('#checkEmail2').click(function() {
		
		//이메일 공백확인
		if($('#member_email2').val() == "") {
			alert('이메일을 입력하세요.');
			$('#member_email2').focus();
		 	return false;
		}
		
		$.ajax ({
				url : 'modalEmailCheck',  
				data: {
					member_name : $('#member_name2').val(),
					member_email : $('#member_email2').val()
					},
				type: 'post',
				success: function(success) {
					/* session에 비밀번호 찾는 사용자의 이메일 변수로저장 (pwModalEmail)  */
					if(success > 0) {
					alert('유효한 이메일입니다.');
					$('#member_tel').focus();
					} else {
					alert('가입한 내역이 없습니다. 이름과 이메일을 확인해주세요.');				
					$('#member_name2').focus();
					}
				},
				error : function(err) {
					alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
				}
		});
	});
});


</script> -->

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
					if (data < 0) {
						alert('등록되지 않은 휴대폰번호입니다.');
						$('#member_tel').val('');
						$('#member_tel').focus();
					} else {
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
											pwModal.checkSMS.value = 'checked';
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
</script>


<script>
$(function() {
	$('#findPw').click(function() {
		if (pwModal.member_name2.value == "") {
			alert("이름을 입력하세요.");
			pwModal.member_name.focus();
			return false;
		}
		if (pwModal.member_id2.value == "") {
			alert("아이디를 입력하세요.");
			return false;
		}
		if (pwModal.member_tel.value == "") {
			alert("휴대폰번호를 입력하세요.");
			return false;
		}
		
		
		pwModal.submit(); 
		
	});
});
</script>

<script>
//id찾기 modal close
function pwCloseModal() {
		document.getElementById('pwShow').style.display='none';
	}
	
</script>	

<!-- =================================== 비밀번호 찾기 모달 END======================================== -->


<!-- =================================== 비밀번호 재설정창 보여주는 모달 자동실행 ======================================== -->
<script>
$( document ).ready(function() {
	// 팝업 호출
	document.getElementById('pwShow').style.display='block'
});
</script>

<script>
$(function() {
	$('#updateNewPw').click(function() {
		if (pwShowModal.member_pwd2.value == "") {
			alert("새로운 비밀번호를 입력하세요.");
			return false;
		}
		if (pwShowModal.member_pwd3.value == "") {
			alert("비밀번호를 확인하세요.");
			return false;
		}
		if (pwShowModal.member_pwd2.value != pwShowModal.member_pwd3.value) {
			alert("입력한 패스워드가 일치하지 않습니다.");
			pwShowModal.member_pwd2.focus();
			return false;
		}
		
		
		$.ajax({
			url : 'updateNewPwd',
			data : {
				member_pwd : $('#member_pwd2').val()
			},
			type : 'post',
			success : function(cnt) {
					consol.log(cnt);
					if (cnt > 0) { 
						alert('비밀번호가 성공적으로 재설정되었습니다.');
					} else {
						alert('입력값을 재확인해주시기 바랍니다.');
					}
			},
			error : function(err) {
				alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
			}
		});
		//pwShowModal.submit(); 
	});
});
</script>

<!-- =================================== 비밀번호 재설정창 보여주는 모달 END ======================================== -->

<script>
/* 보안위해 로그인 후 다시 로그인 화면으로 못돌아가게 하기  */
 window.history.forward();
 function noBack(){window.history.forward();}

</script>



</head>
<!--로그인 후 다시 로그인 화면으로 못돌아가게 하기 -->
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">




						<!-- =================================== 로그인 Form ======================================== -->
						<div align="center">
							<div>
							<div align="center" style="padding-top: 8%;">
								<img  style="width: 250px;" 
								src="${pageContext.request.contextPath }/resources/img/all_logo.png">
							</div>
							<br>
							</div>
							<div style="padding-top: 30px;">
							<form name="frmMember" id="frm" action="memberLoginIdCheck" method="post">
								<div>
								<input type="text" id="member_id" name="member_id"
									placeholder="ID" value="ID" onfocus="this.value=''" size= "50" > </div><br>
								<div>
								<input type="password" id="member_pwd" name="member_pwd" value="PASSWORD" onfocus="this.value=''"
								placeholder="PASSWORD" onkeyup=
									"if(window.event.keyCode==13) {loginCheck()}" 
									size= "50"></div>
								<c:if test="${errorMsg != null }">
									<p style="color:red">${errorMsg }</p>
								</c:if>
								<div>
									<br><br>
									<button class="btnLogin" type="button" onclick="loginCheck()">로그인</button>
								
							</form>
							</div> <br>
									<span onclick="document.getElementById('id01').style.display='block'" style="width:auto; cursor:pointer;">아이디 찾기 · </span> 
									<span onclick="document.getElementById('pw01').style.display='block'" style="width:auto; cursor:pointer;">비밀번호 찾기 </span> 
									<span>　　　　　　　　　　　　　　</span>
									<span onclick="location.href='memberJoinForm'" style="cursor:pointer;"> <b>회원가입</b> </span>
						</div>
						<div style="padding-bottom: 12%"></div>
						
						<!-- =================================== 아이디 찾기 모달 ======================================== -->
						<div id="id01" class="modal" align ="center">
				        <form id="idModal"  name="idModal" class="modal-content animate" action="memberLoginIdShowModal" method="post">
				            <div class="imgcontainer">
   								<div align="center" style="padding-top: 6%;">
									<img  style="width: 250px;" 
									src="${pageContext.request.contextPath }/resources/img/all_logo.png">
								</div>
				            
				                <span onclick="document.getElementById('id01').style.display='none'" class="close"
				                    title="Close Modal">&times;</span>
				                <h5>아이디 찾기 · 이메일 인증</h5>
				                
				            </div>
				            <br>
				
				            <div align="center">
				            <table style="border:1; border-collapse:collapse;">
				            
				            <tr>
							<td width="300" style=" height: 60px;">
							<input class="form-control" type="text" id="member_name" placeholder="이름" value="" onfocus="this.value=''" name="member_name"
									style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
							<td></td>
							</tr>
							
							<tr>
							<td id="member_email_input"  style="width: 100px; height: 60px;">
	 						<input class="form-control" type="text" placeholder="user@mystorage.com" id="member_email" name="member_email" 
	 								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">	
	 						</td>
	 						<td>
	 						<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="sendEmail" value="unChecked">인증코드 전송</button>
							</td>
	 						</tr>
	 						
	 						<tr>
	 						<td width="300" style="width: 100px; height: 60px;">
	 						<input class="form-control" type="text" placeholder="이메일 인증코드" id="emailCode" value=""
	 								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
	 						</td>
	 						<td>
	 						<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="checkEmail" value="unChecked">인증코드 확인</button>
							</td>
							</tr>
				            </table>
				            
				            <br><br>
				            
				            </div>
				            <div style = "margin-top :'20px';">
							<button class="btn btn-primary btn-lg" id="findId" >아이디 찾기</button> &nbsp;&nbsp;
				            <button class="btn btn-default btn-lg" type="button" onclick="document.getElementById('id01').style.display='none'"
				               class="cancelbtn">닫기</button>
							</div>
				
				            <br><br><br>
				            
				            
				        </form>
					</div>
				
				    
				   <!-- =================================== 패스워드 찾기 모달 ======================================== -->
				   
				    <div id="pw01" class="modal" align ="center">
				        <form id="pwModal" name="pwModal" class="modal-content animate" action="memberLoginPwShowModal" method="post">
				            <div class="imgcontainer">
   								<div align="center" style="padding-top: 3%;">
									<img  style="width: 250px;" 
									src="${pageContext.request.contextPath }/resources/img/all_logo.png">
								</div>
				            
				                <span onclick="document.getElementById('pw01').style.display='none'" class="close"
				                    title="Close Modal">&times;</span>   
				                <h5>비밀번호 찾기 · 휴대전화 인증</h5>
				            </div>
				            <br><br>
				
				            <div align="center">
				            <table style="border:1; border-collapse:collapse;">
				            
				            <tr>
							<td width="300" colspan="2" style="width: 100px; height: 60px;">
							<input class="form-control" type="text" id="member_name2"name="member_name2" placeholder ="이름" 
									style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
							</tr>
							<tr>
							<td width="300" colspan="2" style=" height: 60px;">
	 						<input class="form-control" type="text" id="member_id2" name="member_id2" placeholder ="ID" 
	 								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
	 						</td>
	 						</tr>
						
							<tr>
							<td width="350" colspan="2" style=" height: 60px;"><input class="form-control" type="text" id="member_tel"
								name="member_tel" placeholder ="휴대폰번호 '-'없이 숫자만 입력" 
								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
							</td>
							<td>
								<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="sendSMS" value="unChecked">인증번호 전송</button>
							</td>
							</tr>
							<tr>
							<td width="350" colspan="2" style="height: 60px;">
	 						<input class="form-control" type="text" placeholder="문자 인증번호" id="smsKey" value=""
	 								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
	 						</td>
	 						<td>
	 						<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="checkSMS" value="unChecked">인증번호 확인</button>
							</td>
							</tr>
							
				            </table>
				            
				            <br><br>
				            </div>
				            <div style = "margin-top :'20px';">
							<button class="btn btn-primary btn-lg" id="findPw">비밀번호 찾기</button>&nbsp;&nbsp;
							<button type="button" onclick="document.getElementById('pw01').style.display='none'"
				               class="btn btn-default btn-lg">닫기</button>
							</div>
				
				            <br><br>
				            
				            
				            
				        </form>
					</div>
					
					
					 <!-- =================================== 비밀번호 재설정 창 보여주기 ======================================== -->
					
					<div id="pwShow" class="modal" align ="center">
				        <form id="pwShowModal"  name="pwShowModal" class="modal-content animate" action="memberLoginForm" method="post">
				            <div class="imgcontainer">
				           		<div align="center" style="padding-top: 6%;">
								<img  style="width: 250px;" 
									src="${pageContext.request.contextPath }/resources/img/all_logo.png">
								</div>
				                <span id="closePwShow" onclick="pwCloseModal()" class="close"
				                    title="Close Modal">&times;</span>
				                <h5>비밀번호 재설정</h5>
				                <br><br>
				            </div>
				
				            <div align="center">
				            <table style="border:1; border-collapse:collapse;">
				            
				            <tr>
							<th style="width: 130px;">새 비밀번호</th>
							<td width="170">
							<input class="form-control" type="password" id="member_pwd2"
								name="member_pwd2"></td>
							</tr>
							
							<tr height="20">
							<td colspan="2">
							</td>
							</tr>
							
							<tr >
							<th style="width: 130px; ">새 비밀번호 확인</th>
							<td width="170">
							<input class="form-control" type="password" id="member_pwd3"
								name="member_pwd3"></td>
							</tr>
							
				            </table>
				
				            <br><br><br>
				            </div>
				            <div style = "margin-top :'20px';">
							<button class="btn btn-primary btn-lg" style="width:150px" id="updateNewPw">확인</button>
							</div>
				
				            <br><br>
				          	
				            </form>
				            </div>
		    </body>
<script>
/* 모달창 띄우기 */
        var modal = document.getElementById('id01');
        var modal2 = document.getElementById('pw01');
        // 모달창 화면 밖 클릭시 모달창 닫기
        
        /* //모달창 밖의 화면 클릭시 모달화면이 닫히는 코드. *사용자가 실수로 창을 끄기 쉬워 막아놓음.
        window.onclick = function (event) {
            console.log(event.target);
           
             if (event.target == modal || event.target == modal2) {
                modal.style.display = "none";
                 modal2.style.display = "none"; 
            }
        }*/
</script>


</html>



