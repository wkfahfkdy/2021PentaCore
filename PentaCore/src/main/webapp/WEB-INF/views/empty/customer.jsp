<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8"> 	
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
	<div>
		<h3>물품 운송 신청 조회</h3>
	</div>

	<div class="convey-list">
		<div class="list-info">
		* 더블클릭으로 추가정보를 입력해주세요.
		</div>
		<div id="customerGrid" align="center"></div>
		<div id="customer" align="center">
		    <a class="modal_close_btn">닫기</a>
		    <div class="modal-body"></div>
	    </div>
	</div>
      
    <script type="text/javascript">
    
    $(document).ready(function(){
    	var list = '<c:out value="${customerListAll}"/>'
    	
    	const Grid = tui.Grid;

    	const customerData = [
    		<c:forEach items="${customerListAll}" var="list" varStatus="status">
    		{
    			member_id: '${list.member_id}',
    			apply_addr: '${list.apply_addr}',
    			apply_end: '<fmt:formatDate value="${list.apply_end}" pattern="yyyy-MM-dd" />',
    			store_code: '${store_code}'
    		}
    			<c:if test="${not status.last}">,</c:if>
    			</c:forEach>
    		]
    		
    		console.log(customerData);
    		
    		const customerGrid = new Grid({
    		el : document.getElementById('customerGrid'),
    		data: customerData,
    		columns : [
    		{
    			header: '신청자명',
    			name: 'member_id',
    			align: 'center'
    		},
    		{
    			header: '현재주소',
    			name: 'apply_addr',
    			align: 'center'
    		},
    		{
    			header:  '날짜',
    			name: 'apply_end',
    			align: 'center'
    		},
    		{
    			header: '희망지점',
    			name: 'store_code',
    			align: 'center'
    		}
    		],
    		
   	     	rowHeaders: ['rowNum'],
   	      	pageOptions: {
    		pageOptions : {
		    useClient: true,
    		perPage: 5
    		}
    	});
    }
</script>
</body>
</html>