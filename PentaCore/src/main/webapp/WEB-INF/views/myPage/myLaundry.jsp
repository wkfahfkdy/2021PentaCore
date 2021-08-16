<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.wrap {
		margin: auto;
		text-align: center;
		padding: 50px 30px;
		width: 80%;
	}
	
    .back-btn {
    	background-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		padding: 0.4em;
    }   
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
<div class="wrap">
	<div>
		<h3>세탁 처리 현황</h3>
	</div>
	<!-- 세탁 현황 그리드 -->
	<div id="laundryGrid" align="center"></div>
	<div style="margin: 1em 0em;">
			<button class="back-btn" type="button" onclick="history.back()">돌아가기</button>
		</div>
</div>
<script>
// 견적서 내역 그리드 생성
$(document).ready(function() {
	const Grid = tui.Grid;
	
	const laundryData = [
					<c:forEach items="${myLaundry}" var="list" varStatus="status">
					{
						laundry_code: '${list.laundry_code}',
						laundry_product: '${list.laundry_product}',
						store_name: '${list.store_name}',
						laundry_consign:'<fmt:formatDate value="${list.laundry_consign}" pattern="yyyy-MM-dd" />',
						laundry_collect: '<fmt:formatDate value="${list.laundry_collect}" pattern="yyyy-MM-dd" />',
						laundry_company: '${list.laundry_company}'
					}
					<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				]
	
	console.log(laundryData);
	
	const laundryGrid = new Grid({
		el : document.getElementById('laundryGrid'),
		data: laundryData,
		columns : [
			{
				header: '처리코드',
				name: 'laundry_code',
				align: 'center',
				width: 100
			},
			{
				header:  '세탁 물품',
				name: 'laundry_product',
				align: 'center',
			},
			{
				header: '이용 지점',
				name: 'store_name',
				align: 'center',
				width: 100
			},
			{
				header: '세탁업체 위탁일',
				name: 'laundry_consign',
				align: 'center',
				width: 120
			},
			{
				header: '세탁 수거일',
				name: 'laundry_collect',
				align: 'center',
				width: 100
			},
			{
				header: '세탁 업체명',
				name: 'laundry_company',
				align: 'center',
				width: 100
			}
		],
		
		bodyHeight: 400,
		width: 'auto',
		pageOptions : {
			userClient: true,
			type: 'scroll'
		}
	});
});
</script>
</body>
</html>