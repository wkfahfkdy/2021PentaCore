<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8"> 	
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
	<div>
		<h3>물품 운송 신청 조회</h3>
	</div>

	<div class="convey-list">
		<div class="list-info">
		* 더블클릭으로 추가정보를 입력해주세요.
		</div>
		<div id="customerGrid" align="center"></div>
		<div id="customer" align="center">
		    <a class="modal_close_btn">닫기</a>
		    <div class="modal-body"></div>
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
    			header:  '픽업',
    			name: 'apply_start',
    			align: 'center'
    		},
    		{
    			header:  '운송',
    			name: 'apply_end',
    			align: 'center'
    		},
    		{
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
   			
   			var myCustomer = conveyGrid.getValue(ev.rowKey,'apply_code');
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
   				var a_time = data.apply_time;
   				var a_end = data.apply_end;
   				var a_whether = data.apply_whether;
   				var a_prod = data.apply_product;
   				var a_use = data.use_num;
   				var a_store = data.store_name;
   				var a_addr = data.apply_addr;

   				var title = '<h4>운송 신청 상세내역</h4>';
   				
   				var tbl =$('<table />');
   				var row = '<tr>';
   				row += '<td class="mo-tbl" style="width: 30%; padding-top: 30px;">' + '신청코드' + '</td>';
   				row += '<td class="mo-tbl" style="width: 70%; padding-top: 30px;">' + a_code + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "픽업 희망 일자" + '</td>';
   				if(a_start == a_end){
   					row += '<td class="mo-tbl"><p class="comment">*보관 이사 시 픽업되는 날짜로, 단순 출고는 해당되지 않습니다.</p></td></tr>';
   				} else {
   					row += '<td class="mo-tbl">' + a_start + '<br><p class="comment">*보관이사시 댁으로 방문하여 픽업하는 날짜입니다.</p></td></tr>';
   				}
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "픽업 희망 주소" + '</td>';
   				row += '<td class="mo-tbl">' + a_addr + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "출고 희망 일자" + '</td>';
   				row += '<td class="mo-tbl">' + a_end + '<br><p class="comment">*보관이사 또는 이용 중인 스토리지에서 물품을 출고하는 날짜입니다.</p></td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "보관이사 여부" + '</td>';
   				row += '<td class="mo-tbl">' + a_whether + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "운송 물품 정보" + '</td>';
   				row += '<td class="mo-tbl">' + a_prod + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "이용 지점" + '</td>';
   				row += '<td class="mo-tbl">' + a_store + '</td></tr>';
   				row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "이용 중인 스토리지 번호" + '</td>';
   				row += '<td class="mo-tbl">' + a_use + '<br><p class="comment" style="line-height:1.2em;">*기존에 스토리지를 이용하시는 고객의 경우,<br>이용 중인 스토리지의 번호 정보입니다.</p></td></tr>';
   				row += '<tr><td class="mo-tbl" colspan="2"><p style="color: red; font-size: 9pt; line-height: 1.3em;">접수 된 신청건은 세부 일정 조율과 상담을 위해 물품 운송팀에서 확인 후,<br>'
   				+'고객님께 직접 연락을 드립니다. 만일 취소나 변경사항이 생길 경우 고객센터로 문의주시면<br>신속하게 처리를 도와드립니다.</p></td></tr>';
   				
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