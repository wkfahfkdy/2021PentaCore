<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.wrap {
		margin: auto;
		text-align: center;
		padding: 50px 10px;
		width: 90%;
	}
	
	.back-btn {
    	background-color: #006DFC;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
    
    .apply-btn {
    	background-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
    
    .choice-store {
    	margin: 2em 0em;
    	text-align: right;
    	width: 90%;
    }
    
    #my-ask {	/*모달창*/
        display: none;
        width: 50%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #my-ask .modal_close_btn {	/*모달창 닫기버튼*/
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    .ask-table {
    	display: table;
    	width: 60%;
    	margin-top: 2em;
    	border-top: 1px solid #00c0e2;
    }
    
    .form-title, .choice-store, .form-area, .bts {
    	display: table-row;
    	height: 2em;
    }
    
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<!-- 게시판 오픈소스 : ckEditor4 -->
<script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
<script>
	$(function() {
		CKEDITOR.replace('question_content', {
			filebrowserUploadUrl:'${pageContext.request.contextPath }/fileUpload/reviewRegist',
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			height: '30em'
		});
	})
	
	function formCheck() {
		if (frm.question_content.value == "") {
			alert("내용을 입력하세요.");
			frm.title.focus();
			return false;	// submit을 하지 않도록
		}
		frm.submit();
	}
</script>
</head>
<body>
<div class="wrap">
	<div>
		<h3><font style="color: #00c0e2;">${loginName }</font>
			님의 1:1문의 내역</h3>
	</div>
	<div class="ask-list">
		<div id="askGrid"></div>
		<div id="my-ask" align="center">
		    <a class="modal_close_btn">닫기</a>
		    <div class="modal-body"></div>
	    </div>
	</div>
	<div class="ask-table">
		<div class="at-from">
			<div class="form-title">
				<h3 align="left">1:1 문의하기</h3>
			</div>
			<form id="frm" action="" method="POST">
				<div class="choice-store">
					<font style="color: #00c0e2;">
						*문의를 원하시는 지점을 선택해주세요&nbsp;&nbsp;
					</font>
					<select id="store_code" name="store_code">
						<c:forEach items="${storeList }" var="st">
							<option value="${st.store_code }">${st.store_name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-area" align="center">
					<textarea id="question_content" name="question_content"></textarea>
				</div>
				<div class="bts">
					<button type="submit" class="apply-btn">등록</button>&nbsp;&nbsp;
					<button class="back-btn" style="margin: 1em 0em;">돌아가기</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
// 문의 내역 그리드 생성
$(document).ready(function() {
	var list = '<c:out value="${myAskList}"/>';
	const Grid = tui.Grid;
	
	const myAskData = [
		<c:forEach items="${myAskList}" var="list" varStatus="status">
		
		{
			question_num: '${list.question_num}',
			store_name: '${list.store_name}',
			question_title: '${list.question_title}...',
			question_date: '<fmt:formatDate value="${list.question_date}" pattern="yy-MM-dd" />',
		}
			<c:if test="${not status.last}">,</c:if>
			</c:forEach>
		]
		
		console.log(myAskData);
		
		const askGrid = new Grid({
		el : document.getElementById('askGrid'),
		data: myAskData,
		columns : [
		{
			header: '글번호',
			name: 'question_num',
			align: 'center',
		},
		{
			header: '문의 지점',
			name: 'store_name',
			align: 'center',
		},
		{
			header:  '문의 내용',
			name: 'question_title',
			align: 'center',
		},
		{
			header: '작성일',
			name: 'question_date',
			align: 'center',
		}
		],
		
		bodyHeight: 250,
		width: 'auto',
		pageOptions : {
		userClient: true,
		type: 'scroll'
		}
	});
		
	//Grid 컬럼 클릭 시 모달로 견적서 조회 요청
	askGrid.on('dblclick', function(ev) {
		var target = ev;
		
		var myAsk = askGrid.getValue(ev.rowKey,'question_num');
		console.log(myConvey);
		
		$.ajax({
			url: 'myAsk/'+myAsk,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				console.log(result);
				showAsk(result);
			},
			error: function(xhr,status, msg) {
				alert("상태값 : "+status+" Http 에러메시지 : "+msg);
			}
		})
		
		function showAsk(data) {
			modal('my-ask');

// 			var a_code = data.apply_code;
// 			var a_Start = data.apply_start;
// 			var a_time = data.apply_time;
// 			var a_end = data.apply_end;
// 			var a_whether = data.apply_whether;
// 			var a_prod = data.apply_product;
// 			var a_use = data.info_num;
// 			var a_store = data.store_name;
// 			var a_addr = data.apply_addr;

// 			var title = '<h4>운송 신청 상세내역</h4>';
			
// 			var tbl =$('<table />');
// 			var row = '<tr>';
// 			row += '<td class="mo-tbl" style="width: 30%; padding-top: 30px;">' + '신청코드' + '</td>';
// 			row += '<td class="mo-tbl" style="width: 70%; padding-top: 30px;">' + a_code + '</td></tr>';
// 			row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "픽업 희망 일자" + '</td>';
// 			row += '<td class="mo-tbl">' + a_Start + '<br><p class="comment">*보관이사시 댁으로 방문하여 픽업하는 날짜입니다.</p></td></tr>';
// 			row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "픽업 희망 주소" + '</td>';
// 			row += '<td class="mo-tbl">' + a_addr + '</td></tr>';
// 			row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "출고 희망 일자" + '</td>';
// 			row += '<td class="mo-tbl">' + a_end + '<br><p class="comment">*보관이사 또는 이용 중인 스토리지에서 물품을 출고하는 날짜입니다.</p></td></tr>';
// 			row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "보관이사 여부" + '</td>';
// 			row += '<td class="mo-tbl">' + a_whether + '</td></tr>';
// 			row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "운송 물품 정보" + '</td>';
// 			row += '<td class="mo-tbl">' + a_prod + '</td></tr>';
// 			row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "이용 지점" + '</td>';
// 			row += '<td class="mo-tbl">' + a_store + '</td></tr>';
// 			row += '<tr><td class="mo-tbl" style="vertical-align:top;">' + "이용 중인 스토리지 번호" + '</td>';
// 			row += '<td class="mo-tbl">' + a_use + '<br><p class="comment" style="line-height:1.2em;">*기존에 스토리지를 이용하시는 고객의 경우,<br>이용 중인 스토리지의 번호 정보입니다.</p></td></tr>';
// 			row += '<tr><td class="mo-tbl" colspan="2"><p style="color: red; font-size: 9pt; line-height: 1.3em;">접수 된 신청건은 세부 일정 조율과 상담을 위해 물품 운송팀에서 확인 후,<br>'
// 			+'고객님께 직접 연락을 드립니다. 만일 취소나 변경사항이 생길 경우 고객센터로 문의주시면<br>신속하게 처리를 도와드립니다.</p></td></tr>';
			
// 			tbl.append(row);
			
// 			$(".modal-body").append(title);
// 			$(".modal-body").append(tbl);
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
</body>
</html>