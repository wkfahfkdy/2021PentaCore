<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
.wrap {
	margin: auto;
	text-align: center;
}

ul {
	list-style: none;
}

.review-text-bottom {
	margin-top: 20px;
}

.review-info {
	margin-bottom: 2px;
	color: #999;
	font-size: 14px;
}

.service {
	height: 410.66px;
}

.pagination {
	display: inline-block;
}

.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
}

.pagination a.active {
	background-color: #478FEB;
	color: white;
	border: 1px solid #478FEB;
}

.pagination a:hover:not(.active) {
	background-color: #ddd;
}

.main1 .search-box {
	width: 750px;
	margin-top: 38px;
}

.main1 .search-box fieldset {
	position: relative;
	overflow: hidden;
}

.main1 .search-box legend {
	background: #89BA16;
	color: #fff;
}

.main1 .search-box input {
	border: 0;
	background: #fff;
	width: 100%;
	padding: 10px;
	padding-left: 18px;
	font-size: 20px;
	color: #000;
}

.main1 .search-box input:focus {
	outline: none
}

.main1 .search-box input, .main1 .search-box .main-box {
	width: 100%;
	border: 5px solid #89BA16;
	overflow: hidden;
}

.main1 .search-box .main-box .title-box {
	position: absolute;
	left: 0;
	background: #89BA16;
	color: #fff;
	font-size: 18px;
	padding: 13px 0;
	width: 150px;
	text-align: center;
}

.label {
	display: inline-block;
	width: 300px;
	height: 40px;
	font-weight: bold;
	margin-right: 30px;
}

.sorting {
	height: 30px;
	padding: 3px;
}

.sorting .left {
	width: 80%;
	float: left;
}

.sorting .right {
	width: 20%;
	float: right;
}
</style>
<script type="text/javascript">
	/*
	function reviewInfo(review_num) {
		ifrm.review_num.value=review_num;
		ifrm.submit();
	}
	*/
</script>
<script type="text/javascript">
	function goPage(page) {
		location.href="reviewList?page="+page;
	}
	
	function reviewDetail(review_num1) {
		
		ifrm.review_num.value=review_num1;
		ifrm.submit();
	}
</script>
</head>
<body>
<div class="wrap">
	<div style="margin: 3em 0em; background: #478FEB; padding: 1.5em 0em; color: white;">
		<h1>Review</h1>
	</div>
	<div class="container">
		<form action="reviewDetail" id="ifrm">
			<input type="hidden" id="review_num" name="review_num">
			<div class="row">
				<c:forEach items="${reviewList }" var="reviewVO" varStatus="status">
					<!-- === SERVICE ITEM === -->

					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" height="100%" style="margin-bottom: 1em;">

						<div class="service" style="border: 1px lightgray solid; border-radius: 0.3em;">
							<div>
								<img
									src="${pageContext.request.contextPath }/resources/store_img/${reviewVO.store_code }.jpg"
									alt="Image" width="210px" height="120px">
							</div>
							<div class="service-text">
								<h5>${reviewVO.review_title }</h5>

								<%-- 							<p>${reviewVO.review_content }</p> --%>
							</div>


							<div class="service-button">
								<a onclick="reviewDetail(${reviewVO.review_num})">

									<div class="my-btn my-btn-default">
										<div class="my-btn-bg-top"></div>
										<div class="my-btn-bg-bottom"></div>
										<div class="my-btn-text">상세 보기</div>
									</div>
								</a>
							</div>

							<div class="review-text-bottom">
								<div class="review-info">
									<span>${reviewVO.member_name }</span> · <span>${reviewVO.review_date }</span>
								</div>
							</div>

						</div>

					</div>
				</c:forEach>

			</div>

		</form>
	</div>
	<div align="center" style="padding-bottom: 4em;">
		<jsp:include page="../review/paging.jsp" flush="true">
			<jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
			<jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
			<jsp:param name="startPageNo" value="${paging.startPageNo}" />
			<jsp:param name="pageNo" value="${paging.pageNo}" />
			<jsp:param name="endPageNo" value="${paging.endPageNo}" />
			<jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
			<jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
		</jsp:include>
	</div>

</div>
 <%--   <div class="def-section services-1">
	<div class="container">
	<form action="reviewDetail" id="ifrm">
	<input type="hidden" id="review_num" name="review_num">
		<div class="row">
			 <c:forEach items="${reviewList }" var="reviewVO" varStatus="status">
			<!-- === SERVICE ITEM === -->
			<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
				<div class="service-1">
					<div class="service-1-image">
						<img
							src="${pageContext.request.contextPath }/resources/store_img/${reviewVO.store_code }.jpg"
							alt="Image" width="70%">
					</div>
					<div class="service-1-title">
						<h3>${reviewVO.review_title }</h3>
					</div>
					<div class="service-1-text" >
						<p align="center">
							${reviewVO.review_content }
						</p>
					</div>
					<div class="service-1-button">
						<a href="05_service_detail.html">
							<div class="my-btn my-btn-default">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									상세보기
								</div>
							</div>
						</a>
					</div>					
				</div>
			</div>
			</c:forEach>
		</div>
		</form>
	</div>
</div>  --%>
</body>
</html>