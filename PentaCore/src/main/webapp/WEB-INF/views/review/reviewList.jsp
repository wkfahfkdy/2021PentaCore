<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>

ul{
   list-style:none;
   }
   
.review-text-bottom {
    margin-top: 20px;
}
   
.review-info {
    margin-bottom: 2px;
    color: #999;
    font-size: 14px;
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
  background-color: #89ba16;
  color: white;
  border: 1px solid #89ba16;
}

.pagination a:hover:not(.active) {background-color: #ddd;}
.main1 .search-box {width:750px;margin-top:38px;}
.main1 .search-box fieldset{position:relative;overflow:hidden;}
.main1 .search-box legend {background:#89BA16;color:#fff;}
.main1 .search-box input {border:0;background:#fff;width:100%;padding:10px;padding-left:18px;font-size:20px;color:#000;}
.main1 .search-box input:focus{outline:none}
.main1 .search-box input,

.main1 .search-box .main-box {width:100%;border:5px solid #89BA16;overflow:hidden;}
.main1 .search-box .main-box .title-box {position:absolute;left:0;background:#89BA16;color:#fff;font-size:18px;padding:13px 0;width:150px;text-align:center;}

.label {
	display: inline-block;
	width: 300px;
	height: 40px;
	font-weight: bold;
	margin-right: 30px;
}

.sorting { height: 30px; padding: 3px;}
.sorting .left { width: 80%; float: left; }
.sorting .right { width: 20%; float: right; }
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

<div align="center" >



		<div class="container">
		
		<form action="reviewDetail" id="ifrm">
		<input type="hidden" id="review_num" name="review_num">
			<div class="row">
                 <c:forEach items="${reviewList }" var="reviewVO" varStatus="status">
				<!-- === SERVICE ITEM === -->	
				
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
				
					<div class="service">				
						<div class="service-icon">
							<img
								src="${pageContext.request.contextPath }/resources/store_img/${reviewVO.store_code }.jpg"
								alt="Image" width="100%">
						</div>
						<h3>${reviewVO.review_title }</h3>
						<div class="service-text">
							<p>${reviewVO.review_content }</p>
						</div>
						
						
						<div class="service-button">
							<a onclick="reviewDetail(${reviewVO.review_num})">
							
								<div class="my-btn my-btn-default">
									<div class="my-btn-bg-top"></div>
									<div class="my-btn-bg-bottom"></div>
									<div class="my-btn-text">
										상세 보기
									</div>
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
</body>
</html>