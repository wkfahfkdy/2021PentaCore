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
			padding: 50px 10px;
			width: 90%;
		}
		
	.tour-list {
		padding: 30px 50px;
		
	}
	
	.tour-Reg {
		padding: 30px 50px;
	}	
	
	input[type="text"] {
		background: white;
		border: 1px solid #5fd3e8;
		border-radius: 0.3em;
		width: 100%;
		height: 25px;
		padding: 5px;
	}
	
	.convey-form {
		display: table;
		border-top: 2px lightgray solid;
		padding-top: 20px;
		width: 100%;
		
	}
	
	.form-memtitle {
		display: table-cell;
		width: 15%;
		padding: 3px;
		padding-left: 30px;
	}
	
	.form-memtitle>.title {
		text-align: left;
		width: 100%;
		padding: 3px;
		height: 2em;
	}
	
	.form-memdata {
		display: table-cell;
		width: 35%
	}
	
	.form-memdata>.mem-data {
		padding: 3px;
		width: 100%;
		text-align: left;
	}
	
	.form-tourtitle {
		display: table-cell;
		width: 15%;
		padding: 3px;
		padding-left: 30px;
	}
	
	.form-tourtitle>.tour-title {
		padding: 3px;
		text-align: left;
		height: 2em;
	}
	
	.form-tourdata {
		display: table-cell;
		width: 35%;
	}
	
	.form-tourdata>.tour-data {
		padding: 3px;
		text-align: left;
		height: 2.3em;
	}
	
    .store-pick {
    	display: table;
    	width: 100%;
    }
    
    .store-list {
    	display: table-cell;
    	width: 45%;
    }
    
    .store-mAp {
    	display: table-cell;
    	width: 55%;
    }
    
    #choice-btn, .apply-btn {
    	background-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		padding: 0.4em;
    }
    
    #cancel-btn {
  	  background-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 9pt;
		font-weight: bold;
		padding: 0.4em;
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
			<h3>지점 투어 신청 내역 조회</h3>
		</div>
		<div class="tour-list">
			<div align="right" style="margin-bottom: 1em; color: #478FEB;">	
				<button id="cancel-btn">확인</button>
				&nbsp;&nbsp;*승인상태 변경 후 클릭
			</div>
			<div id="tourGrid" align="center"></div>
		</div>
		
	</div>
</body>
<script>
$(document).ready(function() {
	var list = '<c:out value="${storeTourList}"/>';
	
	const Grid = tui.Grid;
	
	const tourData = [
		<c:forEach items="${storeTourList}" var="list" varStatus="status">
		{
			tour_code: '${list.tour_code}',
			member_name: '${list.member_name}',
			store_name: '${list.store_name}',
			tour_date: '<fmt:formatDate value="${list.tour_date}" pattern="yyyy-MM-dd" />',
			tour_time:'${list.tour_time}',
			tour_complete: '${list.tour_complete}'
		}
			<c:if test="${not status.last}">,</c:if>
			</c:forEach>
		]
		
		console.log(tourData);
	
	// Grid API-source
	const dataSource = {
			withCredentials: false,
			initialRequest: false,
			contentType: 'application/json',
			api: {
				readData: {},
				updateData: {
					url: 'store/tourChange',	// 업데이트가 실행 될 controller url
					method: 'PUT'
				}
			}
	};
	
	const tourGrid = new Grid({
		el : document.getElementById('tourGrid'),
		data: dataSource,
		//rowHeaders: ['checkbox'],
		columns : [
			{
				header: '신청코드',
				name: 'tour_code',
				align: 'center',
			},
			{
				header: '신청인',
				name: 'member_name',
				align: 'center',
			},
			{
				header: '투어 희망 지점',
				name: 'store_name',
				align: 'center',
			},
			{
				header:  '투어 희망 날짜',
				name: 'tour_date',
				align: 'center',
			},
			{
				header: '투어 희망 시간',
				name: 'tour_time',
				align: 'center',
			},
			{
				header: '투어 확정',
				name: 'tour_complete',
				formatter: 'listItemText',
				align: 'center',
				editor: {
					type: 'select',
					options: {
						listItems: [
							{
								text: 'N',
								value: 'N'
							},
							{
								text: 'Y',
								value: 'Y'
							},
						]
					}
				}
			}
		],
		
		bodyHeight: 300,
		width: 'auto',
		pageOptions : {
		userClient: true,
		type: 'scroll'
		}
	});	// Grid End
	
	tourGrid.resetData(tourData);	// (기존의 dataSource -> tourData로 data 새로 세팅)
	
	document.getElementById('cancel-btn').addEventListener('click', updateTour);	// 투어 취소 버튼을 누를 때 취소 함수 실행

	function updateTour() {
		const { rowKey, columnName } = tourGrid.getFocusedCell();
		
		if(rowKey && columnName){
			tourGrid.finishEditing(rowKey, columnName);
		}
		
		tourGrid.request('updateData', {
			//checkedOnly: false 
			// 이딴 놈은 있으면 귀찮음. 굉장히 귀찮음. 커서가 다른데 가야 뭐가 됨
		});
		alert('정보가 수정 되었습니다.');
		location.reload();
	}
	
	// 업데이트 실행 이벤트
	/* tourGrid.on('response', ev => {
		var {response} = ev.xhr;
		var responseObj = JSON.parse(response);
		
		console.log('result : ', responseObj.result);
		console.log('data : ', responseObj.data);
	}); */
})
</script>
</html>
