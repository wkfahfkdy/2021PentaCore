<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
<div align="center"> 
<h5>고객관리</h5>
</div>
<br><br>

<div class="notice">
			<c:choose>
				<c:when test="${!empty noticeSelectList }">
					<table style="width: 100% ">
					<caption><a href="noticeList">이용 지점 공지사항</a>&nbsp;&nbsp;&nbsp;&nbsp;</caption>
						<tr>
							<th>no.</th><th>제목</th><th>작성일</th>
						</tr>
						<c:forEach items="${noticeSelectList }" var="nt" end="5">
						<tr>
							<td style="width: 10%">
								${nt.notice_num }
							</td>
							<td style="width: 60%">
								${nt.notice_title }
							</td>
							<td style="width: 30%">
								<fmt:formatDate value="${nt.notice_date }" type="date" pattern="yy-MM-dd"/> 
							</td>
						</tr>
						</c:forEach>
					</table>
				</c:when>
				<c:otherwise>
					<h3>${notice }</h3>
				</c:otherwise>
			</c:choose>
			</div>

</div>




</body>
</html>