<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		padding: 7% 7%;
	}	
	
	.list-info {
		text-align: right;
		color: gray;
	}
	
	input[type="text"] {
		background: white;
		border: 1px solid #ADADAD;
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
		padding: 2px; 
		line-height: 2.5em;
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
        width: 50%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #my_convey .modal_close_btn {	/*모달창 닫기버튼*/
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    #cancel {	/*모달 신청 취소 버튼*/
    	background: #00c0e2;
    	border-radius: 0.3em;
    	color: white;
    	padding: 8px;
    }
    
    
    .mo-tbl {	/*모달 테이블 내용*/
    	padding: 3px;
    }
    
    .store-pick {
    	display: table;
    	width: 100%;
    	padding-top: 3%;
    }
    
    .store-list {
    	display: table-cell;
    	width: 45%;
    }
    
    .store-mAp {
    	display: table-cell;
    	width: 55%;
    }
    
    #choice-btn {
    	background-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
    
    
    
    /* 따라다니는 아이콘 */	
	.quickmenu {
		position : absolute;
		width : 90px;
		top : 50%;
		margin-top : -270px;
		right : 80px;
		}
		
    
</style>
<!-- 지점list grid -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script>

	// 로그인체크 후 보관이사신청
	function alertRegi(check) {

    	if (check == "no") {
        	var check = confirm("LOGIN 후 사용가능합니다!")
        	if (check == true) {
        		location.href = "memberLoginForm";
        	} else {
        		return false;
        	}
    	} else {
    		
    		if($('#apply_end').val() == ""){
    			alert("희망일을 선택해주세요.");
    			$('#apply_end').focus();
    			return false;
    		}
    		
    		if($('#apply').val() == ""){
    			alert("희망지점을 선택해주세요.");
    			$('#apply_end').focus();
    			return false;
    		}
    		
    		var data = $("form[id=frm]").serialize() ;
    		console.log(data);
    		
    		$.ajax({
    			url: 'keepInsert',
    			type: 'POST',
    			data : data,
    			success : function(result) {
    				alert("보관이사 신청이 완료되었습니다!");
    				location.reload();
    			},
    			error : function(xhr,status, msg) {
    				alert("보관이사 신청에 실패하였습니다.  상태값 : "+ status + "  에러메시지 : " + msg);
    			}
    		})
    		
    	}
	}
	
	// 따라다니는 아이콘
	$(document).ready(function(){ 
		var currentPosition = parseInt($(".quickmenu").css("top")); 
		$(window).scroll(function() { var position = $(window).scrollTop(); 
			$(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000); 
		}); 
	});

	
</script>
</head>
<body>
		<div>
			<img style="width: 100%" src="${pageContext.request.contextPath }/resources/img/moving.jpg">
		</div>
		
		<div class="wrap">
		<!-- 서비스소개 및 QnA -->
		<div class="scrollBtn"> 
			<div class="quickmenu"> 
			<button type="button"> <a href="#scrollDiv" >
				<img  style="z-index: 99;" src="${pageContext.request.contextPath }/resources/img/icon.png"> </a></button>
			</div>
		</div>
		<div align="center" style="padding-top: 5%;">
			<h4>MY STORAGE 안심보관이사</h4>
			<h1><b>어떤 서비스인가요?</b></h1> <br>
			<h5>안심보관이사란 다락만의 IoT기술을 기반으로 </h5>
			<h5>항온항습 및 100% 살균 보관 환경에서 고객님의 이삿짐을 케어해드리는 프리미엄 서비스입니다.</h5>
		</div> <br><br>
		
		<div align="center">
			<img src="${pageContext.request.contextPath }/resources/img/keep1.jpg">
		</div>
		</div>
	
		<div style="padding-top: 3%;">
			<img style="width: 100%" src="${pageContext.request.contextPath }/resources/img/keep2.png"> 
			<img style="width: 100%" src="${pageContext.request.contextPath }/resources/img/keep3.png"> 
		</div> 
	
		<!-- 보관이사신청 입력폼 -->
		<div class="convey-Reg" id="scrollDiv">
			<div align="left">
				<h4>보관이사 신청</h4><br>
				<p style="color:#478FEB; ">*더욱 자세한 상담을 위해 마이스토리지에서 고객님께 연락을 드립니다.</p>
			</div>
			<form id="frm" action="keepInsert" method="post">
				<div class="convey-form">
					<div class="form-memtitle">
						<div class="title">신청자 이름</div>
						<div class="title">전화번호</div>
						<div class="title">이용 희망 지점</div>
					</div>
					<div class="form-memdata">
						<div class="mem-data"><input type="text" id="apply_id" name="apply_id" value="${loginName }" /></div>
						<div class="mem-data" style="line-height: 2.5em;"><input type="text" id="apply_tel" name="apply_tel" value="${loginTel }" /></div>
						<div id="mem-data-st" style="height: 2.5em; line-height: 3em; text-align: left; color: #478FEB">
												아래의 지점 리스트에서 선택해주세요.</div>
					</div>
					<div class="form-memtitle">
						<div class="title">현재 주소</div>
						<div class="title">이사규모</div>
						<div class="title">운송 희망일</div>
					</div>
					<div class="form-memdata">
						<div class="mem-data" style="line-height: 2.5em;"><input type="text" id="apply_addr" name="apply_addr" value="${loginAddr }" /></div>
						<div class="mem-data" ><input type="text" id="apply_product" name="apply_product" value="ex) 원룸, 아파트21평 ..." onfocus="this.value=''"/></div>
						<div class="mem-data" style="padding-top: 0.7em;"><input type="date" id="apply_end" name="apply_end" /><br> </div>
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
						<div id="map" style="width:100%;height:400px;z-index: -99;"></div>
					</div>
				</div>
				<div align="center" style="padding-top:3%;">
					<input type="hidden" name="store_code" id="apply" value="" />
					<button class="btn btn-primary btn-lg" type="button" onclick="alertRegi('${chk}')">신청하기</button>&nbsp;&nbsp;&nbsp;
					<button class="btn btn-default btn-lg" type="button" onclick="history.back()">뒤로가기</button>
				</div>
			</form>
		</div>
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