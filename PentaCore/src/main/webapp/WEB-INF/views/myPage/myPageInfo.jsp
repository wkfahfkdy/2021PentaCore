<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<style>
	.wrap{
		margin: auto;
		margin-top: 20px;
		margin-bottom: 50px;
		width: 80%;
	}
	
	.notice-btns{	/*공지사항 및 기능버튼들 전체 div*/
		display: table;
		width: 100%;
		padding: 30px;
	}
	
	.notice{
		display: table-cell;
		width: 50%;
		text-align: center;
	}
	
	.func-btns{
		display: table-cell;
		width: 50%;
		text-align: center;
		vertical-align: middle;
	}
	
	.btns-range{
		display: inline-block;
	}
	
	.using-service{	/*이용 중인 서비스 div*/
		display: table;
		width: 100%;
		border-top: 2px lightgray solid;
		padding-top: 30px;
		padding-bottom: 30px;
		padding-left: 20px;
		padding-right: 20px;
	}
	
	.using-storage{
		display: table-cell;
		width: 70%;
	}
	
	.premium-service{
		display: table-cell;
		width: 30%;
		text-align: center;
		padding: 10px;
		border-left: 2px lightgray solid;
	}
	
	.review-btn{
		background-color: #00c0e2;
		border-color: #00c0e2;
		color: white;
		font-size: 15pt;
		padding: 0.3em;
	}
	
	.btns {
		background-color: #00c0e2;
		border-color: #00c0e2;
		color: white;
		font-size: 15pt;
		font-family: 'Nanum Gothic', sans-serif;
		font-weight: bold;
		padding: 0.5em;
		width: 130px;
		height: 75px;
	}
	
	th {
		text-align: center;
	}
</style>
</head>
<body>
	<div class="wrap">
		<div>
			<h2>${loginName } 님:)</h2>
		</div><br>
		<div class="notice-btns">
			<div class="notice">
			<c:choose>
				<c:when test="${!empty noticeSelectList }">
					<table>
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
					${notice }
				</c:otherwise>
			</c:choose>
			</div>
			<div class="func-btns">
				<div class="btns-range">
					<button class="btns" onclick="location.href='offerList'">나의 견적서</button>
					<button class="btns" onclick="location.href='conveyList'">물품운송<br>신청조회</button>
					<button class="btns" onclick="location.href='#'">투어예약<br>신청조회</button>
				</div>
				<br>
				<div class="btns-range">
					<button class="btns" onclick="location.href='memberInfoEdit'">회원정보<br>수정</button>
					<button class="btns" onclick="location.href='#'">1:1문의내역</button>
					<button class="btns" onclick="location.href='#'">Coupon & Events</button>
				</div>
			</div>
		</div>
		<div class="using-service">
			<c:choose>
				<c:when test="${!empty usedStorageList }">
					<c:forEach items="${usedStorageList }" var="useInfo">
						<div class="using-storage">
							<table>
								<tr>
									<td rowspan="5" style="width: 20%; padding: 5px;"></td>
									<td style=" width: 60%;"><h4>사용기간 :&nbsp;&nbsp;
										<fmt:formatDate value="${useInfo.use_start }" type="date" pattern="yyyy년 MM월 dd일" />&nbsp;~&nbsp;
										<fmt:formatDate value="${useInfo.use_end }" type="date" pattern="yyyy년 MM월 dd일"/> </h4>
									</td>
									<td rowspan="5" style="width: 20%; text-align: center">
										<button class="review-btn" onclick="location.href='#'">Review</button>
									</td>
								<tr>
								<tr>
									<td style="padding: 5px;">${useInfo.store_name } ${useInfo.info_num } ${useInfo.storage_name } ${useInfo.storage_width }*${useInfo.storage_height }*${useInfo.storage_vertical } 이용중 </td>
								</tr>
								<tr>
									<td style="padding: 5px;">
										이용 중인 물품 : ${useInfo.offer_product }
									</td>
								</tr>
								<tr>
									<td style="padding: 5px;">
										이용 중인 서비스 : 
										<c:choose>
											<c:when test="${useInfo.offer_wash eq 'N' and useInfo.offer_premium eq 'N' }">
												이용 중인 서비스가 없습니다.
											</c:when>
											<c:when test="${useInfo.offer_wash eq 'N' and useInfo.offer_premium eq 'Y' }">
												프리미엄 보관 서비스 이용 중입니다.
											</c:when>
											<c:when test="${useInfo.offer_wash eq 'Y' and useInfo.offer_premium eq 'N' }">
												세탁 서비스 이용 중입니다.
											</c:when>
											<c:otherwise>
												프리미엄 서비스, 세탁 서비스 이용 중입니다.
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</table>
						</div>
						<div class="premium-service">
							<div>
								<h4>Premium Service</h4>
							</div>
							<div>
								<a href="#" style="font-size: 13pt">물품 컨디션 보고서 조회</a><br>
								<a href="#" style="font-size: 13pt">세탁 물품 처리 현황</a>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					${useService }
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>