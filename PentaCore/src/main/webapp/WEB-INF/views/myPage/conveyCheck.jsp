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
			padding: 10px 50px;
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
		height: 31px;
		padding: 3px;
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
	
	#my_convey {
        display: none;
        width: 60%;
        padding: 30px 50px;
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
			<h3>물품 운송 신청 조회</h3>
		</div>
		<div class="convey-list">
			<div class="list-info">
				*상세보기를 원하시는 경우, 신청내역을 더블클릭하면 조회가 가능합니다.
			</div>
			<div id="conveyGrid" align="center"></div>
			<div id="my_convey" align="center">
			    <a class="modal_close_btn">닫기</a>
			    <div class="modal-body"></div>
		    </div>
		</div>
		</div>
		<div class="convey-Reg">
			<div align="left">
				<h4>물품 운송 신청하기</h4>
			</div>
			<form id="frm" action="" method="post">
				<div class="convey-form">
					<div class="form-memtitle">
						<div class="title">이름</div>
						<div class="title">연락처</div>
						<div class="title">픽업 희망 주소</div>
						<div class="title">운송 물품 정보</div>
					</div>
					<div class="form-memdata">
						<div class="mem-data"><input type="text" id="member_name" name="name" value=""/></div>
						<div class="mem-data"><input type="text" id="member_tel" name="tel" value="" /></div>
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
											<p style="color: gray; font-size: 8pt;">*보관 이사 신청 시 이용을 희망하는 지점을 선택해주세요.</p></div>
						<div class="con-data"><input type="date" id="apply_end" name="apply_end" /><br>
											<p style="color: gray; font-size: 8pt;">*보관 이사 신청 시 또는 기존 이용 고객님의 경우 선택해주세요.</p></div>
						<div class="con-data"><select id="apply_whether" name="apply_whether">
							<option value="N">N</option>
							<option value="Y">Y</option>
						</select></div>
					</div>
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
			con_code: '${list.convey_code}',
			store_name: '${list.store_name}',
			convey_product: '${list.apply_product}',
			convey_date: '<fmt:formatDate value="${list.apply_start}" pattern="yyyy-MM-dd" />',
			storage_code:'${list.info_num}'
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
			name: 'con_code',
			align: 'center',
		},
		{
			header: '이용 지점',
			name: 'store_name',
			align: 'center',
		},
		{
			header:  '보관 희망 물품',
			name: 'convey_product',
			align: 'center',
		},
		{
			header: '운송희망일',
			name: 'convey_date',
			align: 'center',
		},
		{
			header: '스토리지 번호',
			name: 'storage_code',
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
		
		var myConvey = conveyGrid.getValue(ev.rowKey,'convey_code');
		console.log(myConvey);
		
		$.ajax({
			url: '',
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

			/* var storageSize = data.storage_name;
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
			var sMail = data.store_email;
			var sTel = data.store_tel;

			var title = '견적서 상세내역';
			
			var tbl =$('<table />');
			var row = '<tr>';
			row += '<td style="width: 30%;">' + '사이즈' + '</td>';
			row += '<td style="width: 70%;">' + storageSize + '</td></tr>';
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
			row += '<tr style="border-bottom: 1px lightgray solid;"><td style="padding-bottom:0.8em;">' + "예상 첫달 이용금액" + '</td>';
			row += '<td style="padding-bottom:0.8em;">' + totalPrice + '</td></tr>';
			tbl.append(row);
			
			var tbl2 = $('<table />');
			var row2 = '<tr>';
			row2 += '<td colspan="2" style="padding-top:0.8em; width: 100%;">' + storeName + '</td></tr>';
			row2 += '<tr><td rowspan="8" style="width: 50%;">' + "여기엔 매장지도" + '</td>';
			row2 += '<td style="width: 50%;">' + "네비게이션" + '</td></tr>';
			row2 += '<tr><td>' + navi + '</td></tr>';
			row2 += '<tr><td>' + "BUS" + '</td></tr>';
			row2 += '<tr><td>' + bus + '</td></tr>';
			row2 += '<tr><td>' + "SUBWAY" + '</td></tr>';
			row2 += '<tr><td>' + subway + '</td></tr>';
			row2 += '<tr><td>' + "CONTACT" + '</td></tr>';
			row2 += '<tr><td>' + sMail + '<br>' + sTel + '</td></tr>';
			tbl2.append(row2);
			
			
			$(".modal-body").append(title);
			$(".modal-body").append(tbl);
			$(".modal-body").append(tbl2); */
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
})
</script>
</body>
</html>