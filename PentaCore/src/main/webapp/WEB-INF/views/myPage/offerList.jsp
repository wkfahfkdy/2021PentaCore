<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	a {
		color: #478FEB;
	}
	.wrap {
		margin: auto;
		text-align: center;
		padding: 50px 30px;
	}
	
	#my_offer {
        display: none;
        width: 60%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
        height: 80%;
		overflow-y: auto; /*세로 스크롤 생성*/
    }

    #my_offer .modal_close_btn {
        position: absolute;
        top: 20px;
        right: 20px;
        cursor: pointer;
        color: #cecece;
    }
    
    #my_offer .modal-body{
    	font-size: 10pt;
    }
    
    .modal-header {
    	border: none;
    }
    
     #my_offer::-webkit-scrollbar {
	    width: 10px;
	  }

	 #my_offer::-webkit-scrollbar-thumb {
	    background-color: #478FEB;
	    border-radius: 10px;
	    background-clip: padding-box;
	    border: 2px solid transparent;
	  }
	  #my_offer::-webkit-scrollbar-track {
	    background-color: #dddddd;
	    border-radius: 10px;
	    box-shadow: inset 0px 0px 5px white;
	  }
	  
	  .modal-footer {
		margin-bottom: 2em; 
	  }
    
    .back-btn {
    	background-color: #478FEB;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		padding: 0.4em;
    }   
    
    .offer-row {
    	width: 70%;
    	height: 2em;
    }
    
    .store-row {
    	width: 40%;
		height: 1em; 
		text-align: left;  
		padding: 0em 1em; 
    }
</style>
<!-- iamport -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- grid -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<!-- kakao-map -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3a66ba8e60100e68a1df7756407ad0bb&libraries=services"></script>
</head>
<body>
	<div class="wrap">
		<div>
			<h3>견적서 내역 조회</h3>
		</div>
		<div align="right" style="margin-bottom: 1em; color: #478FEB;">
				*확인하실 견적서를 더블 클릭하시면 팝업으로 상세내역을 조회하실 수 있습니다.
		</div>
		<div id="offerGrid" align="center"></div>
		<div id="my_offer" align="center">
	    	<a class="modal_close_btn"> 
	    		<div style="border: 2px solid #cecece; border-radius:3px; width: 22px;"><b>X</b></div></a>
		    <div class="modal-header"></div>
		    <div style="border: 1px solid #dddddd; border-radius: 0.3em">
			    <div class="modal-body"></div>
			    <div class="modal-footer">
			    	<table style="width: 100%">
			    		<tr>
			    			<td colspan="2" style="padding-top:0.8em; width: 100%; text-align: left;"><h4 id="sName"></h4></td>
			    		</tr>
			    		<tr><td rowspan="8" style="width: 60%;"><div id="map" style="height:300px"></div></td><td class="store-row"><b>NAVIGATION</b></td></tr>
			    		<tr><td class="store-row" id="sAddr" style="vertical-align: top;"></td></tr>
			    		<tr><td class="store-row"><b>BUS</b></td></tr>
			    		<tr><td class="store-row" id="sBus" style="vertical-align: top;"></td></tr>
			    		<tr><td class="store-row"><b>SUBWAY</b></td></tr>
			    		<tr><td class="store-row" id="sSubway" style="vertical-align: top;"></td></tr>
			    		<tr><td class="store-row"><b>CONTACT</b></td></tr>
			    		<tr><td class="store-row" id="sContact" style="vertical-align: top;"></td></tr>
			    	</table>
			    </div>
		    </div>
		</div>
		<div style="margin: 1em 0em;">
			<button class="back-btn" type="button" onclick='location.href="myPageInfo"'>돌아가기</button>
		</div>
	</div>
<script>
// 견적서 내역 그리드 생성
$(document).ready(function() {
	const Grid = tui.Grid;
	
	const offerData = [
					<c:forEach items="${offerSelectList}" var="list" varStatus="status">
					{
						offer_code: '${list.offer_code}',
						offer_product: '${list.offer_product}',
						store_name: '${list.store_name}',
						offer_pay:'${list.offer_pay}',
						go_pay: '<c:choose><c:when test="${list.offer_pay != 'Y'}"><input type="button" value="결제" class="btn btn-primary btn-lg" onclick="iamport()" /></c:when><c:otherwise>결제 완료</c:otherwise></c:choose>',
						go_pay_Y: '<c:choose><c:when test="${list.offer_pay != 'Y'}"><input type="button" value="결제" class="btn btn-primary btn-lg" onclick="goPayY(\'${list.offer_code}\')" /></c:when><c:otherwise>결제 완료</c:otherwise></c:choose>'
					}
					<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				]
	
	console.log(offerData);
	
	const offerGrid = new Grid({
		el : document.getElementById('offerGrid'),
		data: offerData,
		columns : [
			{
				header: '견적서코드',
				name: 'offer_code',
				align: 'center',
				width: 100
			},
			{
				header:  '보관 물품명',
				name: 'offer_product',
				align: 'center',
			},
			{
				header: '희망 지점',
				name: 'store_name',
				align: 'center',
				width: 200
			},
			{
				header: '결제하기(API)',
				name: 'go_pay',
				align: 'center',
				width: 100
			},
			{
				header: '결제하기(non-API)',
				name: 'go_pay_Y',
				align: 'center',
				width: 130
			}
		],
		
		bodyHeight: 400,
		width: 'auto',
		pageOptions : {
			userClient: true,
			type: 'scroll'
		}
	});
	
	// Grid 컬럼 클릭 시 모달로 견적서 조회 요청
	offerGrid.on('dblclick', function(ev) {
		var target = ev;
		
		var myOffer = offerGrid.getValue(ev.rowKey,'offer_code');
		console.log(myOffer);
		
		$.ajax({
			url: 'myOffer/'+myOffer,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				console.log(result);
				showOffer(result);
			},
			error: function(xhr,status, msg) {
				alert("상태값 : "+status+" Http 에러메시지 : "+msg);
			}
		})
		
		function showOffer(data) {
			modal('my_offer');
			
			var storageSize = data.storage_name;
			var useStart = data.offer_start;
			var usePeriod = data.offer_date;
			var useEnd = data.offer_end;
			var storeName = data.store_name;
			var rental = data.offer_rental;
			var prod = data.offer_product;
			var coupon = data.coupon_name;
			var pickup = data.offer_pickup;
			var premium = data.offer_premium;
			var wash = data.laundry_product;
			var price = data.storage_price;
			var totalPrice = data.total_price;
			var navi = data.store_addr;
			var bus = data.store_bus;
			var subway = data.store_subway;
			var sMail = data.store_email;
			var sTel = data.store_tel;
			
			// KakaoMap
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(35.869095969748685, 128.59339734624666), // 지도의 중심좌표 (default 값)
			        level: 3 // 지도의 확대 레벨
			    };  
			setTimeout(function() {
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
			
		    var content = navi;
		    console.log(content);
		    
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(navi, function(result, status) {
			
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
			}, 100);
			var title = '<h3>견적서 상세내역</h3>';
			
			var tbl =$('<table width="100%" />');
			var row = '<tr>';
			row += '<th style="width: 20%;">사이즈</th>';
			row += '<td class="offer-row">' + storageSize + '</td></tr>';
			row += '<tr><th>이용기간</th>';
			row += '<td class="offer-row">' + useStart + " ~ " + useEnd + '&nbsp;(' + usePeriod + '개월)</td></tr>';
			row += '<tr><th>이용지점</th>';
			row += '<td class="offer-row">' + storeName + '</td></tr>';
			row += '<tr><th>렌탈용품</th>';
			row += '<td class="offer-row">' + rental + '</td></tr>';
			row += '<tr><th>보관용품</th>';
			row += '<td class="offer-row">' + prod + '</td></tr>';
			row += '<tr><th>쿠폰/할인</th>';
			row += '<td class="offer-row">' + coupon + '</td></tr>';
			row += '<tr><th>픽업 서비스</th>';
			if(pickup != null){
				row += '<td class="offer-row">' + pickup + '</td></tr>';
			} else {
				row += '<td class="offer-row">픽업 신청 없음</td></tr>';
			}
			row += '<tr><th style="color: #478FEB;">프리미엄 서비스</th>';
			row += '<td class="offer-row">' + premium + '</td></tr>';
			row += '<tr><th style="color: #478FEB;">세탁 서비스</th>';
			if(wash != null){
				row += '<td class="offer-row">' + wash + '</td></tr>';
			} else {
				row += '<td class="offer-row">N</td></tr>';
			}
			row += '<tr><th></th><td style="color: red;">*세탁 서비스와 프리미엄 서비스는 할인에서 제외됩니다.</td></tr>';
			row += '<tr><th style="vertical-align: top;">예상 월 이용금액</th>';
			if(price == 0){
				row += '<td class="offer-row" style="color: #006DFC; font-size: 9pt;">*라지 플러스의 경우 상담 후 창고 이용 최종 가격이 결정되며,'
						+ '<br>&nbsp;선택 옵션 가격만 계산되어 아래에 나타납니다.<br>'
						+ '&nbsp;창고 이용 시작일까지 매장으로 방문하시어 창고 이용료 결제를 완료 하셔야 이용 가능합니다.</td>'
			} else {
				row += '<td>' + price.toLocaleString() + '&nbsp;원</td></tr>';
			}
			row += '<tr><th style="padding-bottom:0.8em;">' + "예상 첫달 이용금액" + '</th>';
			row += '<td style="padding-bottom:0.8em;">' + totalPrice.toLocaleString() + '&nbsp;원</td></tr>';
			tbl.append(row);
			
			$('#sName').html(storeName);
			$('#sAddr').html(navi);
			$('#sBus').html(bus);
			$('#sSubway').html(subway);
			$('#sContact').html(sMail+'<br>'+sTel);
			
			
			$(".modal-header").append(title);
			$(".modal-body").append(tbl);
		}
		
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
		        $('.modal-header').empty();
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
});

/* iamport */
function showPopup() { window.open("ad_popup2.jsp", "a", "width=400, height=300, left=100, top=50"); }

function iamport(icode){
    //가맹점 식별코드
    IMP.init('imp07808434');
    IMP.request_pay({
        pg : 'kcp',
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(),
        name : '상품1' , //결제창에서 보여질 이름
        amount : 100, //실제 결제되는 가격
        buyer_email : 'iamport@siot.do',
        buyer_name : 'admin',
        buyer_tel : '010-1234-5678',
        buyer_addr : 'yedam',
        buyer_postcode : '123-456'
    }, function(rsp) {
       console.log(rsp);
        if ( rsp.success ) {
           var msg = '결제가 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래ID : ' + rsp.merchant_uid;
            msg += '결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;
            window.close();
        } else {
            var msg = '결제에 실패하였습니다.';
             msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
    });
    
 }
 
/* offer_pay 값 'Y'로 update */
function goPayY(offer_code){
	var offer_code = offer_code;
	$.ajax({
		url: 'goPayY',
		data: {offer_code : offer_code},
		type: 'post',
		success: function(res){
			console.log("res: "+res);
			location.reload();
		},
		error: function(err){
			console.log("error: "+err);
		}
		
	})
}
</script>
</body>
</html>