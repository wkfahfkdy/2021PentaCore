<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	// 문의작성
	function formCheck() {
		if(frm.question_content.value == "") {
			alert("문의글을 남겨주세요!");
			frm.question_content.focus();
			
			return false;
			
		}
		
		frm.submit();		
	}
	
	function delFunction(question_num){
		var delCheck = $('#' + question_num +'hiddenQuestionParants').val()
		console.log(delCheck);
		if(delCheck === undefined) {
			$('#del').submit();
		} else {
			alert("해당문의에 답변이 있어 삭제가 불가능합니다!");
			return false;
		}
	}
	
</script>
<style>
	.with-square:before {
		background-color: #478FEB;
	}
	
</style>
</head>
<body>
	<div class="title-group" style="margin-top: 70px;">
		<h2> 1:1 문의 </h2>
		<div class="subtitle with-square">답변이 달린 댓글은 삭제가 안돼요!</div>
	</div>
	
	<div style="clear:both; width: 100%; height: 20px;"></div>
	
	<!-- === TABLE DEFAULT === -->
	
	<div class="bs-example" style="width: 70%; margin-left: 15%; text-align: left;">
		<table class="table">
			<thead>
			</thead>
		<tbody>
		<c:forEach items="${replyList }" var="vo">
			<tr>
				<c:choose>
					<c:when test="${vo.question_parents eq '1'}">
						<td>${vo.question_content }</td>
						<td style="text-align: right;">
							<fmt:formatDate value="${vo.question_date }" pattern="yy-MM-dd HH:mm:ss" />
						</td>
						<td>
							<form id="del" action="inquiryDelete" method="POST">
								<input type ="hidden" name = "question_num" value="${vo.question_num}">
								<button type="button" onclick="delFunction('${vo.question_num}')" style=" padding-top: -10px; cursor: pointer;" value="x" >삭제</button>
							</form>
						</td>	
					</c:when>
					<c:otherwise >
						<td>
						<img src="resources/assets/images/re.png"> &nbsp;
						 ${vo.question_content }</td>
						 <input type ="hidden" id="${vo.question_group }hiddenQuestionParants" value="${vo.question_parents }">
						<td style="text-align: right;">
							<fmt:formatDate value="${vo.question_date }" pattern="yy-MM-dd HH:mm:ss" />
						</td>
					</c:otherwise>
				</c:choose>
			</tr>					
		</c:forEach>
		</table>
	</div>
	
	<!-- === 입력하는곳 === -->
	<div class="bs-example" style="width: 70%; margin-left: 15%; text-align: left;  ">
		<div style="float: left; width: 70%"> 
			<form id="frm" action="inquiryInsert" method="POST">
				<input style="width:100%; background-color:#fff;"
						type="text" id="question_content" name="question_content" 
						value="자유롭게 물어보세요!"
						onfocus="this.value=''">
			</form>
		</div>
		<div class="btns-row" style="text-align: right;">
			<button type="button" class="btn btn-default btn-lg" onclick = "formCheck()">문의</button>
			<a href="iqPaging" class="btn btn-primary btn-lg" style="margin-left: 10px;">전체문의보기</a> 
		</div>
	</div>		
	<div style="clear:both; width: 100%; height: 70px;"></div>
</body>
</html>