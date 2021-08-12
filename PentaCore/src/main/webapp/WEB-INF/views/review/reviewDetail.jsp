<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.review-detail {
    border: 1px solid #e1e1e1;
    border-radius: 5px;
    overflow: hidden;
    padding: 40px;
    background: #fff;
        font-weight: bold;
}

.review-detail-title {
    flex-grow: 1;
    font-size: 22px;
        font-weight: bold;
}

.review-info {
    margin-bottom: 2px;
    color: #999;
    font-size: 16px;
}

body {
    font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', 'Malgun Gothic', sans-serif;
    font-size: 15px;
    font-weight: 300;
    -webkit-font-smoothing: subpixel-antialiased!important;
    -webkit-backface-visibility: hidden;
    -moz-backface-visibility: hidden;
    -ms-backface-visibility: hidden;
}

p .font {
    color: black;
    background: #fff;
    line-height: normal;
    text-align: left;
}

</style>

</head>

<body>
	<div class="container">
	<div><h3>이용후기</h3></div>
	
	<div class="review-detail">
			<div>
				<div class="review-detail-title">
					<em>[${reviewVO.store_name }]</em> ${reviewVO.review_title }</div>
			</div>
			<div class="review-info">
				<span >${reviewVO.member_name }</span> · <span>${reviewVO.review_date }</span>
			</div>
			<br><br><br>
			<div class="review-detail-body">
			<p class="font">					
				${reviewVO.review_content }				
			</p>
			<c:if test="${imageCheck ne '<im' }">
			<p>
			<img
								src="${pageContext.request.contextPath }/resources/store_img/${reviewVO.store_code }.jpg"
								alt="Image" width="60%">
			</p>
			</c:if>
		
						<br>
		</div>
		</div>
		<br><br>
		<div class="service-button" align="center">
							<a href="reviewList">
								<div class="my-btn my-btn-default">
									<div class="my-btn-bg-top"></div>
									<div class="my-btn-bg-bottom"></div>
									<div class="my-btn-text">
										목록
									</div>
								</div>
							</a>
						</div>
		<br><br>
		
		
		</div>
</body>
</html>