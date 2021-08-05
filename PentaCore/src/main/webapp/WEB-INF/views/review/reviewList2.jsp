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
</script>
</head>
<body>

<div align="center" style="width=80%">
<%-- 
		<form action="reviewInfo" id="ifrm">
			<input type="hidden" id="review_num" name="review_num">

			<table>


				<c:forEach items="${reviewList }" var="review" varStatus="status">
					<c:if test="${status.index %3 == 0 }">
						<tr>
						<td>
					</c:if>
					<c:if test="${status.index %3 == 1 }">
						</td>
						<td>
					</c:if>
					<c:if test="${status.index %3 == 2 }">
						</td>
					</c:if>
					<div >

						<div>


							<img
								src="${pageContext.request.contextPath }/resources/store_img/${review.store_code }.jpg"
								alt="Image" width="30%">


						</div>
						<div>
							<div>
								<div class="review-title">
									<em>${review.store_name }</em> 그럭저럭?
								</div>
								<p class="review-body">아쉬웠던 점다락 대학로점을 사용하면서 느낀점이다1.내가 사용해야
									할&nbsp; DHi16(slim)이 수리가 필요하다...</p>
							</div>
							<div class="review-text-bottom">
								<div class="review-info">
									<span class="review-name origin">전*훈</span> · <span>2021-04-04</span>
								</div>



							</div>
						</div>
					</div>
					
					<c:if test="${status.index %3 == 0 }">
						</td>
						<td>
					</c:if>

					<c:if test="${status.index %3 == 1 }">
						</td>
						<td>
					</c:if>
					<c:if test="${status.index %3 == 2 }">
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</form>
 --%>





		<div class="container">
		
		<form action="reviewInfo" id="ifrm">
			<input type="hidden" id="review_num" name="review_num">


				
			
			<div class="row">
                 <c:forEach items="${reviewList }" var="review" varStatus="status">
				<!-- === SERVICE ITEM === -->	
				
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
				
					<div class="service">				
						<div class="service-icon">
							<img
								src="${pageContext.request.contextPath }/resources/store_img/${review.store_code }.jpg"
								alt="Image" width="100%">
						</div>
						<h3>road freight</h3>
						<div class="service-text">
							<p>Integer congue, elit semper laoreet sed<br>lectus orci posuh nisl tempor<br>lacus felis ac mauris.<br>elit non in urna.</p>
						</div>
						<div class="service-button">
							<a href="05_service_detail.html">
								<div class="my-btn my-btn-default">
									<div class="my-btn-bg-top"></div>
									<div class="my-btn-bg-bottom"></div>
									<div class="my-btn-text">
										MORE
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