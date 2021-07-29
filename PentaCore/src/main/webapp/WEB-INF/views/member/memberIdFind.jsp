<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	#my_offer {
        display: none;
        width: 60%;
        padding: 30px 60px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #my_offer .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    .modal-body{
    	font-size: 10pt;
    }
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
	<div class="wrap">
		<div>
			<h3>견적서 내역 조회</h3>
		</div>
		<div id="offerGrid" align="center"></div>
		<div id="my_offer" align="center">
		    <a class="modal_close_btn">닫기</a>
		    <div class="modal-body">
			    Hello!
		    </div>
		</div>
	</div>
<script>
	// 견적서 내역 그리드 생성
	$(document).ready(function() {
		var list = '<c:out value="${offerSelectList}"/>';
		
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
					width: 800
					
				},
				{
					header: '희망 지점',
					name: 'store_name',
					align: 'center',
					width: 200
				},
				{
					header: '결제 여부',
					name: 'offer_pay',
					align: 'center',
					width: 100
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
		offerGrid.on('click', function(ev) {
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
				var useEnd = data.offer_date;
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
				var sMail = data.store_mail;
				var sTel = data.store_tel;
				var tbl =$('<table />');
				var title = '견적서 상세내역';
				
				var row = '<tr>';
				row += '<td>' + '사이즈' + '</td>';
				row += '<td>' + storageSize + '</td></tr>';
				row += '<tr><td>' + "이용기간" + '</td>';
				row += '<td>' + useStart + " ~ " + useEnd + '</td></tr>';
				row += '<tr><td>' + "이용지점" + '</td>';
				row += '<td>' + storeName + '</td></tr>';
				row += '<tr><td>' + "렌탈용품" + '</td>';
				row += '<td>' + rental + '</td></tr>';
				row += '<tr><td>' + "보관용품" + '</td>';
				row += '<td>' + prod + '</td></tr>';
				row += '<tr><td>' + "쿠폰/할인" + '</td>';
				row += '<td>' + coupon + '</td></tr>';
				row += '<tr><td>' + "픽업 서비스" + '</td>';
				row += '<td>' + pickup + '</td></tr>';
				row += '<tr><td>' + "프리미엄 서비스" + '</td>';
				row += '<td>' + premium + '</td></tr>';
				row += '<tr><td>' + "세탁 서비스" + '</td>';
				row += '<td>' + wash + '</td></tr>';
				row += '<tr><td></td><td>' + "*세탁 서비스는 할인에서 제외됩니다." + '</td></tr>';
				row += '<tr><td>' + "예상 월 이용금액" + '</td>';
				row += '<td>' + price + '</td></tr>';
				row += '<tr><td>' + "예상 첫달 이용금액" + '</td>';
				row += '<td>' + totalPrice + '</td></tr>';
				row += '<tr><td colspan="2">' + storeName + '</td></tr>';
				row += '<tr><td rowspan="8">' + "여기엔 매장지도" + '</td>';
				row += '<td>' + "네비게이션" + '</td><tr>';
				row += '<td>' + navi + '</td></tr>';
				row += '<tr><td>' + "BUS" + '</td></tr>';
				row += '<tr><td>' + bus + '</td></tr>';
				row += '<tr><td>' + "SUBWAY" + '</td></tr>';
				row += '<tr><td>' + subway + '</td></tr>';
				row += '<tr><td>' + "CONTACT" + '</td></tr>';
				row += '<tr><td>' + sMail + '<br>' + sTel + '</td></tr>';
					
				tbl.append(row);
				$(".modal-body").append(title);
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
	

</script>
</body>
</html>