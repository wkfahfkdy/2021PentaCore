<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8">
<style type="text/css">

	.wrap {
		width: 100%;
		text-align: center;
	}
	
	.box {
		margin: 0 auto;
		display: inline-block;
		padding-top: 2%;
	}
	
	.btn {
		float: left;
	}

	#btn {
		width: 250px;
		height: 170px;
		margin: 3%;
	}
	
	.box2 {
		margin: 0 auto;
		display: inline-block;
		padding-top: 1%;
	}
	#btn2 {
		width: 825px;
		height: 50px;
		margin: 1%;
	}
	
	.btn-group-lg>.btn, .btn-lg {
    font-size: 12px;
    padding: 7px 16px;
}

</style>
</head>
<body>
	<div class="wrap">
		<div class="box">
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='storageInfo?store_code=${employeeVO.store_code}'"><h2>스토리지 현황</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='store/customerManage2'">
					<h2>고객관리</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href=''">
					<h2>투어관리</h2></button>
			</div>
		</div>
		<div></div>
		<div class="box">
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='storeNotice'">
					<h2>공지사항</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href=''">
					<h2>1:1 문의</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href=''">
					<h2>물품운송</h2></button>
			</div>
		</div>
		<div></div>
		<div class="box2">
			<div class="btn">
				<button type="button" id="btn2" class="btn btn-primary btn-lg" onclick="location.href=''">
					<h4>쿠폰등록</h4></button>
			</div>
		</div>
	</div>
</body>
</html>