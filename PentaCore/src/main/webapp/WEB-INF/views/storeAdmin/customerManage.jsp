<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 이유는 모르겠는데 아래 5줄의 css, js 가져오는 것들 순서 바뀌면 Grid 작동 제대로 안해요 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>

<!-- private String num;
	private String use_num;
	private Date use_start;
	private Date use_end;
	private String info_num;
	private String store_code;
	private String offer_code;
	private String member_id;
	private String member_name;
	 -->

</head>
<body>

	
<script>
//스토리지 이용중인 고객
$.ajax({
	url:'usingList',	// HomeController > 나중에 위치 변경
	dataType:'json',
	success:function(data){
		// TOAST GRID
		const recruitGrid = new tui.Grid({
			el: document.getElementById('grid'), 
			data: data,
			columns: [ 
				{ 
					header: 'NO.', 
					name: 'num', 
					align: 'center',
					width: 200,
					filter: 'select'
				}, 
				{ 
					header: 'NAME', 
					name: 'member_name', 
					align: 'center',
					filter: 'select'
				},
				{ 
					header: '스토리지 지정상태', 
					name: 'info_num', 
					align: 'center',
					filter: 'select'
				} 
			],
			//페이징처리
			pagination: true,
			
			// 무한 스크롤 - 그냥 페이징처리할땐 BodyHeight 필요없음
			//bodyHeight: 200,
			pageOptions: {
				// 무한 스크롤 혹은 페이징 처리 시 기능 사용한다는 옵션
				useClient: true,
				perPage: 4
			    // 무한스크롤 옵션 
			    //type: 'scroll'
			}
		});
		
		recruitGrid
		.on(
				'dblclick',
				function(ev) {
					var target = ev
					// 클릭 시 console에 사용자 출력
					var contents = recruitGrid.getValue(ev.rowKey,
							'use_num');
					console.log(contents);

					frm.use_num.value = contents;
					console.log(frm.use_num.value);
					
					frm.submit();

				});
		
		}, // success 닫힘
	error: function(err){
		console.log(err);
	}
});

</script>


<script>
//스토리지 이용만료 고객
$.ajax({
	url:'expiredList',	// HomeController > 나중에 위치 변경
	dataType:'json',
	success:function(data){
		// TOAST GRID
		const recruitGrid = new tui.Grid({
			el: document.getElementById('grid2'), 
			data: data,
			columns: [ 
				{ 
					header: 'NO.', 
					name: 'num', 
					align: 'center',
					width: 200,
					filter: 'select'
				}, 
				{ 
					header: 'NAME', 
					name: 'member_name', 
					align: 'center',
					filter: 'select'
				},
				{ 
					header: '스토리지 지정상태', 
					name: 'info_num', 
					align: 'center',
					filter: 'select'
				} 
			],
			//페이징처리
			pagination: true,
			
			// 무한 스크롤 - 그냥 페이징처리할땐 BodyHeight 필요없음
			//bodyHeight: 200,
			pageOptions: {
				// 무한 스크롤 혹은 페이징 처리 시 기능 사용한다는 옵션
				useClient: true,
				perPage: 4
			    // 무한스크롤 옵션 
			    //type: 'scroll'
			}
		});
	
		recruitGrid
		.on(
				'dblclick',
				function(ev) {
					var target = ev
					// 클릭 시 console에 사용자 출력
					var contents = recruitGrid.getValue(ev.rowKey,
							'use_num');
					console.log(contents);

					frm.use_num.value = contents;
					console.log(frm.use_num.value);
					
					frm.submit();

				});
		
		}, // success 닫힘
	error: function(err){
		console.log(err);
	}
});

	</script>


	<div class="title-group" style="margin-top: 70px; align:center;">
		
		<div class="subtitle with-square"><h5>이용중인 고객 리스트</h5></div>
		
		<form id="frm" name="frm"  action="storageUserDetail">
		<input type="hidden" id="use_num" name="use_num">
		<div class="bs-example" style="align:center; width: 60%; height:20%; margin-left: 20%; text-align: left;">
		<!-- 지점명, 지점주소 - TOAST GRID / 무한스크롤, 클릭 시 지도 위치 변경되도록, 지점명 및 주소 검색 가능하도록 filter 추가 -->
		<div id="grid" style="width:100%;height:50%;"></div>
		</div>
		</form>
		
		<form id="frm2" name="frm2"  action="storageUserDetail">
		<div class="subtitle with-square"><h5>사용종료 고객 리스트</h5></div>
		<div class="bs-example" style="align:center; width: 60%; height:20%; margin-left: 20%; text-align: left;">
		<!-- 지점명, 지점주소 - TOAST GRID / 무한스크롤, 클릭 시 지도 위치 변경되도록, 지점명 및 주소 검색 가능하도록 filter 추가 -->
		<div id="grid2" style="width:100;height:50%;"></div>
		</div>
		</form>
		</div>
	
	
	

</body>
</html>