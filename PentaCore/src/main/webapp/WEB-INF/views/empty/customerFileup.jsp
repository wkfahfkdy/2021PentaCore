<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8"> <title>Insert title here</title>
<style type="text/css">
	.wrap {
		margin: auto;
		text-align: center;
		padding: 50px 10px;
		width: 90%;
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
		CKEDITOR.replace('convey_file', {
			filebrowserUploadUrl:'${pageContext.request.contextPath }/fileUpload/imageUpload',
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			height: '30em'
		});
	})
	
	function formCheck() {
		if (frm.convey_file.text == "") {
			alert("내용을 입력하세요.");
			frm.convey_file.focus();
			return false;	// submit을 하지 않도록
		}
		frm.submit();
	}
</script>
</head>
<body>
	<div class="wrap">
	<div style="padding-bottom: 5%;"><h3>운송완료된 사진과 간단한 메모를 해주세요!</h3></div>
	<form id="frm" action="customerFileup" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="apply_code" value="${apply_code }">
		<div class="ask-row3">
			<div class="form-area" align="center">
				<textarea id="convey_file" name="convey_file">${FileupSelect.convey_file }</textarea>
			</div>
		</div>
		<div class="bts">
			<button type="button" class="apply-btn" onclick="formCheck()">등록</button>&nbsp;&nbsp;
			<button type="button" class="back-btn" style="margin: 1em 0em;" onclick="location.href='customer'">돌아가기</button>
		</div>
	</form>
	</div>
</body>
</html>