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
			width: 80%;
		}
		
   .apply-btn {
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
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
<div class="wrap">
	<div>
		<h3>공지사항 리스트</h3>
	</div>
	<div>
		<div id="storeNtGrid"></div>
	</div>
	<div class="bts">
		<button type="button" class="apply-btn" onclick="location.href='noticeForm'">글쓰기</button>&nbsp;&nbsp;
		<button type="button" class="back-btn" style="margin: 1em 0em;" onclick="history.back()">돌아가기</button>
	</div>
</div>
<script>
// 문의 내역 그리드 생성
$(document).ready(function() {
	const Grid = tui.Grid;
	
	const stNoticeData = [
		<c:forEach items="${storeNotice}" var="list" varStatus="status">
		
		{
			notice_num: '${list.notice_num}',
			notice_title: '${list.notice_title}',
			notice_date: '<fmt:formatDate value="${list.notice_date}" pattern="yy-MM-dd" />',
		}
			<c:if test="${not status.last}">,</c:if>
			</c:forEach>
		]
		
		console.log(stNoticeData);
		
		const storeNtGrid = new Grid({
		el : document.getElementById('storeNtGrid'),
		data: stNoticeData,
		columns : [
		{
			header: '글번호',
			name: 'notice_num',
			align: 'center',
		},
		{
			header: '글 제목',
			name: 'notice_title',
			align: 'center',
		},
		{
			header: '작성일',
			name: 'notice_date',
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
	storeNtGrid.on('dblclick', function(ev) {
		var target = ev;
		
		var myAsk = askGrid.getValue(ev.rowKey,'notice_num');
		console.log(myAsk);
		
		$.ajax({
			url: '',
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
			modal('storeNtGrid');
			
			var q_code;
			var q_parents;
			var q_title;
			var q_content;
			var q_store;
			var q_date;
 			var title;

 			var tbl =$('<table width="100%" />');
			
			$.each(data,function(idx, item){
				console.log(item);
				console.log(idx);
				q_code = item.question_num;
				q_parents = item.question_parents;
				q_title = item.question_title;
				q_content = item.question_content;
				q_store = item.store_name;
				q_date = item.question_date;
				console.log(q_code, q_parents, q_title, q_content, q_store, q_date);

				if(q_title == null)
					title = '<h4>제목이 없습니다.</h4>';
				else
					title = '<h4>'+ q_title + '</h4>';
					
				var row = '<tr>';
					
					if(q_parents == 1) {
						row += '<td width="20%" style="padding: 0.3em;">작성일자</td>';
						row += '<td width="80%">'+ q_date + '</td></tr>';
						row += '<tr style="border-bottom: 1px solid lightgray;">'+
								'<td colspan="2" width="60%" align="center" style="line-height: 2.5em; padding-bottom: 1em;">'
								+ q_content + '</td></tr>';
					} else {
						if(q_content != null){
						row += '<tr><td style="padding: 0.3em;"><img src="resources/assets/images/re.png">&nbsp;답변 </td><td>' + q_date + '</td></tr>';
						row += '<tr style="border-bottom: 1px dashed lightgray;"><td colspan="2" style="padding: 0.3em;">' + q_content + '</td></tr>';
						}
						else {
							row += '아직 등록된 답변이 없습니다.';
						}
					}
				tbl.append(row);
				if(idx == 0){
					$(".modal-header").append(title);
				}
			})
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
</script>
</body>
</html>