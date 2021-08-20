<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	a {
		color: #478FEB;
	}
	
	.wrap{
		margin: auto;
		margin-top: 20px;
		margin-bottom: 50px;
		width: 70%;
		min-height: 100%;
	}
	
	
	.using-service{	/*이용 중인 서비스 div*/
		display: table;
		width: 100%;
		border-top: 1px lightgray solid;
		padding: 3em 2em;
	}
	
	.using-storage{
		display: table-cell;
		width: 70%;
	}
	
	.premium-service{
		display: table-cell;
		width: 30%;
		text-align: left;
		padding: 1em;
		border-left: 2px #E6E6E6 dotted;
	}
	
	.premium-title, .notice-title{
		padding: 0em 1em;
	}

	.premium-row, .go-notice {
		padding: 0em 2em;
	}
	
	th {
		text-align: center;
	}
	
	img {
		width: 100%; height: auto;
	}
	
	.info-td {
		padding: 5px;
	}
	
	.review-btn{
		background-color: #478FEB;
		border-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		padding: 0.5em;
	}
</style>
</head>
<body>
	<div class="wrap">
		<div>
			<h3>${loginName } 님의 이용중인 스토리지 리스트</h3>
		</div><br>
		<c:forEach items="${totalUseStorageList }" var="totalList">
			<div class="using-service">
				<div class="using-storage">
					<table>
						<tr>
							<td rowspan="5" style="width: 25%; padding: 1.5em;"><img src="${pageContext.request.contextPath }/resources/img/—Pngtree—blue box carton_4884881.png" ></td>
							<td class="info-td"><b><font style="color:#478FEB ; font-size: 12pt;">${totalList.store_name }</font> ${totalList.info_num } ${totalList.storage_name }</b>(${totalList.storage_width }*${totalList.storage_height }*${totalList.storage_vertical }) 이용중  (${totalList.store_name } 온도 : ${totalList.humidity}C˚ , 습도 : ${totalList.temperature }%)</td>
						</tr>
						<tr>
							<td style=" width: 60%;"><h5>&nbsp;사용기간 :&nbsp;&nbsp;
								<fmt:formatDate value="${totalList.use_start }" type="date" pattern="yyyy년 MM월 dd일" />&nbsp;~&nbsp;
								<fmt:formatDate value="${totalList.use_end }" type="date" pattern="yyyy년 MM월 dd일"/> </h5>
							</td>
						</tr>
						<tr>
							<td class="info-td">
								<font style="color: #478FEB; font-weight: bold; font-size: 11pt;">이용 중인 물품</font>
							</td>
						</tr>
						<tr>
							<td style="padding-left: 5px;">
								${totalList.offer_product }
							</td>
						</tr>
						<tr>
							<td class="info-td">
								<font style="color: #478FEB; font-weight: bold; font-size: 11pt;">이용 중인 서비스</font>
							</td>
						</tr>
						<tr>
							<td rowspan="2" style="width: 20%; text-align: center">
								<c:choose>
									<c:when test="${empty totalList.review_title }">
										<button class="review-btn" onclick="location.href='reviewForm'">리뷰작성</button>
									</c:when>
									<c:otherwise>
										<button class="review-btn" onclick="location.href='reviewList'">리뷰페이지</button>
									</c:otherwise>
								</c:choose>
							</td>
							<td style="padding-left: 5px;">	
								<c:choose>
									<c:when test="${totalList.offer_wash eq 'N' and totalList.offer_premium eq 'N' }">
										이용 중인 서비스가 없습니다.
									</c:when>
									<c:when test="${totalList.offer_wash eq 'N' and totalList.offer_premium eq 'Y' }">
										프리미엄 보관 서비스 이용 중입니다.
									</c:when>
									<c:when test="${totalList.offer_wash eq 'Y' and totalList.offer_premium eq 'N' }">
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
					<div class="premium-title">
						<h3>Premium Service</h3>
					</div>
					<div class="premium-row">
						<c:choose>
							<c:when test="${totalList.offer_wash eq 'N' and totalList.offer_premium eq 'N' }">
								<b>이용 중인 서비스가 없습니다.</b>
							</c:when>
							<c:when test="${totalList.offer_wash eq 'N' and totalList.offer_premium eq 'Y' }">
								<a href="conditionReport" style="font-size: 12pt;">물품 컨디션 보고서 조회</a><br>
							</c:when>
							<c:when test="${totalList.offer_wash eq 'Y' and totalList.offer_premium eq 'N' }">
								<a href="myLaundry" style="font-size: 12pt;">세탁 물품 처리 현황</a>
							</c:when>
							<c:otherwise>
								<div class="premium-row">
									<a href="conditionReport" style="font-size: 12pt">물품 컨디션 보고서 조회</a><br>
									<a href="myLaundry" style="font-size: 12pt">세탁 물품 처리 현황</a>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>