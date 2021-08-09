<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
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
		width: 75%;
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
		CKEDITOR.replace('notice_content', {
			filebrowserUploadUrl:'${pageContext.request.contextPath }/fileUpload/imageUpload',
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			height: '600px',
			width: '80%'
		});
	})
	
	function formCheck() {
		if (frm.notice_title.value == "") {
			alert("제목을 입력하세요.");
			frm.notice_title.focus();
			return false;	// submit을 하지 않도록
		}
		if (frm.notice_content.text == "") {
			alert("내용을 입력하세요.");
			frm.notice_content.focus();
			return false;
		}
		frm.submit();
	}
</script>
<body>
<div class="wrap">
	<div>
		<h3>지점별 공지사항 등록</h3>
	</div>
	<form id="frm" action="registNotice" method="POST" enctype="multipart/form-data">
		<div>
			<b>제목</b>&nbsp;&nbsp;<input type="text" name="notice_title" />
			<input type="hidden" name="store_code" value="{stCode}" />
		</div>
		<div align="center">
			<textarea id="notice_content" name="notice_content"></textarea>
		</div>
		<div style="margin: 1em 0em;">
			<button class="apply-btn" type="button" onclick="formCheck()">등록</button>&nbsp;&nbsp;
			<button class="back-btn" type="button" onclick="history.back();">돌아가기</button>
		</div>
	</form>
</div>
</body>
</html>