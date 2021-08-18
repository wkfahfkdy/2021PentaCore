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
<script>
	function alertRegi() {
		if($('#tour_date').val() == ""){
			alert("투어 일자를 입력하세요.");
			$('#tour_date').focus();
			return false;
		}
		if($('#apply').attr('value') == ""){
			alert("투어 희망 지점을 선택해주세요.");
			return false;
		}
		var data = $("form[id=frm]").serialize() ;
		console.log(data);
		
		$.ajax({
			url: 'registTour',
			type: 'POST',
			data : data,
			success : function(result) {
				alert("투어 신청이 완료되었습니다.");
				location.reload();
			},
			error : function(xhr,status, msg) {
				alert("투어 신청에 실패하였습니다.  상태값 : "+ status + "  에러메시지 : " + msg);
			}
		})
	}
</script>
</head>
<body>
	<div class="wrap">
		<div>
			<h3>지점 투어 신청 내역 조회</h3>
		</div>
		<div class="tour-list">
			<div align="right" style="margin-bottom: 1em; color: #478FEB;">
				*투어를 취소하실 일정의 투어취소 여부를 더블 클릭하신 뒤 선택 후, 옆의 취소 버튼을 눌러주시면 취소처리가 완료됩니다.&nbsp;&nbsp;
				<button id="cancel-btn">투어취소</button>
			</div>
			<div id="tourGrid" align="center"></div>
		</div>
		<div class="tour-Reg">
			<div align="left">
				<h4>지점 투어 신청하기</h4><br>
				<p class="comment">*투어를 희망하시는 지점과 날짜, 시간을 선택해 신청해주시면, 지점 매니저가 확인 후 연락을 드립니다.</p>
			</div>
			<form id="frm" action="registConvey" method="post">
				<div class="convey-form">
					<div class="form-memtitle">
						<div class="title">신청자 이름</div>
						<div class="title">신청자 연락처</div>
					</div>
					<div class="form-memdata">
						<div class="mem-data">${loginName }</div>
						<div class="mem-data">${loginTel }
									<input type="hidden" id="tour_tel" name="tour_tel" value="${loginTel }" /></div>
					</div>
					<div class="form-tourtitle">
						<div class="tour-title">투어 희망 날짜</div>
						<div class="tour-title">투어 희망 시간</div>
						<div class="tour-title">투어 희망 지점</div>
					</div>
					<div class="form-tourdata">
						<div class="tour-data"><input type="date" id="tour_date" name="tour_date" /></div>
						<div class="tour-data"><select id="tour_time" name="tour_time">
								<option value="AM 11:00 ~ 12:00">AM 11:00 ~ 12:00</option>
								<option value="PM 12:00 ~ 13:00">PM 12:00 ~ 13:00</option>
								<option value="PM 13:00 ~ 14:00">PM 13:00 ~ 14:00</option>
								<option value="PM 14:00 ~ 15:00">PM 14:00 ~ 15:00</option>
								<option value="PM 15:00 ~ 16:00">PM 15:00 ~ 16:00</option>
								<option value="PM 16:00 ~ 17:00">PM 16:00 ~ 17:00</option>
								<option value="PM 17:00 ~ 18:00">PM 17:00 ~ 18:00</option>
								<option value="PM 18:00 ~ 19:00">PM 18:00 ~ 19:00</option>
								<option value="PM 19:00 ~ 20:00">PM 19:00 ~ 20:00</option>
							</select></div>
						<div id="tour-data-st" style="text-align: left; height: 1em; color: #478FEB;">아래의 지점 리스트에서 선택해주세요.</div>
						<div class="tour-data" style="text-align: left; color: red; font-size: 9pt; margin: 0.8em 0em 0.4em;">
										*투어를 희망하는 지점을 아래에서 선택하시면,<br>선택 된 신청 지점 이름이 나타납니다.</div>
					</div>
				</div>
				<div class="store-pick">
					<div class="store-list">
						<h4 id= "choice-store" align="left" style="margin-top:10px; margin-bottom:6px;">지점 리스트&nbsp;&nbsp;&nbsp;
						<button type="button" id="choice-btn" style="font-size: 9pt; font-weight: normal;">지점선택</button>
						</h4>
						<div id="storeGrid"></div>
					</div>
					<div class="store-mAp">
						<h4 align="left">지점 지도</h4>
						<div id="map" style="width:100%;height:400px;"></div>
					</div>
				</div>
				<div style="margin-top:20px; padding: 20px;">
					<input type="hidden" name="store_code" id="apply" value="" />
					<button class="btn btn-primary btn-lg" type="button" onclick="alertRegi()">신청하기</button>&nbsp;&nbsp;
					<button class="btn btn-default btn-lg" type="button" onclick="history.back()">돌아가기</button>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
$(document).ready(function() {
	var list = '<c:out value="${storeTourListAll}"/>';
	
	const Grid = tui.Grid;
	
	const tourData = [
		<c:forEach items="${storeTourListAll}" var="list" varStatus="status">
		{
			tour_code: '${list.tour_code}',
			store_name: '${list.store_name}',
			tour_date: '<fmt:formatDate value="${list.tour_date}" pattern="yyyy-MM-dd" />',
			tour_time:'${list.tour_time}',
			tour_complete: '${list.tour_complete}',
			tour_cancel: '${list.tour_cancel}'
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
					url: 'tourCancel',	// 업데이트가 실행 될 controller url
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
				header: '투어 신청 확정 여부',
				name: 'tour_complete',
				align: 'center',
			},
			{
				header: '투어 취소',
				name: 'tour_cancel',
				formatter: 'listItemText',
				align: 'center',
				editor: {
					type: 'select',
					options: {
						listItems: [
							{
								text: '선택 안함',
								value: 'N'
							},
							{
								text: '투어 취소',
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
	
	document.getElementById('cancel-btn').addEventListener('click', cancelTour);	// 투어 취소 버튼을 누를 때 취소 함수 실행

	function cancelTour() {
		const { rowKey, columnName } = tourGrid.getFocusedCell();
		
		if(rowKey && columnName){
			tourGrid.finishEditing(rowKey, columnName);
		}
		
		tourGrid.request('updateData', {
			//checkedOnly: false 
			// 이딴 놈은 있으면 귀찮음. 굉장히 귀찮음. 커서가 다른데 가야 뭐가 됨
		});
		alert('신청이 취소되었습니다.');
		location.reload();
	}
	
	// 업데이트 실행 이벤트
	tourGrid.on('response', ev => {
		var {response} = ev.xhr;
		var responseObj = JSON.parse(response);
		
		console.log('result : ', responseObj.result);
		console.log('data : ', responseObj.data);
	});
})
</script>
<!-- 지도API - 고유key -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3a66ba8e60100e68a1df7756407ad0bb&libraries=services"></script>
<script>
	// TOAST GRID로 먼저 지점 리스트를 불러온 후, 클릭 시 웹사이트 화면 아래의 지도가 바뀌도록 구현
	// KakaoMap
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(35.869095969748685, 128.59339734624666), // 지도의 중심좌표 (default 값)
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	var iwContent2 = '<div style="padding:5px; text-align:center; width:145px;">Yedam</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition2 = new kakao.maps.LatLng(35.869095969748685, 128.59339734624666), //인포윈도우 표시 위치입니다
    iwRemoveable2 = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

	// 인포윈도우를 생성하고 지도에 표시합니다
	var infowindow2 = new kakao.maps.InfoWindow({
	    map: map, // 인포윈도우가 표시될 지도
	    position : iwPosition2, 
	    content : iwContent2,
	    removable : iwRemoveable2
	});
	
	$.ajax({
		url:'storeInfo',
		dataType:'json',
		success:function(data){
			// TOAST GRID
			
			const recruitGrid = new tui.Grid({
				el: document.getElementById('storeGrid'), 
				data: data,
				columns: [ 
					{ 
						header: '지점명', 
						name: 'store_name', 
						align: 'center',
						width: 90,
						filter: 'select'
					}, 
					{ 
						header: '지점코드', 
						name: 'store_code', 
						align: 'center',
						width: 80,
						filter: 'select'
					},
					{ 
						header: '주소', 
						name: 'store_addr', 
						align: 'center',
						filter: 'select'
					} 
				],
				
				// 무한 스크롤 - 그냥 페이징처리할땐 BodyHeight 필요없음
				bodyHeight: 357,
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
				var s_code = recruitGrid.getValue(ev.rowKey,'store_code');
				var s_name = "";
				//console.log(contents);
				
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
			 	//지점 선택 버튼을 클릭시 선택된 지점의 주소값을 input hidden의 value로 추가
			 	$('#choice-btn').on('click', function() {
			 		console.log($('#apply').attr('value'));
		 			$("#apply").attr('value',s_code);
		 			
		 			let sName = document.getElementById('tour-data-st');
		 			console.log(sName.innerHTML);
		 			
		 			if(sName.innerHTML != null) {
		 				sName.innerHTML = '';
		 				s_name= recruitGrid.getValue(ev.rowKey,'store_name');
		 				sName.innerHTML = s_name;
		 			}
		 			
		 			console.log(sName.innerHTML);
		 			console.log($('#apply').attr('value'));
				})
			  
			});
			
		}, // success 닫힘
		error: function(err){
			console.log(err);
		}
	})
</script>
</html>