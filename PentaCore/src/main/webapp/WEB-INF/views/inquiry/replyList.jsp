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

	function formCheck() {
		if(frm.question_content.value == "") {
			alert("문의 댓글을 남겨주세요!");
			frm.question_content.focus();
			
			return false;
		}
		
		frm.submit();		
	}
	
</script>
</head>
<body>
	<div class="title-group" style="margin-top: 70px;">
		<h2> 1:1 문의 </h2>
		<div class="subtitle with-square">답변을 확인하세요!</div>
	</div>
	
	<div style="clear:both; width: 100%; height: 20px;"></div>
	
	<!-- === TABLE DEFAULT === -->
	
	<div class="bs-example" style="width: 70%; margin-left: 15%; text-align: left; border: ">
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
					</c:when>
					<c:otherwise >
						<td>
						<img src="resources/assets/images/re.png"> &nbsp;
						 ${vo.question_content }</td>
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
			<button type = "button" class="btn btn-default btn-lg" onclick = "formCheck()">문의</button>
			<a href="iqList" class="btn btn-primary btn-lg" style="margin-left: 10px;">전체문의보기</a> 
		</div>
	</div>		
	<div style="clear:both; width: 100%; height: 70px;"></div>
</body>
</html>