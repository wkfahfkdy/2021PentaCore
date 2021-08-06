<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8"> 	
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style type="text/css">

	.wrap {
		width: 100%;
		text-align: center;
	}
	
	
	.list-info > a {
		text-align: right;
	}
	
	.convey-list {
		width: 80%;
	}

</style>
</head>
<body>
	<div class="wrap">
		<div class="title">
			<h3>물품 운송 신청 조회</h3>
		</div>
	
		<div class="convey-list">
			<div class="list-info">
			<a>* 더블클릭으로 추가정보를 입력해주세요.</a>
			</div>
			<div id="customerGrid" align="center"></div>
			<div id="customer" align="center">
			    <a class="modal_close_btn">닫기</a>
			    <div class="modal-body"></div>
		    </div>
		</div>
      </div>
      
    <script type="text/javascript">
    
    $(document).ready(function(){
    	var list = '<c:out value="${customerListAll}"/>'
    	
    	const Grid = tui.Grid;

    	const customerData = [
    		<c:forEach items="${customerListAll}" var="list" varStatus="status">
    		{
    			member_name: '${list.member_name}',
    			apply_addr: '${list.apply_addr}',
    			apply_start: '<fmt:formatDate value="${list.apply_start}" pattern="yyyy-MM-dd" />',
    			apply_end: '<fmt:formatDate value="${list.apply_end}" pattern="yyyy-MM-dd" />',
    			store_name: '${list.store_name}'
    		}
    			<c:if test="${not status.last}">,</c:if>
    			</c:forEach>
    		]
    		
    		console.log(customerData);
    		
    		const customerGrid = new Grid({
    		el : document.getElementById('customerGrid'),
    		data: customerData,
    		columns : [
    		{
    			width: 100,
    			header: '신청자명',
    			name: 'member_name',
    			align: 'center'
    		},
    		{
    			header: '현재주소',
    			name: 'apply_addr',
    			align: 'center'
    		},
    		{
    			width: 100,
    			header:  '픽업',
    			name: 'apply_start',
    			align: 'center'
    		},
    		{
    			width: 100,
    			header:  '운송',
    			name: 'apply_end',
    			align: 'center'
    		},
    		{
    			width: 150,
    			header: '희망지점',
    			name: 'store_name',
    			align: 'center'
    		}
    		],
    		
    		bodyHeight: 500,
    		width: 'auto',
    		pageOptions : {
		    useClient: true,
    		type: 'scroll'
   	      	}
   		});
    		
   		//Grid 컬럼 클릭 시 모달로 견적서 조회 요청
   		customerGrid.on('dblclick', function(ev) {
   			var target = ev;
   			
   			var myCustomer = customerGrid.getValue(ev.rowKey,'apply_code');
   			console.log(myCustomer);
   			
   			$.ajax({
   				url: 'myCustomer/'+myCustomer,
   				type: 'GET',
   				dataType: 'json',
   				success: function(result) {
   					console.log(result);
   					showCustomer(result);
   				},
   				error: function(xhr,status, msg) {
   					alert("상태값 : "+status+" Http 에러메시지 : "+msg);
   				}
   			})
   			
   			function showCustomer(data) {
   				modal('my_customer');

   				var a_code = data.apply_code;	// 코드
   				var a_name = data.member_name;	// 이름 
   				var a_tel = data.mamber_tel;	// 연락처
   				var a_start = data.apply_start;	// 픽업일
   				var a_end = data.apply_end;		// 운송일
   				var a_prod = data.apply_product;	// 이전주소
   				var a_store = data.store_name;	// 지점명

   				var title = '<h4>운송정보</h4>';
   				
   				var tbl =$('<table />');
   				var row = '<tr>';
   				row += '<td class="mo-tbl" style="width: 30%; padding-top: 30px;" colspan="2">' + '고객 기본정보' + '</td>';
   				row += '<td class="mo-tbl" style="width: 30%; padding-top: 30px;" colspan="2">' + '상담원 추가입력' + '</td>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "이름" + '</td>';
   				row += '<td class="mo-tbl">' + a_name + '</td></tr>';
   				row += '<td class="mo-tbl" style="vertical-align:top;">' + "물품정보" + '</td>';
   				row += '<td class="mo-tbl">' + '<input type="text">' + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "연락처" + '</td>';
   				row += '<td class="mo-tbl">' + a_tel + '</td></tr>';
   				row += '<td class="mo-tbl" style="vertical-align:top;">' + "특이사항" + '</td>';
   				row += '<td class="mo-tbl">' + '<input type="text">' + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "픽업일자" + '</td>';
   				row += '<td class="mo-tbl">' + a_start + '</td></tr>';
   				row += '<td class="mo-tbl" style="vertical-align:top;">' + "차량사이즈" + '</td>';
   				row += '<td class="mo-tbl">' + '<input type="text">' + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "운송시간" + '</td>';
   				row += '<td class="mo-tbl">' + a_end + '</td></tr>';
   				row += '<td class="mo-tbl" style="vertical-align:top;">' + "기사배정" + '</td>';
   				row += '<td class="mo-tbl">' + '<input type="text">' + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "이전주소" + '</td>';
   				row += '<td class="mo-tbl">' + a_prod + '</td></tr>';
   				row += '<td class="mo-tbl" style="vertical-align:top;" colspan="2">' + "사후관리 (사진업로드)" + '</td>';
   				
   				
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
    });
</script>
</body>
</html>