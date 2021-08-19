<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function formCheck(chk, gubun) {
		if (gubun == "quiry") {
			if (frm.question_content.value == "") {
				alert("문의 댓글을 남겨주세요!");
				frm.question_content.focus();

				return false;
			}

			if (chk == "no") {
				var check = confirm("LOGIN 후 문의해주세요!")
				if (check == true) {
					location.href = "memberLoginForm";
				} else {
					frm.question_content.focus();
				}
			} else {
				frm.submit();
			}
		} else if (gubun == "reply") {
			if (chk == "no") {
				var check = confirm("LOGIN 후 클릭해주세요!")
				if (check == true) {
					location.href = "memberLoginForm";
				}
			} else {
				location.href="replyList";
			}
		}
	}

	function goPage(page) {
		location.href = "iqPaging?page=" + page;
	}
</script>
<style>
	.with-square:before {
		background-color: #478FEB;
	}
	
	a {
		color: #478FEB;
	}
</style>
</head>
<body>
	<div class="title-group" style="margin-top: 70px;">
		<h2>문의게시판</h2>
		<div class="subtitle with-square" style="color: #999;">댓글로 빠르게 문의하세요!</div>
	</div>

	<div style="clear: both; width: 100%; height: 20px;"></div>

	<!-- === TABLE DEFAULT === -->

	<div class="bs-example"
		style="width: 70%; margin-left: 15%; text-align: left;">
		<table class="table">
			<tbody>
				<c:forEach items="${bolist }" var="vo">
					<tr>
						<c:choose>
							<c:when test="${vo.question_parents eq '1'}">
								<td>${vo.question_content }</td>
							</c:when>
							<c:otherwise>
								<td><img src="resources/assets/images/re.png"> &nbsp;
									${vo.question_content }</td>
							</c:otherwise>
						</c:choose>
						<td style="text-align: right;"><fmt:formatDate
								value="${vo.question_date }" pattern="yy-MM-dd HH:mm:ss" /></td>
					</tr>
				</c:forEach>
		</table>
		<!-- 페이징 -->
		<div align="center">
			<jsp:include page="paging.jsp" flush="true">
				<jsp:param value="${paging.firstPageNo }" name="firstPageNo" />
				<jsp:param value="${paging.prevPageNo }" name="prevPageNo" />
				<jsp:param value="${paging.startPageNo }" name="startPageNo" />
				<jsp:param value="${paging.pageNo }" name="pageNo" />
				<jsp:param value="${paging.endPageNo }" name="endPageNo" />
				<jsp:param value="${paging.nextPageNo }" name="nextPageNo" />
				<jsp:param value="${paging.finalPageNo }" name="finalPageNo" />
			</jsp:include>
		</div>
	</div>

	<!-- === 입력하는곳 === -->
	<div class="bs-example"
		style="width: 70%; margin-left: 15%; text-align: left;">
		<div style="float: left; width: 70%">
			<form id="frm" action="inquiryInsert" method="POST">
				<input style="width: 100%; background-color: #fff;" type="text"
					id="question_content" name="question_content" value="자유롭게 물어보세요!"
					onfocus="this.value=''">
			</form>
		</div>
		<div class="btns-row" style="text-align: right;">
			<button type="button" class="btn btn-default btn-lg"
				onclick="formCheck('${chk}', 'quiry')">문의</button>
			<a onclick="formCheck('${chk}', 'reply')" class="btn btn-primary btn-lg" style="margin-left: 10px;">내가쓴글보기</a>
		</div>
	</div>
	<div style="clear: both; width: 100%; height: 70px;"></div>


</body>
</html>