<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<style>
	.wrap{
		margin: auto;
		margin-top: 20px;
		margin-bottom: 50px;
		width: 80%;
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
		text-align: center;
		padding: 10px;
		border-left: 2px lightgray solid;
	}
	
	.notice-btns{	/*공지사항 및 기능버튼들 전체 div*/
		display: table;
		padding: 3em 2em;
		width: 100%;
		border-top: 1px lightgray solid;
	}
	
	.func-btns{
		display: table-cell;
		width: 70%;
		text-align: center;
		vertical-align: middle;
	}

	.notice{
		display: table-cell;
		text-align: center;
		border-left: 2px lightgray solid;
	}
	
	
	.btns-range-top, .btns-range-bottom{
		display: flex;
		padding-left: 8em;
	}

	.review-btn{
		background-color: #00c0e2;
		border-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		padding: 0.5em;
	}
	
	.btns {
		background-color: #00c0e2;
		border-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-size: 15pt;
		font-family: 'Nanum Gothic', sans-serif;
		font-weight: bold;
		padding: 0.5em;
		width: 130px;
		height: 75px;
		margin: 0em 0.4em;
	}
	
	th {
		text-align: center;
	}
	
	caption {
		color: black;
		font-size: 14pt;
		font-weight: bold;
		margin: 0em 0em 1em;
		padding: 0px 0px;
		margin: 0px 0px 0px;
	}
	
	img {
		width: 100%; height: auto;
	}
	
	.info-td {
		padding: 5px;
	}
</style>
<script>
	//세탁 물품 처리 현황
	
	
</script>
</head>
<body>
	<div class="wrap">
		<div>
			<h2>${loginName } 님:)</h2>
		</div><br>
		<div class="using-service">
			<c:choose>
				<c:when test="${!empty usedStorageList }">
					<c:forEach items="${usedStorageList }" var="useInfo">
						<div class="using-storage">
							<table>
								<tr>
									<td rowspan="7" style="width: 20%; padding: 1.5em;"><img src="${pageContext.request.contextPath }/resources/img/—Pngtree—blue box carton_4884881.png" ></td>
									<td style=" width: 60%;"><h4>사용기간 :&nbsp;&nbsp;
										<fmt:formatDate value="${useInfo.use_start }" type="date" pattern="yyyy년 MM월 dd일" />&nbsp;~&nbsp;
										<fmt:formatDate value="${useInfo.use_end }" type="date" pattern="yyyy년 MM월 dd일"/> </h4>
									</td>
									<td rowspan="7" style="width: 20%; text-align: center">
										<c:choose>
											<c:when test="${empty userReview.review_title }">
												<button class="review-btn" onclick="location.href='reviewForm'">리뷰작성</button>
											</c:when>
											<c:otherwise>
												<button class="review-btn" onclick="location.href='reviewList'">리뷰페이지</button>
											</c:otherwise>
										</c:choose>
									</td>
								<tr>
								<tr>
									<td class="info-td"><b><font style="color: #006DFC;">${useInfo.store_name }</font> ${useInfo.info_num } ${useInfo.storage_name }</b>(${useInfo.storage_width }*${useInfo.storage_height }*${useInfo.storage_vertical }) 이용중 </td>
								</tr>
								<tr>
									<td class="info-td">
										<font style="color: #00c0e2; font-weight: bold;">이용 중인 물품</font>
									</td>
								</tr>
								<tr>
									<td style="padding-left: 5px;">
										${useInfo.offer_product }
									</td>
								</tr>
								<tr>
									<td class="info-td">
										<font style="color: #00c0e2; font-weight: bold;">이용 중인 서비스</font>
									</td>
								</tr>
								<tr>
									<td style="padding-left: 5px;">	
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
								<c:choose>
									<c:when test="${useInfo.offer_wash eq 'N' and useInfo.offer_premium eq 'N' }">
										이용 중인 서비스가 없습니다.
									</c:when>
									<c:when test="${useInfo.offer_wash eq 'N' and useInfo.offer_premium eq 'Y' }">
										<a href="conditionReport" style="font-size: 13pt">물품 컨디션 보고서 조회</a><br>
									</c:when>
									<c:when test="${useInfo.offer_wash eq 'Y' and useInfo.offer_premium eq 'N' }">
										<a href="#" onclick="" style="font-size: 13pt">세탁 물품 처리 현황</a>
									</c:when>
									<c:otherwise>
										<a href="conditionReport" style="font-size: 13pt">물품 컨디션 보고서 조회</a><br>
										<a href="#" onclick="" style="font-size: 13pt">세탁 물품 처리 현황</a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					${useService }
				</c:otherwise>
			</c:choose>
		</div>
		<div class="notice-btns">
			<div class="func-btns">
				<div class="btns-range-top" align="center">
					<button class="btns" onclick="location.href='offerList'">나의 견적서</button>
					<button class="btns" onclick="location.href='conveyList'">물품운송<br>신청조회</button>
					<button class="btns" onclick="location.href='storeTour'">투어예약<br>신청조회</button>
				</div>
				<br>
				<div class="btns-range-bottom">
					<button class="btns" onclick="location.href='memberInfoEdit'">회원정보<br>수정</button>
					<button class="btns" onclick="location.href='myAsk'">1:1문의내역</button>
				</div>
			</div>
			<div class="notice">
				<h4>Store Notice</h4>
				<h5><a href="noticeList">이용 지점 공지사항 바로가기</a></h5>
			</div>
		</div>
	</div>
</body>
</html>