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
		font-size: 12pt;
		font-family: 'Nanum Gothic', sans-serif;
		font-weight: bold;
		padding: 0.5em;
		width: 120px;
		height: 75px;
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
	
	#pwd {
		   	background-color: #fff;
		    border: solid 1px #999;
		    border-radius: 3px;
		   	padding: 18px 19px;
		    font-family: Montserrat;
		    font-size: 13px;
		    font-weight: 400;
		}
	
</style>
</head>
<body>
	<div class="wrap">
		<div>
			<h1>회원탈퇴</h1>
		</div><br>
		<div class="using-service">
							<table>
								<tr>
								<td>
									<font style="color: black; font-weight: bold; font-size: 11pt;">비밀번호</font>
								</td>
								<td>
									 <input type="text" id="member_id" name="member_id"
										placeholder="ID" value="ID" onfocus="this.value=''" size= "50" >
								</td>
								</tr>
								<tr>
									
								</tr>
							</table>
						</div>
		</div>
		<div class="notice-btns">
			<div class="func-btns">
				<div class="btns-range-top" align="center">
					<button class="btns" onclick="location.href='offerList'">회원탈퇴</button>
				</div>
			</div>
		</div>
</body>
</html>