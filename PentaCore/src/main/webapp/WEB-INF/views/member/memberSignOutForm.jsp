<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<style>
	a {
		color: #478FEB;
	}
	
	.wrap{
		margin: auto;
		margin-top: 20px;
		margin-bottom: 50px;
		width: 70%;
		min-height: 100%;
	}
	
	
	.using-service{	/*이용 중인 서비스 div*/
		display: table;
		width: 100%;
		border-top: 1px lightgray solid;
		padding: 3em 2em;
	}
	
	.using-storage{
		display: table-cell;
		width: 70%;
	}
	
	.premium-service{
		display: table-cell;
		width: 30%;
		text-align: left;
		padding: 1em;
		border-left: 2px #E6E6E6 dotted;
	}
	
	.premium-title, .notice-title{
		padding: 0em 1em;
	}

	.premium-row, .go-notice {
		padding: 0em 2em;
	}
	
	.notice-btns{	/*공지사항 및 기능버튼들 전체 div*/
		display: table;
		padding: 3em 2em;
		width: 100%;
		border-top: 1px lightgray dashed;
	}
	
	.func-btns{
		display: table-cell;
		width: 70%;
		text-align: center;
		vertical-align: middle;
		align="center"
	}

	.notice{
		display: table-cell;
		text-align: left;
		border-left: 2px #E6E6E6 dotted;
		padding: 1em;
	}
	
	
	.btns-range-top, .btns-range-bottom{
		display: flex;
	}

	.review-btn{
		background-color: #478FEB;
		border-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		padding: 0.5em;
	}
	
	.btns {
		background-color: #478FEB;
		border-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 14pt;
		font-family: 'Nanum Gothic', sans-serif;
		font-weight: bold;
		padding: 0.5em;
		width: 200px;
		height: 55px;
		margin: 0em 0.4em;
	}
	
	th {
		text-align: center;
	}
	
	caption {
		color: black;
		font-size: 14pt;
		font-weight: bold;
		margin: 0em 0em 1em;
		padding: 0px 0px;
		margin: 0px 0px 0px;
	}
	
	img {
		width: 100%; height: auto;
	}
	
	.info-td {
		padding: 5px;
	}
	
	#pwdtext, #member_pwd {
		   	background-color: #fff;
		    border: solid 1px #999;
		    border-radius: 3px;
		   	padding: 18px 19px;
		    font-family: Montserrat;
		    font-size: 13px;
		    font-weight: 400;
		}
	
</style>

<!-- place holder 보여주는 input 창만 보여주고 input type=password 인 폼은 숨겨놓기  -->
<style type="text/css">
.passhidden { display: none; } //visibility: none은 공간을 차지하기 때문에 display를 사용
</style>

<!-- 플레이스홀더 폼 클릭하면 input type=password 인 폼 보여주기 -->
<script type="text/javascript">
$(document).ready(function() {
$("#pwdtext").on('focus', function() {
$(this).css('display', 'none');
$(this).next().css('display', 'inline-block');
});
});

</script>

<script>
function signOut() {
	
	var member_id = ${loginId};
	
	$.ajax({
		url : 'signOutVerifyCheck',
		data : {
			member_id : member_id
		},
		type : 'post',
		success : function(check) {
			if (check == 'pass') {
				frm.submit();
			} else {
				alert('이용중인 서비스가 있어 탈퇴가 불가합니다. 서비스 해지를 원하실 시 관리자에게 문의해주시기 바랍니다.');
			}
		},
		error : function(err) {
			alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
		}
	});
	
		
}

</script>

</head>
<body>
<form id="frm" action="memberSignOut" method="post">
	<div class="wrap">
		<div>
			<h1>회원탈퇴</h1>
		</div><br>
		<div class="using-service">
							<table>
								<tr>
								<td width="170px">
									<font style="color: black; font-weight: bold; font-size: 15pt;">비밀번호</font>
								</td>
								<td>
									<input class="pass" type="text" id="pwdtext" value="비밀번호 입력" onfocus="this.value=''" size= "50" />
									<input class="passhidden" type="password" id="member_pwd" name="member_pwd" value="" size= "50"/>	
								</td>
							</table>
						</div>
						<div class="notice-btns">
						<ul class="list-dot">
						
								<li>회원 탈퇴를 위해 비밀번호를 입력해주세요.</li>
						
								<li>마이스토리지 서비스를 이용 중인 고객님은 서비스 이용 종료 후에 탈퇴해주세요.</li>
									</ul>
						
						</div>
						
						
		<div class="using-service">
			
			<div class="func-btns">
			<div align="center" style="display: inline-block;">
				<div class="btns-range-top" >
					<button class="btns" onclick="location.href='signOut()'">탈퇴</button>
				</div>
				</div>
			</div>
		</div>
		</div>
		</form>
</body>
</html>