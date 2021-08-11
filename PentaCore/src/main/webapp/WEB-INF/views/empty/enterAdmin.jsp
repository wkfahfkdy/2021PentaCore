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
		padding-top: 8%;
	}
	
	.btn {
		float: left;
	}

	#btn {
		width: 350px;
		height: 350px;
		margin: 3%;
	}

</style>
</head>
<body>
	<div class="wrap">
		<div class="box">
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='calendarTest'">
					<h2>지점예약 스케쥴관리</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='customer'">
					<h2>고객관리</h2></button>
			</div>
		</div>
	</div>
</body>
</html>