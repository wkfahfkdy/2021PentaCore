<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="title-group" style="margin-top: 70px;">
		<h2> 1:1 문의 </h2>
		<div class="subtitle with-square">댓글로 빠르게 문의하세요!</div>
	</div>
	
	<div style="clear:both; width: 100%; height: 20px;"></div>
	
	<!-- === TABLE DEFAULT === -->
	
	<div class="bs-example" style="width: 70%; margin-left: 15%; text-align: left; border: ">
		<table class="table">
			<thead>
			</thead>
		<tbody>
		<c:forEach items="${inquirySelectList }" var="vo">
			<tr>
				<c:choose>
					<c:when test="${vo.question_parents eq '1'}">
						<td>${vo.question_content }</td>
						<td style="text-align: right;">
							${vo.question_date }
						</td>
					</c:when>
					<c:otherwise >
						<td>답변 : ${vo.question_content }</td>
						<td style="text-align: right;">
							${vo.question_date }
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
			<form>
				<input style="width:100%; background-color:#fff;"
						type="text" name="inquiryInsert" value="자유롭게 물어보세요!"
						onfocus="this.value=''"
						onblur="this.value='자유롭게 물어보세요!'">
			</form>
		</div>
		<div class="btns-row" style="text-align: right;">
			<a href="#" class="btn btn-default btn-lg">문의</a> 
			<a href="#" class="btn btn-primary btn-lg" style="margin-left: 10px;">내가쓴글보기</a> 
		</div>
	</div>		
	<div style="clear:both; width: 100%; height: 70px;"></div>
</body>
</html>