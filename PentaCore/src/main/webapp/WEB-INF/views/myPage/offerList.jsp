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
		<div id="my_offer">
		    <table border="1">
		    	<tr>
		    		<th>사이즈</th>
		    		<td>${myOfferSelect.storage_name }</td>
		    	</tr>
		    	<tr>
		    		<th>이용기간</th>
		    		<td>${myOfferSelect.offer_start } ~ ${myOfferSelect.offer_date }</td>
		    	</tr>
		    	<tr>
		    		<th>이용지점</th>
		    		<td>${myOfferSelect.store_name }</td>
		    	</tr>
		    	<tr>
		    		<th>렌탈용품</th>
		    		<td>${myOfferSelect.offer_rental }</td>
		    	</tr>
		    	<tr>
		    		<th>보관용품</th>
		    		<td>${myOfferSelect.offer_product }</td>
		    	</tr>
		    	<tr>
		    		<th>쿠폰/할인</th>
		    		<td>${myOfferSelect.coupon_code }</td>
		    	</tr>
		    	<tr>
		    		<th>픽업서비스</th>
		    		<td>${myOfferSelect.pickup }</td>
		    	</tr>
		    	<tr>
		    		<th>프리미엄 서비스</th>
		    		<td>${myOfferSelect.offer_premium }</td>
		    	</tr>
		    	<tr>
		    		<th>세탁서비스</th>
		    		<c:choose>
		    			<c:when test="${!empty myOfferSelect.laundry_product }">
		    				<td>${myOfferSelect.pickup }</td>
		    			</c:when>
		    			<c:otherwise>
		    				<td>N</td>
		    			</c:otherwise>
		    		</c:choose>
		    	</tr>
		    	<tr>
		    		<th>월 이용금액</th>
		    		<td>${myOfferSelect.price }</td>
		    	</tr>
		    	<tr>
		    		<th colspan="2">${myOfferSelect.store_name }</th>
		    	</tr>
		    	<tr>
		    		<td rowspan="8">여기는 지도</td>
		    		<th>네비게이션</th>
		    	</tr>
		    	<tr>
		    		<td>주소</td>
		    	</tr>
		    	<tr>
		    		<th>BUS</th>
		    	</tr>
		    	<tr>
		    		<td>버스정보</td>
		    	</tr>
		    	<tr>
		    		<th>SUBWAY</th>
		    	</tr>
		    	<tr>
		    		<td>지하철정보</td>
		    	</tr>
		    	<tr>
		    		<th>CONTACT US</th>
		    	</tr>
		    	<tr>
		    		<td>매장연락처</td>
		    	</tr>
		    </table>
		    <a class="modal_close_btn">닫기</a>
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
		
		// Grid 컬럼 클릭 시 모달로 견적서 조회
		offerGrid.on('click', function(ev) {
			var target = ev;
			
			var myOffer = offerGrid.getValue(ev.rowKey,'offer_code');
			console.log(myOffer);
			
			$.ajax({
				url: 'myOffer',
				type: 'GET',
				data: myOffer,
				success: function(result) {
					console.log(result);
					modal('my_offer');
				}
			})
			
						
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