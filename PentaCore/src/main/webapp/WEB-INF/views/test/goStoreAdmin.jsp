<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.wrap {
		width: 70%;
		padding: 0 auto;
		display: inline-block;
		margin-bottom: 5%;
	}

	.box {
		margin: 0 auto;
		display: inline-block;
		padding-top: 1%;
	}
	
	.btn {
		float: left;
	}

	#btn {
		width: 250px;
		height: 170px;
		margin: 3%;
	}
	
	.boxall {
		width: 80%;
	
	}

</style>
</head>
<body>
	<div align="center">
	<div class="wrap">
		<div align="right">
			<form id="frm" name="frm" action="goStoreAdmin">
				<!-- <select id="store_code" name="store_code">
					<option>지점선택</option>
					<option value="ST001">중구점</option>
					<option value="ST002">청라언덕점</option>
					<option value="ST003">상인점</option>
					<option value="ST004">시지점</option>
					<option value="ST005">경산영대점</option>
				</select> &nbsp;
				<input type="submit" class="" value="확인"> -->
		</div> <br>
		<div class="boxall">
			<c:forEach var="list" items="${list}" varStatus="status">
				<div class="box">
					<div class="btn">
						<button type="button" onclick="location.href='goStoreAdmin?store_code=${list.store_code }'" id="btn" class="btn btn-primary btn-lg" ><h2>${list.store_name }</h2></button>
					</div>
				</div>
			</c:forEach>
			
			</form>
		</div>
		
	</div>
	</div>
</body>
</html>