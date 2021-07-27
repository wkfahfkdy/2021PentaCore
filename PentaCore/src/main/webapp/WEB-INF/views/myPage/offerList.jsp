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
	}
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script>
	$(document).ready(function() {
		var list = '<c:out value="${list}"/>';
		
		const Grid = tui.Grid;
		
		const offerData = [
						<c:forEach items="${offerSelectList}" var="list" varStatus="status">
						{
							offer_code: '${list.offer_code}',
							offer_product: '${list.offer_product}',
							store_name: '${list.store_name}',
							offer_pay:'${list.offer_pay}'
						}
						<c:if test="${not status.last}">,</c:if>
						</c:foreach>
					]
		const offerGrid = new Grid({
			el : document.getElementById('offerGrid'),
			columns : [{
				
			}]
		})
	})
</script>
</head>
<body>
	<div class="wrap">
		<div>
			<h3>견적서 내역 조회</h3>
		</div>
		<div id="offerGrid"></div>
	</div>
</body>
</html>