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
	
	input[type="text"] {
		background: white;
		border: 1px solid #dddddd;
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
		height: 31px;
		padding: 3px;
	}
	
	.form-memdata {
		display: table-cell;
		width: 35%
	}
	
	.form-memdata>.mem-data, #mem-data-st {
		padding: 3px;
		width: 100%;
		text-align: left;
	}
	
	.form-contitle {
		display: table-cell;
		width: 15%;
		padding: 3px;
		padding-left: 30px;
	}
	
	.form-contitle>.con-title {
		padding: 3px;
		text-align: left;
		height: 4.6em;
	}
	
	.form-condata {
		display: table-cell;
		width: 35%;
	}
	
	.form-condata>.con-data {
		padding: 3px;
		text-align: left;
	}
	
	#my_convey {	/*모달창*/
        display: none;
        width: 70%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
        height: 80%;
		overflow-y: auto; /*세로 스크롤 생성*/
    }
    
    #my_convey::-webkit-scrollbar {
	    width: 10px;
	}
	
	#my_convey::-webkit-scrollbar-thumb {
	    background-color: #478FEB;
	    border-radius: 10px;
	    background-clip: padding-box;
	    border: 2px solid transparent;
	}
	#my_convey::-webkit-scrollbar-track {
	    background-color: #dddddd;
	    border-radius: 10px;
	    box-shadow: inset 0px 0px 5px white;
	}

    #my_convey .modal_close_btn {	/*모달창 닫기버튼*/
        position: absolute;
        top: 20px;
        right: 20px;
        color: #cecece;
        cursor: pointer;
    }
    
    #cancel {	/*모달 신청 취소 버튼*/
    	background: #00c0e2;
    	border-radius: 0.3em;
    	color: white;
    	padding: 8px;
    }
    
    .comment {	/*모달 내용 작은 코멘트*/
    	font-size:9pt;
    	color:#478FEB;
    	margin: 0 0 0;
    }
    
    .mo-tbl {	/*모달 테이블 내용*/
    	padding: 3px;
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
		padding: 0.4em;
    }
    
    .back-btn {
    	background-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }   
    
    .modal-body {
		border: 1px solid #cecece; 
	 	border-radius: 0.3em;
	 	width: 100%;
	 	overflow: auto;
	 	word-break: keep-all;
	}
    
    div.modal-body img {	/* Modal창 안에 표시되는 내용의 이미지 사이즈 강제 조정*/
		max-width: 80%;
		height: auto;
	}
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script>
	function alertRegi() {
		if($('#apply_start').val() == ""){
			alert("픽업 날짜를 입력하세요. 단순 출고의 경우, 출고날짜와 동일한 날짜를 선택해주세요.");
			$('#apply_start').focus();
			return false;
		}
		if($('#apply_end').val() == ""){
			alert("출고 날짜를 입력하세요.");
			$('#apply_end').focus();
			return false;
		}
		if($('#apply_addr').val() == ""){
			alert("운송 희망 주소를 입력하세요.");
			$('#apply_addr').focus();
			return false;
		}
		if($('#apply_product').val() == ""){
			alert("운송 물품 정보를 입력하세요.");
			$('#apply_product').focus();
			return false;
		}
		if($('#apply').val() == ""){
			alert("지점을 선택하세요.");
			$('#choice-btn').focus();
			return false;
		}
		
		var data = $("form[id=frm]").serialize() ;
		console.log(data);
		
		$.ajax({
			url: 'registConvey',
			type: 'POST',
			data : data,
			success : function(result) {
				alert("운송 신청이 완료되었습니다.");
				location.reload();
			},
			error : function(xhr,status, msg) {
				alert("운송 신청에 실패하였습니다.  상태값 : "+ status + "  에러메시지 : " + msg);
			}
		})
	}
</script>
</head>
<body>
	<div class="wrap">
		<div>
			<h3>물품 운송 신청 조회</h3>
		</div>
		<div class="convey-list">
			<div class="list-info">
				*신청 취소 또는 상세 보기를 원하시는 경우, 신청 내역을 더블 클릭하면 조회가 가능합니다.
			</div>
			<div id="conveyGrid" align="center"></div>
			<div id="my_convey" align="center">
			    <a class="modal_close_btn"> 
	    		<div style="border: 2px solid #cecece; border-radius:3px; width: 22px;"><b>X</b></div></a><br>
			    <div class="modal-body"></div>
		    </div>
		</div>
		<div class="convey-Reg">
			<div align="left">
				<h4>물품 운송 신청하기</h4><br>
				<p class="comment">*보관이사를 선택 하실 경우, 더욱 자세한 상담을 위해 마이스토리지에서 고객님께 연락을 드립니다.<br>
					기존 이용 고객 중 보관이사를 신청하시는 경우 보관 희망 물품의 부피에 따라 상담 후 이용 스토리지 사이즈가 변경될 수 있습니다.</p>
			</div>
			<form id="frm" action="registConvey" method="post">
				<div class="convey-form">
					<div class="form-memtitle">
						<div class="title">신청자 이름</div>
						<div class="title">이용 희망 지점</div>
						<div class="title">운송 희망 주소</div>
						<div class="title">운송 물품 정보</div>
					</div>
					<div class="form-memdata">
						<div class="mem-data">${loginName }</div>
						<div id="mem-data-st" style="height: 2.5em; line-height: 2em; text-align: left; color: #478FEB">
							아래의 지점 리스트에서 선택해주세요.</div>
						<div class="mem-data"><input type="text" id="apply_addr" name="apply_addr" value="" /></div>
						<div class="mem-data"><input type="text" id="apply_product" name="apply_product" value="" /></div>
					</div>
					<div class="form-contitle">
						<div class="con-title">픽업 희망 날짜</div>
						<div class="con-title">출고 희망 날짜</div>
						<div class="con-title">보관 이사 여부</div>
					</div>
					<div class="form-condata">
						<div class="con-data"><input type="date" id="apply_start" name="apply_start" /><br>
											<p style="color: gray; font-size: 8pt; line-height: 1.2em; margin: 0.4em 0em 0em; color: red;">
											*보관 이사 신청 시 픽업을 원하는 날짜를 선택해주세요.<br>
											 단순 출고의 경우에도 꼭! 출고날짜와 동일한 날짜를 선택해주세요.</p></div>
						<div class="con-data"><input type="date" id="apply_end" name="apply_end" /><br>
											<p style="color: gray; font-size: 8pt;">*보관 물품을 출고할 날짜를 선택해주세요.</p></div>
						<div class="con-data" style="margin-top:0.5em;"><select id="apply_whether" name="apply_whether">
							<option value="N">N</option>
							<option value="Y">Y</option>
						</select></div>
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
				</div><br><br>
				<div style="padding: 20px;">
					<input type="hidden" name="store_code" id="apply" value="" />
					<button class="btn btn-primary btn-lg" type="button" onclick="alertRegi()">신청하기</button>&nbsp;&nbsp;
					<button class="btn btn-default btn-lg" type="button" onclick="history.back()">돌아가기</button>
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
			apply_code: '${list.apply_code}',
			store_name: '${list.store_name}',
			convey_product: '${list.apply_product}',
			convey_date: '<fmt:formatDate value="${list.apply_start}" pattern="yyyy-MM-dd" />',
			archive_director:'${list.apply_whether}'
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
			name: 'apply_code',
			align: 'center',
		},
		{
			header: '이용 희망 지점',
			name: 'store_name',
			align: 'center',
		},
		{
			header:  '보관 희망 물품',
			name: 'convey_product',
			align: 'center',
		},
		{
			header: '운송 희망일',
			name: 'convey_date',
			align: 'center',
		},
		{
			header: '보관이사 여부',
			name: 'archive_director',
			align: 'center',
		}
		],
		
		bodyHeight: 300,
		width: 'auto',
		pageOptions : {
		userClient: true,
		type: 'scroll'
		}
	});
		
	//Grid 컬럼 클릭 시 모달로 견적서 조회 요청
	conveyGrid.on('dblclick', function(ev) {
		var target = ev;
		
		var myConvey = conveyGrid.getValue(ev.rowKey,'apply_code');
		console.log(myConvey);
		
		$.ajax({
			url: 'myConvey/'+myConvey,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				console.log(result);
				showConvey(result);
			},
			error: function(xhr,status, msg) {
				alert("상태값 : "+status+" Http 에러메시지 : "+msg);
			}
		})
		
		function showConvey(data) {
			modal('my_convey');

			var a_code = data.apply_code;
			var a_start = data.apply_start;
			var a_time = data.convey_time;
			var a_end = data.apply_end;
			var a_whether = data.apply_whether;
			var a_prod = data.apply_product;
			var a_use = data.use_num;
			var a_store = data.store_name;
			var a_addr = data.apply_addr;
			var c_file = data.convey_file;
			var c_after = data.convey_after;
			var c_car = data.convey_car;
			var c_driver = data.convey_driver;
			
			console.log(a_code,a_start, a_time, a_end, a_whether, a_prod, a_use, a_store, c_file);

			var title = '<h4>운송 신청 상세내역</h4>';
			
			var tbl =$('<table style="width:90%;" />');
			var row = '<tr>';
			row += '<th class="mo-tbl" style="width: 30%; padding-top: 30px;">신청코드</th>';
			row += '<td class="mo-tbl" style="width: 70%; padding-top: 30px;">' + a_code + '</td></tr>';
			row += '<tr><th class="mo-tbl" style="vertical-align:top;">픽업 희망 일자</th>';
			if(a_start == a_end){
				row += '<td class="mo-tbl"><p class="comment">*보관 이사 시 픽업되는 날짜로, 단순 출고는 해당되지 않습니다.</p></td></tr>';
			} else {
				row += '<td class="mo-tbl">' + a_start + '<br><p class="comment">*보관이사시 댁으로 방문하여 픽업하는 날짜입니다.</p></td></tr>';
			}
			if(a_time != null){
				row += '<tr><th class="mo-tbl">운송 시간</th><td class="mo-tbl">' + a_time + '</td></tr>';
			} else {
				row += '<tr><th class="mo-tbl">운송 시간</th><td class="mo-tbl">아직 상담 전입니다.</td></tr>';
			}
			row += '<tr><th class="mo-tbl" style="vertical-align:top;">픽업 희망 주소</th>';
			row += '<td class="mo-tbl">' + a_addr + '</td></tr>';
			row += '<tr><th class="mo-tbl" style="vertical-align:top;">출고 희망 일자</th>';
			row += '<td class="mo-tbl">' + a_end + '<br><p class="comment">*보관이사 또는 이용 중인 스토리지에서 물품을 출고하는 날짜입니다.</p></td></tr>';
			row += '<tr><th class="mo-tbl" style="vertical-align:top;">보관이사 여부</th>';
			row += '<td class="mo-tbl">' + a_whether + '</td></tr>';
			row += '<tr><th class="mo-tbl" style="vertical-align:top;">운송 물품 정보</th>';
			row += '<td class="mo-tbl">' + a_prod + '</td></tr>';
			if(c_car != null){
				row += '<tr><th class="mo-tbl">운송 차량</th><td class="mo-tbl">' + c_car + '</td></tr>';
			} else {
				row += '<tr><th class="mo-tbl">운송 차량</th><td class="mo-tbl">차량 배정 전입니다.</td></tr>';
			}
			if(c_driver != null){
				row += '<tr><th class="mo-tbl">운송 기사</th><td class="mo-tbl">' + c_driver + '</td></tr>';
			} else {
				row += '<tr><th class="mo-tbl">운송 기사</th><td class="mo-tbl">기사 배정 전입니다.</td></tr>';
			}
			row += '<tr><th class="mo-tbl" style="vertical-align:top;">이용 지점</th>';
			row += '<td class="mo-tbl">' + a_store + '</td></tr>';
			row += '<tr><th class="mo-tbl" style="vertical-align:top;">이용 중인 스토리지 번호</th>';
			if(a_use != null){
				row += '<td class="mo-tbl">' + a_use + '<br><p class="comment" style="line-height:1.2em; padding-bottom: 1em;">*기존에 스토리지를 이용하시는 고객의 경우,<br>이용 중인 스토리지의 번호 정보입니다.</p></td></tr>';
			} else {
				row += '<td class="mo-tbl" style="padding-bottom: 1.5em;">이용 중인 스토리지가 없습니다.</td><tr>'
			}
			row += '<tr><th class="mo-tbl" colspan="2" style="border-top:1px lightgray solid; padding: 1em 3px;">운송 처리 결과</th></tr>';
			if(c_file != null){
				row += '<tr><td colspan="2">' + c_file + '</td></tr>';
			} else {
				row += '<tr><td style="padding: 1em 2em;" colspan="2"><b>아직 운송 결과가 업데이트 되지 않았습니다.</b></td></tr>'
			}
			row += '<tr><td class="mo-tbl" colspan="2"><font style="color: red; font-size: 9pt; line-height: 1.3em; font-weight: bold;">[안내]&nbsp;</font>'
				+ '<font style="color: gray; font-size: 9pt; line-height: 1.3em;">접수 된 신청건은 세부 일정 조율과 상담을 위해 물품 운송팀에서 확인 후,<br>'
			+'고객님께 직접 연락을 드립니다. 만일 취소나 변경사항이 생길 경우 고객센터로 문의주시면<br>신속하게 처리를 도와드립니다.</font></td></tr>';
			
			tbl.append(row);
			
			$(".modal-body").append(title);
			$(".modal-body").append(tbl);
		}

	});	// Modal로 견적서 상세 보기 요청 끝
		
		// Modal 세부 함수			
		function modal(id) {
		    var zIndex = 9999;
		    var modal = document.getElementById(id);
	
		    // 모달 div 뒤에 희끄무레한 레이어
		    var bg = document.createElement('div');
		    bg.setStyle({
		        position: 'fixed',
		        zIndex: zIndex,
		        left: '0px',
		        top: '0px',
		        width: '100%',
		        height: '100%',
		        overflow: 'auto',
		        // 레이어 색갈은 여기서 바꾸면 됨
		        backgroundColor: 'rgba(0,0,0,0.4)'
		    });
		    document.body.append(bg);
	
		    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
		    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
		        bg.remove();
		        $('.modal-body').empty();
		        modal.style.display = 'none';
		    });
	
		    modal.setStyle({
		        position: 'fixed',
		        display: 'block',
		        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
	
		        // 시꺼먼 레이어 보다 한칸 위에 보이기
		        zIndex: zIndex + 1,
	
		        // div center 정렬
		        top: '50%',
		        left: '50%',
		        transform: 'translate(-50%, -50%)',
		        msTransform: 'translate(-50%, -50%)',
		        webkitTransform: 'translate(-50%, -50%)'
		    });
		}
	
		// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
		Element.prototype.setStyle = function(styles) {
		    for (var k in styles) this.style[k] = styles[k];
		    return this;
		};
})
</script>
<!-- 지도API - 고유key -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3a66ba8e60100e68a1df7756407ad0bb&libraries=services"></script>
<script>
	// TOAST GRID로 먼저 지점 리스트를 불러온 후, 클릭 시 웹사이트 화면 아래의 지도가 바뀌도록 구현
	// KakaoMap
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(35.869095969748685, 128.593397346246667), // 지도의 중심좌표 (default 값)
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
		 			
		 			let sName = document.getElementById('mem-data-st');
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
</body>
</html>