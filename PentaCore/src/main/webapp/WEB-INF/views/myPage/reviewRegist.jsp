<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.wrap {
			margin: auto;
			text-align: center;
			padding: 50px 10px;
			width: 90%;
		}
		
	input[type="text"] {
		background: white;
		border: 1px solid #5fd3e8;
		border-radius: 0.3em;
		width: 80%;
		height: 2.5em;
		padding: 5px;
		margin: 2em 0em;
	}
	
	.back-btn {
    	background-color: #006DFC;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
    
    .apply-btn {
    	background-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    } 
</style>
<!-- 게시판 오픈소스 : ckEditor4 -->
<script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
<script>
	$(function() {
		CKEDITOR.replace('content', {
			filebrowserUploadUrl:'${pageContext.request.contextPath }/fileUpload/reviewRegist',
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			height: '600px',
			width: '80%'
		});
	})
	
	function formCheck() {
		if (frm.title.value == "") {
			alert("제목을 입력하세요.");
			frm.title.focus();
			return false;	// submit을 하지 않도록
		}
		frm.submit();
	}
</script>
</head>
<body>
<div class="wrap">
	<div>
		<h3><font style="color: #00c0e2;">${loginName }</font>님의 <font style="color: #00c0e2;">${useStore.store_name }</font> 이용 리뷰 페이지</h3>
	</div>
	<form id="frm" action="" method="POST" enctype="multipart/form-data">
		<div>
			<input type="text" name="review_title"/>
			<input type="hidden" name="store_code" value="${loginStore }" />
		</div>
		<div align="center">
			<textarea id="content" name="content"></textarea>
		</div>
		<div style="margin: 1em 0em;">
			<button class="apply-btn" type="button" onclick="formCheck()">등록</button>&nbsp;&nbsp;
			<button class="back-btn" type="button" onclick="history.back();">돌아가기</button>
		</div>
	</form>
</div>
</body>
</html>