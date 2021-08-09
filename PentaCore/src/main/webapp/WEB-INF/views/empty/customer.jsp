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
			margin: auto;
			text-align: center;
			padding: 30px 10px;
			width: 90%;
		}
		
	.customer-list {
		padding: 30px 50px;
		
	}
	
	.customer-Reg {
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
	
	.customer-form {
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
	
	#my_customer {	/*모달창*/
        display: none;
        width: 55%;
        height: 65%;
        padding: 30px 30px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #my_customer #btn1 {	/*모달창 신청버튼*/
        position: absolute;
        top: 460px;
        right: 420px;
    }
    
    #my_customer #btn2 {	/*모달창 신청버튼*/
        position: absolute;
        top: 460px;
        right: 340px;
    }
    
    .comment {	/*모달 내용 작은 코멘트*/
    	font-size:9pt;
    	color:#00c0e2;
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
    	background-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
    
    .back-btn {
    	background-color: #006DFC;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
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
			<div id="my_customer" align="center">
			    <div class="modal-body"></div>
			    <button class="btn btn-default btn-lg" id="btn1"><a onclick="submit()">확인</a></button>
			    <button class="btn btn-default btn-lg" id="btn2"><a class="modal_close_btn">닫기</a></button>
		    </div>
		</div>
      </div>
      
    <script type="text/javascript">
    
    function submit() {
    	
    	frm.submit();
    }
    
    
    $(document).ready(function(){
    	var list = '<c:out value="${customerListAll}"/>'
    	
    	const Grid = tui.Grid;

    	const customerData = [
    		<c:forEach items="${customerListAll}" var="list" varStatus="status">
    		{
    			apply_code: '${list.apply_code}',
    			member_name: '${list.member_name}',
    			apply_addr: '${list.apply_addr}',
    			apply_start: '<fmt:formatDate value="${list.apply_start}" pattern="yyyy-MM-dd" />',
    			apply_end: '<fmt:formatDate value="${list.apply_end}" pattern="yyyy-MM-dd" />',
    			store_name: '${list.store_name}',
    			store_code: '${list.store_code}'
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
       			header: '신청코드',
       			name: 'apply_code',
       			align: 'center'
       		},
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
  			var store_code = customerGrid.getValue(ev.rowKey,'store_code');
  			console.log(store_code	);
   			
   			$.ajax({
   				url: 'myCustomer',
   				type: 'GET',
   				data: {
   					apply_code: myCustomer,
   					store_code: store_code
   				},
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
   				console.log(data);
   				modal('my_customer');

   				var a_code = data.cus.apply_code;	// 코드
   				var a_name = data.cus.member_name;	// 이름 
   				var a_tel = data.cus.member_tel;	// 연락처
   				var a_start = data.cus.apply_start;	// 픽업일
   				var a_end = data.cus.apply_end;		// 운송일
   				var a_store = data.cus.store_name;	// 지점명
   				var a_addr = data.cus.apply_addr;
   				var a_product = data.cus.apply_product;
   				var b_storage_name = data.list;
   				console.log(b_storage_name);
   				var option ="";
   				for(let i = 0; i<data.list.length; i++){
		   			option += '<option value='+data.list[i]+'>'+ data.list[i] + '</option>'
		   		}
   				
   				var title = '<h4>운송정보</h4>';
   				
   				var frm = $('<form id="frm" name="frm" action="customerInsert" method="POST">');
   				var tbl =$('<table />');
   				var row = '<tr>';
   				row += '<th class="mo-tbl" style="width: 40%; padding-top: 30px; padding-bottom: 3%;" colspan="2">' + '<h5>'+ '고객 기본정보' + '</h5>' + '</th>';
   				row += '<th class="mo-tbl" style="width: 40%; padding-top: 30px; padding-bottom: 3%;" colspan="2">' + '<h5>'+ '상담원 추가입력' + '<h5>' + '</th>';
   				row += '<tr><th class="mo-tbl" style="width: 10%; vertical-align:top;">' + "이름" + '</th>';
   				row += '<td class="mo-tbl">' + a_name + '</td>';
   				row += '<input type="hidden" name="member_name" value='+a_name+'>';
   				row += '<th class="mo-tbl" style="vertical-align:top;">' + "신청코드" + '</th>';
   				row += '<td class="mo-tbl">' + a_code + '</td>';
   				row += '<input type="hidden" name="apply_code" value='+a_code+'>';
   				row += '<tr><th class="mo-tbl" style="vertical-align:top;">' + "연락처" + '</th>';
   				row += '<td class="mo-tbl">' + a_tel + '</td>';
   				row += '<th class="mo-tbl" style="vertical-align:top;">' + "특이사항" + '</th>';
   				row += '<td class="mo-tbl">' + '<input type=\'text\' name="convey_memo"/>' + '</td></tr>';
   				row += '<tr><th class="mo-tbl" style="vertical-align:top;">' + "픽업일" + '</th>';
   				row += '<td class="mo-tbl">' + a_start + '</td>';
   				row += '<th class="mo-tbl" style="vertical-align:top;">' + "운송차량" + '</th>';
   				row += '<td class="mo-tbl">' + '<input type=\'text\' name="convey_car"/>' + '</td></tr>';
   				row += '<tr><th class="mo-tbl" style="vertical-align:top;" value="c_name">' + "운송일" + '</th>';
   				row += '<td class="mo-tbl">' + a_end + '</td>';
   				row += '<th class="mo-tbl" style="vertical-align:top;">' + "기사배정" + '</th>';
   				row += '<td class="mo-tbl">' + '<input type=\'text\' name="convey_driver" />' + '</td></tr>';
   				row += '<tr><th class="mo-tbl" style="vertical-align:top;">' + "이전주소" + '</th>';
   				row += '<td class="mo-tbl">' + a_addr + '</td>';
   				row += '<input type="hidden" name="convey_before" value='+a_addr+'>';
   				row += '<th class="mo-tbl" style="vertical-align:top;">' + "배송주소" + '</th>';
   				row += '<td class="mo-tbl">' + '<input type=\'text\' name="convey_after"/>' + '</td></tr>';
   				row += '<tr><th class="mo-tbl" style="vertical-align:top;">' + "지점명" + '</th>';
   				row += '<td class="mo-tbl">' + a_store + '</td>';
   				row += '<th class="mo-tbl" style="vertical-align:top;">' + "스토리지" + '</th>';
   				row += '<td class="mo-tbl">' + 
   						'<select id="cuStorage" name="info_num">'
	   						+option+
   						'</select></td></tr>';
   				row += '<tr><th class="mo-tbl" style="vertical-align:top;">' + "이사규모" + '</th>';
   				row += '<td class="mo-tbl">' + a_product + '</td>';
   				row += '<th class="mo-tbl"style="vertical-align:top;">' + "배송시간" + '</th>';
   				row += '<td class="mo-tbl">' +
   						'<select id="convey_time" name="convey_time">' +
   							'<option value="AM 11:00 ~ 12:00">' + "AM 11:00 ~ 12:00" + '</option>' +
   							'<option value="PM 12:00 ~ 13:00">' + "PM 12:00 ~ 13:00" + '</option>' +
   							'<option value="PM 13:00 ~ 14:00">' + "PM 13:00 ~ 14:00" + '</option>' +
   							'<option value="PM 14:00 ~ 15:00">' + "PM 14:00 ~ 15:00" + '</option>' +
   							'<option value="PM 15:00 ~ 16:00">' + "PM 15:00 ~ 16:00" + '</option>' +
   							'<option value="PM 16:00 ~ 17:00">' + "PM 16:00 ~ 17:00" + '</option>' +
   							'<option value="PM 17:00 ~ 18:00">' + "PM 17:00 ~ 18:00" + '</option>' +
   							'<option value="PM 18:00 ~ 19:00">' + "PM 18:00 ~ 19:00" + '</option>' +
   							'<option value="PM 19:00 ~ 20:00">' + "PM 19:00 ~ 20:00" + '</option>' +
   						'</select></td></tr>';
   				row += '<th class="mo-tbl" style="vertical-align:top;" colspan="2"></th>';
   				row += '<th class="mo-tbl" style="vertical-align:top;" colspan="2">' + "사후관리 (사진업로드)" + '</th>';
   				
   				tbl.append(row);
   				frm.append(tbl);
   				
   				
   				$(".modal-body").append(title);
   				$(".modal-body").append(frm);
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