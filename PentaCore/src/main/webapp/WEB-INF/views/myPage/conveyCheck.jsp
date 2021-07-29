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
		}
		
	.convey-list {
		padding: 30px 50px;
	}
	
	.convey-Reg {
		padding: 30px 50px;
	}	
	
	.list-info {
		text-align: right;
		color: gray;
	}
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
	<div class="wrap">
		<div>
			<h3>물품 운송 신청 조회</h3>
		</div>
		<div class="convey-list">
			<div class="list-info">
				*상세보기를 원하시는 경우, 신청내역을 더블클릭하면 조회가 가능합니다.
			</div>
			<div id="conveyGrid" align="center"></div>
		</div>
		<div class="convey-Reg">
			<div align="left">
				<h4>물품 운송 신청하기</h4>
			</div>
			<form id="frm" action="" method="post">
				<div>
					<input type="text" id="member_name" name="name" value=""/>
					<input type="text" id="member_tel" name="tel" value="" />
					<input type="text" id="apply_addr" name="apply_addr" />
					<input type="text" id="apply_product" name="apply_product" />
				</div>
				<div>
					<input type="date" id="apply_start" name="apply_start" />
					<input type="date" id="apply_end" name="apply_end" />
					<select id="apply_whether" name="apply_whether">
						<option value="N">N</option>
						<option value="Y">Y</option>
					</select>
				</div>
			</form>
		</div>
	</div>
<script>
// 운송 신청 내역 그리드 생성
$(document).ready(function() {
	var list = '<c:out value="${conveyListAll}"/>';
	
	const Grid = tui.Grid;
	
	const conveyData = [
		<c:forEach items="${conveyListAll}" var="list" varStatus="status">
		{
			con_code: '${list.convey_code}',
			store_name: '${list.store_name}',
			convey_product: '${list.apply_product}',
			convey_date: '<fmt:formatDate value="${list.apply_start}" pattern="yyyy-MM-dd" />',
			storage_code:'${list.info_num}'
		}
			<c:if test="${not status.last}">,</c:if>
			</c:forEach>
		]
		
		console.log(conveyData);
		
		const conveyGrid = new Grid({
		el : document.getElementById('conveyGrid'),
		data: conveyData,
		columns : [
		{
			header: '신청코드',
			name: 'con_code',
			align: 'center',
			width: 100
		},
		{
			header: '이용 지점',
			name: 'store_name',
			align: 'center',
			width: 100
		},
		{
			header:  '보관 희망 물품',
			name: 'convey_product',
			align: 'center',
			width: 430
		},
		{
			header: '운송희망일',
			name: 'convey_date',
			align: 'center',
			width: 100
		},
		{
			header: '스토리지 번호',
			name: 'storage_code',
			align: 'center',
			width: 113
		}
		],
		
		bodyHeight: 300,
		width: 'auto',
		pageOptions : {
		userClient: true,
		type: 'scroll'
		}
	});
})
</script>
</body>
</html>