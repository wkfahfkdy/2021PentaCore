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
	
	function goPage(page) {
		location.href = "iqPaging?page=" + page;
	}
	function show(question_num) {
		console.log(question_num);
		document.getElementById("trshow${question_num}").style.display = 'block';
	}

</script>
</head>
<body>
	<div class="title-group" style="margin-top: 70px;">
		<h2> 1:1 문의 </h2>
		<div class="subtitle with-square">댓글로 빠르게 문의하세요!</div>
	</div>
	
	<div style="clear:both; width: 100%; height: 20px;"></div>
	
	<!-- === TABLE DEFAULT === -->
	
	<div class="bs-example" style="width: 70%; margin-left: 15%; text-align: left; ">
		<table class="table">
		<tbody>
		<c:forEach items="${bolist }" var="vo">
			<tr>
				<td>${vo.question_content }</td>
				<td style="text-align: right;">
					<fmt:formatDate value="${vo.question_date }" pattern="yy-MM-dd HH:mm:ss" />
				</td>
				<td>
					<button type="button" id="re${vo.question_num}" name="re" onclick="show('${vo.question_num}')" >re</button>
				</td>
			</tr>					
			<tr style="display: none;" id="trshow${vo.question_num}">
				<td>
					<div>
						<input size="50" style="height: 10px; background-color: #fff; " 
							type="text" id="reply" name="reply" value="입력하라!">
					</div>
				</td>
				<td>
					<button type="button" id="chk" name="chk" >확인</button>
				</td>				
				<td>
					<button type="button" id="del" name="del" >삭제</button>
				</td>				
			</tr>
		</c:forEach>
		</table>		
		<!-- 페이징 -->
		<div align="center">
			<jsp:include page="paging.jsp" flush ="true">
				<jsp:param value="${paging.firstPageNo }" name="firstPageNo"/>
				<jsp:param value="${paging.prevPageNo }" name="prevPageNo"/>
				<jsp:param value="${paging.startPageNo }" name="startPageNo"/>
				<jsp:param value="${paging.pageNo }" name="pageNo"/>
				<jsp:param value="${paging.endPageNo }" name="endPageNo"/>
				<jsp:param value="${paging.nextPageNo }" name="nextPageNo"/>
				<jsp:param value="${paging.finalPageNo }" name="finalPageNo"/>
			</jsp:include>
		</div>
	</div>
	
	<div style="clear:both; width: 100%; height: 70px;"></div>
</body>
</html>