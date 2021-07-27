<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<!-- 이유는 모르겠는데 아래 5줄의 css, js 가져오는 것들 순서 바뀌면 Grid 작동 제대로 안해요 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>

</head>
<body>
	<div align="center">
		<!-- 지점명, 지점주소 - TOAST GRID / 무한스크롤, 클릭 시 지도 위치 변경되도록, 지점명 및 주소 검색 가능하도록 filter 추가 -->
		<div id="grid" style="width:800px;height:400px;"></div>
		
		<!-- 지도API / 필요 시 나중에 default 위도 경도 변경 가능 -->
		<div id="map" style="width:800px;height:400px;"></div>
	</div>
	
	<!-- 지도API - 고유key -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3a66ba8e60100e68a1df7756407ad0bb&libraries=services"></script>

	<script>
		// TOAST GRID로 먼저 지점 리스트를 불러온 후, 클릭 시 웹사이트 화면 아래의 지도가 바뀌도록 구현
	
		// KakaoMap
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표 (default 값)
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		$.ajax({
			url:'storeAddr',
			dataType:'json',
			success:function(data){
				// TOAST GRID
				const recruitGrid = new tui.Grid({
					el: document.getElementById('grid'), 
					data: data,
					columns: [ 
						{ 
							header: '지점명', 
							name: 'store_name', 
							align: 'center',
							width: 200,
							filter: 'select'
						}, 
						{ 
							header: '주소', 
							name: 'store_addr', 
							align: 'center',
							filter: 'select'
						} 
					],
					
					// 무한 스크롤 - BodyHeight 보이는 것보다 조금 더 많은 양의 perPage로 잘라야 스크롤이 생겨서 그때부터 적용됨. 그냥 페이징처리할땐 BodyHeight 필요없을듯
					bodyHeight: 200,
					pageOptions: {
						// 무한 스크롤 혹은 페이징 처리 시 기능 사용한다는 옵션
						useClient: true,
					    // 무한스크롤 옵션 
					    type: 'scroll'
					}
				});
				
				// GRID 클릭 시
				recruitGrid.on('click', function(ev) {
					var target = ev
					// 클릭 시 console에 지점 주소 출력
					var contents = recruitGrid.getValue(ev.rowKey,'store_addr');
					console.log(contents);
				  
				 	// 주소로 좌표를 검색합니다
					geocoder.addressSearch(contents, function(result, status) {
					
					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {
					
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        var marker = new kakao.maps.Marker({
					            map: map,
					            position: coords
					        });
					
					        // 인포윈도우로 장소에 대한 설명을 표시합니다
					        var infowindow = new kakao.maps.InfoWindow({
					        	// 지도 마커에 적힌 내용 수정하는 곳
					            content: '<div style="width:150px;text-align:center;padding:6px 0;">지점 위치</div>'	
					        });
					        infowindow.open(map, marker);
					
					        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					        map.setCenter(coords);
					    } 
					}); 
				  
				});
				
			}, // success 닫힘
			error: function(err){
				console.log(err);
			}
		})
		
		
		   
	</script>
	<br>
</body>
</html>