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
    	background-color: #478FEB;
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
		
		CKEDITOR.replace('review_content', {
			filebrowserUploadUrl:'${pageContext.request.contextPath }/fileUpload/imageUpload',
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			height: '600px',
			width: '80%'
		});
	})
	
	
	function formCheck() {
	
		
		if (frm.review_title.value == "") {
			alert("제목을 입력하세요.");
			frm.review_title.focus();
			return false;	// submit을 하지 않도록
		}
		frm.submit();
	}
</script>

<script>
</script>
</head>
<body>
<div class="wrap">
	<div>
		<h3><font style="color: #00c0e2;">${loginName }</font>님의 <font style="color: #00c0e2;">${useStore }</font> 이용 리뷰 페이지</h3>
	</div>
	<form id="frm" action="reviewUpdate" method="POST" enctype="multipart/form-data">
		<div>
			<input type="text" id="review_title" name="review_title" value='${review_title }'/>
			<input type="hidden" id="" name="review_num" value='${review_num }' />
		</div>
		<div align="center">
			<textarea id="review_content" name="review_content"></textarea>
		</div>
		<div style="margin: 1em 0em;">
			<button class="apply-btn" type="button" onclick="formCheck()">수정</button>&nbsp;&nbsp;
			<button class="back-btn" type="button" onclick="history.back();">돌아가기</button>
		</div>
	</form>
</div>
</body>
</html>