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
	// 댓글작성
	function formCheck() {
		if($("#question_content").val() == "") {
			alert("답변댓글을 남겨주세요!");
			$("#question_content").focus();
			
			return false;
			
		}
		
		$("#frm").submit();		
	}

	
	function goPage(page) {
		location.href = "iqAdmin?page=" + page;
	}
	
	 function show(id) { // 나중에,,,요? 
		console.log();
		document.getElementById('showme'+id).style.display = 'block';
	} 
	
	
	
</script>
</head>
<body>
	<div class="title-group" style="margin-top: 70px;">
		<h2> 1:1 문의 </h2>
		<div class="subtitle with-square">댓글로 빠르게 문의하세요!</div>
	</div>
	
	<div style="clear:both; width: 100%; height: 20px;"></div>
	+
	<!-- === TABLE DEFAULT === -->
	
	<div class="bs-example" style="width: 70%; margin-left: 15%; text-align: left; ">
		<table class="table">
		<tbody>
		<c:forEach items="${bolist }" var="vo">
			<tr id="add${vo.question_num}">
				<c:choose>
					<c:when test="${vo.question_parents eq '1'}">
						<td>${vo.question_content }</td>
					</c:when>
					<c:otherwise>
						<td><img src="resources/assets/images/re.png"> &nbsp;
							${vo.question_content }</td>
					</c:otherwise>
				</c:choose>
				<td style="text-align: right;">
					<fmt:formatDate value="${vo.question_date }" pattern="yy-MM-dd HH:mm:ss" />
				</td>
				<td>
					<c:if test="${vo.question_parents eq '1'}">
						<button type="button" id="re" name="re" data-id="${vo.question_num}" onclick="show(${vo.question_num})"  >re</button>
					</c:if>
				</td>
				<td>
					<form id="del" action="adminDelete" method="POST">
						<input type ="hidden" name = "question_num" value="${vo.question_num}">
						<input type="submit" style=" padding-top: -10px; cursor: pointer;" value="x" />
					</form>
				</td>
			</tr>					
			<tr id="showme${vo.question_num }" style="display:none;"  >
				<td colspan="3" id="${vo.question_num }">
					<form id="frm" name="frm" action="replyInsert" method="POST">
						<input size="100%" style="width:100%; background-color:#fff;"
								type="text" id="question_content" name="question_content"
								value="답변을 입력해주세오!" 
								/>
						<input type="hidden" name ="question_group" value="${vo.question_num }">
					</form>	
				</td>
				<td style="text-align: right;">
					<button style="width: 30px" 
						type="button" onclick="formCheck(${vo.question_num})">
						<a style="padding-top: 20px;">확인</a></button>	
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