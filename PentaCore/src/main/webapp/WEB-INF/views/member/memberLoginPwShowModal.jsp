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
	//????????? function ????????? ??????
	function loginCheck() {
		
		if (frm.member_id.value == "") {
			alert("???????????? ???????????????.");
			frm.member_id.focus();
			return false;
		}
		if (frm.member_pwd.value == "") {
			alert("??????????????? ???????????????.");
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
					alert('????????? ??????????????? ?????? ??????????????????.');	
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


<!-- =================================== ????????? ?????? ?????? ======================================== -->

<script>
//????????? ???????????? ????????? ????????? ????????????
$(function() {
	$('#member_email_input').click(function() {		
		
		//?????? ????????????
		if($('#member_name').val() == "") {
			alert('????????? ??????????????????.');
			$('#member_name').focus();
		 	return false;
		}
	});
});

</script>
<script>
$(function() {
		$('#sendEmail').click(function() {
		
		//????????? ????????????
		if($('#member_email').val() == "") {
			alert('???????????? ???????????????.');
			$('#member_email').focus();
		 	return false;
		}
		
		//email ???????????? ajax
		$.ajax({
			url : 'modalEmailCheck',
			data : {
				member_name : $('#member_name').val(),
				member_email : $('#member_email').val() },
			type : 'post',
			success : function(data) {
				if (data < 0) {
					alert('????????? ????????? ????????????. ????????? ???????????? ??????????????????.');	
					
				} else {
					
					alert('????????? ??????????????????.');
					$('#member_email').focus();
					$('#sendEmail').val('checked');
					$('#emailCode').focus();
					
					//????????? ???????????? ????????? ???????????? ??????????????? ajax
					$.ajax({
						url : 'sendEmail.do',
						data : {
							email : $('#member_email').val()
						},
						type : 'post',
						success : function(code) {
							alert('????????? ?????????????????????.');
							$('#checkEmail').click(function() { // ???????????? ??????????????? ?????? ???????????? ?????????, ???????????? ????????? ?????? ??? ?????? ??????
								if ($('#emailCode').val() == code) { // ???????????? ???????????? sendSMS?????? ?????? ?????? ???????????? ??????
									alert('?????????????????????');
									idModal.checkEmail.value = 'checked';
								} else {
									alert('??????????????? ????????????');
								}
							})
							
						},
						error : function(err) {
							alert('????????? ??????????????????. ??????????????? ??????????????????.');
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
//????????? ???????????? ?????? 
$(function() {
	$('#findId').click(function() {
		if (idModal.member_name.value == "") {
			alert("????????? ???????????????.");
			idModal.member_name.focus();
			return false;
		}
		if (idModal.member_email.value == "") {
			alert("???????????? ???????????????.");
			return false;
		}
		/* 
		if (idModal.checkEmail.value == "unChecked") {
			alert("???????????? ?????? ?????????");
			idModal.emailCode.focus();
			return false;
		}
		 */
		//????????? ?????? ????????? ????????? ????????????
			        
		idModal.submit(); 
	 	
	});	
});
</script>



<script>
//id?????? modal close
function closeModal() {
		document.getElementById('idShow').style.display='none';
	}
	
</script>	


<!-- =================================== ???????????? ?????? ?????? ======================================== -->

<!-- 
<script>
//???????????? ?????? ??????(???????????? ??????)
$(function() {
	$('#member_email_input2').click(function() {		
		
		//?????? ????????????
		if($('#member_name2').val() == "") {
			alert('????????? ??????????????????.');
			$('#member_name2').focus();
		 	return false;
		}
	});
});
</script>
 -->
<!-- 
<script>
//???????????? ?????? ??????(????????? ??????)
$(function() {
	$('#checkEmail2').click(function() {
		
		//????????? ????????????
		if($('#member_email2').val() == "") {
			alert('???????????? ???????????????.');
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
					/* session??? ???????????? ?????? ???????????? ????????? ??????????????? (pwModalEmail)  */
					if(success > 0) {
					alert('????????? ??????????????????.');
					$('#member_tel').focus();
					} else {
					alert('????????? ????????? ????????????. ????????? ???????????? ??????????????????.');				
					$('#member_name2').focus();
					}
				},
				error : function(err) {
					alert('????????? ??????????????????. ??????????????? ??????????????????.');
				}
		});
	});
});


</script> -->

<script>
	//????????? ???????????? ajax
	$(function() {
		$('#sendSMS').click(function() { // ???????????? ?????? ?????? ?????????
			var tel = $('#member_tel').val(); // ??????????????? ?????? ???????????? ????????? tel

			if (tel == "") {
				alert('?????????????????? ???????????????.');
				$('#member_tel').focus();
				return false;
			}

			//??????????????? ???????????? ajax
			$.ajax({
				url : 'samePhoneCheck',
				data : {
					tel : tel
				},
				type : 'post',
				success : function(data) {
					if (data < 0) {
						alert('???????????? ?????? ????????????????????????.');
						$('#member_tel').val('');
						$('#member_tel').focus();
					} else {
						$('#sendSMS').val('checked');
						$('#smsKey').focus();

						//??????????????? ??????????????? ???????????? ?????? ajax
						if (tel != "") {
							$.ajax({
								url : 'sendSMS',
								data : {
									tel : tel
								},
								type : 'post',
								success : function(code) {
									alert('??????????????? ?????????????????????');
									$('#checkSMS').click(function() { // ???????????? sendSMS?????? ?????? ???????????? ?????????, ???????????? ????????? ?????? ??? ?????? ??????
										if ($('#smsKey').val() == code) { // ???????????? ???????????? sendSMS?????? ?????? ?????? ???????????? ??????
											alert('?????????????????????');
											pwModal.checkSMS.value = 'checked';
										} else {
											alert('??????????????? ????????????');
										}
									});
								}
							});
						}
					}
				},
				error : function(err) {
					alert('????????? ??????????????????. ??????????????? ??????????????????.');
				}
			});
		});
	});
</script>


<script>
$(function() {
	$('#findPw').click(function() {
		if (pwModal.member_name2.value == "") {
			alert("????????? ???????????????.");
			pwModal.member_name.focus();
			return false;
		}
		if (pwModal.member_id2.value == "") {
			alert("???????????? ???????????????.");
			return false;
		}
		if (pwModal.member_tel.value == "") {
			alert("?????????????????? ???????????????.");
			return false;
		}
		
		
		pwModal.submit(); 
		
	});
});
</script>

<script>
//id?????? modal close
function pwCloseModal() {
		document.getElementById('pwShow').style.display='none';
	}
	
</script>	

<!-- =================================== ???????????? ?????? ?????? END======================================== -->


<!-- =================================== ???????????? ???????????? ???????????? ?????? ???????????? ======================================== -->
<script>
$( document ).ready(function() {
	// ?????? ??????
	document.getElementById('pwShow').style.display='block'
});
</script>

<script>
$(function() {
	$('#updateNewPw').click(function() {
		if (pwShowModal.member_pwd2.value == "") {
			alert("????????? ??????????????? ???????????????.");
			return false;
		}
		if (pwShowModal.member_pwd3.value == "") {
			alert("??????????????? ???????????????.");
			return false;
		}
		if (pwShowModal.member_pwd2.value != pwShowModal.member_pwd3.value) {
			alert("????????? ??????????????? ???????????? ????????????.");
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
						alert('??????????????? ??????????????? ????????????????????????.');
					} else {
						alert('???????????? ????????????????????? ????????????.');
					}
			},
			error : function(err) {
				alert('????????? ??????????????????. ??????????????? ??????????????????.');
			}
		});
		//pwShowModal.submit(); 
	});
});
</script>

<!-- =================================== ???????????? ???????????? ???????????? ?????? END ======================================== -->

<script>
/* ???????????? ????????? ??? ?????? ????????? ???????????? ??????????????? ??????  */
 window.history.forward();
 function noBack(){window.history.forward();}

</script>



</head>
<!--????????? ??? ?????? ????????? ???????????? ??????????????? ?????? -->
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">




						<!-- =================================== ????????? Form ======================================== -->
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
									<button class="btnLogin" type="button" onclick="loginCheck()">?????????</button>
								
							</form>
							</div> <br>
									<span onclick="document.getElementById('id01').style.display='block'" style="width:auto; cursor:pointer;">????????? ?????? ?? </span> 
									<span onclick="document.getElementById('pw01').style.display='block'" style="width:auto; cursor:pointer;">???????????? ?????? </span> 
									<span>??????????????????????????????????????????</span>
									<span onclick="location.href='memberJoinForm'" style="cursor:pointer;"> <b>????????????</b> </span>
						</div>
						<div style="padding-bottom: 12%"></div>
						
						<!-- =================================== ????????? ?????? ?????? ======================================== -->
						<div id="id01" class="modal" align ="center">
				        <form id="idModal"  name="idModal" class="modal-content animate" action="memberLoginIdShowModal" method="post">
				            <div class="imgcontainer">
   								<div align="center" style="padding-top: 6%;">
									<img  style="width: 250px;" 
									src="${pageContext.request.contextPath }/resources/img/all_logo.png">
								</div>
				            
				                <span onclick="document.getElementById('id01').style.display='none'" class="close"
				                    title="Close Modal">&times;</span>
				                <h5>????????? ?????? ?? ????????? ??????</h5>
				                
				            </div>
				            <br>
				
				            <div align="center">
				            <table style="border:1; border-collapse:collapse;">
				            
				            <tr>
							<td width="300" style=" height: 60px;">
							<input class="form-control" type="text" id="member_name" placeholder="??????" value="" onfocus="this.value=''" name="member_name"
									style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;"></td>
							<td></td>
							</tr>
							
							<tr>
							<td id="member_email_input"  style="width: 100px; height: 60px;">
	 						<input class="form-control" type="text" placeholder="user@mystorage.com" id="member_email" name="member_email" 
	 								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">	
	 						</td>
	 						<td>
	 						<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="sendEmail" value="unChecked">???????????? ??????</button>
							</td>
	 						</tr>
	 						
	 						<tr>
	 						<td width="300" style="width: 100px; height: 60px;">
	 						<input class="form-control" type="text" placeholder="????????? ????????????" id="emailCode" value=""
	 								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
	 						</td>
	 						<td>
	 						<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="checkEmail" value="unChecked">???????????? ??????</button>
							</td>
							</tr>
				            </table>
				            
				            <br><br>
				            
				            </div>
				            <div style = "margin-top :'20px';">
							<button class="btn btn-primary btn-lg" id="findId" >????????? ??????</button> &nbsp;&nbsp;
				            <button class="btn btn-default btn-lg" type="button" onclick="document.getElementById('id01').style.display='none'"
				               class="cancelbtn">??????</button>
							</div>
				
				            <br><br><br>
				            
				            
				        </form>
					</div>
				
				    
				   <!-- =================================== ???????????? ?????? ?????? ======================================== -->
				   
				    <div id="pw01" class="modal" align ="center">
				        <form id="pwModal" name="pwModal" class="modal-content animate" action="memberLoginPwShowModal" method="post">
				            <div class="imgcontainer">
   								<div align="center" style="padding-top: 3%;">
									<img  style="width: 250px;" 
									src="${pageContext.request.contextPath }/resources/img/all_logo.png">
								</div>
				            
				                <span onclick="document.getElementById('pw01').style.display='none'" class="close"
				                    title="Close Modal">&times;</span>   
				                <h5>???????????? ?????? ?? ???????????? ??????</h5>
				            </div>
				            <br><br>
				
				            <div align="center">
				            <table style="border:1; border-collapse:collapse;">
				            
				            <tr>
							<td width="300" colspan="2" style="width: 100px; height: 60px;">
							<input class="form-control" type="text" id="member_name2"name="member_name2" placeholder ="??????" 
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
								name="member_tel" placeholder ="??????????????? '-'?????? ????????? ??????" 
								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
							</td>
							<td>
								<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="sendSMS" value="unChecked">???????????? ??????</button>
							</td>
							</tr>
							<tr>
							<td width="350" colspan="2" style="height: 60px;">
	 						<input class="form-control" type="text" placeholder="?????? ????????????" id="smsKey" value=""
	 								style="background-color: #fff; border: solid 1px #999; border-radius: 3px; padding: 18px 19px; font-family: Montserrat; font-size: 13px; font-weight: 400;">
	 						</td>
	 						<td>
	 						<button class="btn btn-default" style="margin-left: 10%; height: 60%;"  type="button" id="checkSMS" value="unChecked">???????????? ??????</button>
							</td>
							</tr>
							
				            </table>
				            
				            <br><br>
				            </div>
				            <div style = "margin-top :'20px';">
							<button class="btn btn-primary btn-lg" id="findPw">???????????? ??????</button>&nbsp;&nbsp;
							<button type="button" onclick="document.getElementById('pw01').style.display='none'"
				               class="btn btn-default btn-lg">??????</button>
							</div>
				
				            <br><br>
				            
				            
				            
				        </form>
					</div>
					
					
					 <!-- =================================== ???????????? ????????? ??? ???????????? ======================================== -->
					
					<div id="pwShow" class="modal" align ="center">
				        <form id="pwShowModal"  name="pwShowModal" class="modal-content animate" action="memberLoginForm" method="post">
				            <div class="imgcontainer">
				           		<div align="center" style="padding-top: 6%;">
								<img  style="width: 250px;" 
									src="${pageContext.request.contextPath }/resources/img/all_logo.png">
								</div>
				                <span id="closePwShow" onclick="pwCloseModal()" class="close"
				                    title="Close Modal">&times;</span>
				                <h5>???????????? ?????????</h5>
				                <br><br>
				            </div>
				
				            <div align="center">
				            <table style="border:1; border-collapse:collapse;">
				            
				            <tr>
							<th style="width: 130px;">??? ????????????</th>
							<td width="170">
							<input class="form-control" type="password" id="member_pwd2"
								name="member_pwd2"></td>
							</tr>
							
							<tr height="20">
							<td colspan="2">
							</td>
							</tr>
							
							<tr >
							<th style="width: 130px; ">??? ???????????? ??????</th>
							<td width="170">
							<input class="form-control" type="password" id="member_pwd3"
								name="member_pwd3"></td>
							</tr>
							
				            </table>
				
				            <br><br><br>
				            </div>
				            <div style = "margin-top :'20px';">
							<button class="btn btn-primary btn-lg" style="width:150px" id="updateNewPw">??????</button>
							</div>
				
				            <br><br>
				          	
				            </form>
				            </div>
		    </body>
<script>
/* ????????? ????????? */
        var modal = document.getElementById('id01');
        var modal2 = document.getElementById('pw01');
        // ????????? ?????? ??? ????????? ????????? ??????
        
        /* //????????? ?????? ?????? ????????? ??????????????? ????????? ??????. *???????????? ????????? ?????? ?????? ?????? ????????????.
        window.onclick = function (event) {
            console.log(event.target);
           
             if (event.target == modal || event.target == modal2) {
                modal.style.display = "none";
                 modal2.style.display = "none"; 
            }
        }*/
</script>


</html>



