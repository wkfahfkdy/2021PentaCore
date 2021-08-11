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
			width: 90%;
		}
		
	.back-btn {
    	background-color: #006DFC;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		padding: 0.4em;
    }
    
   	#noticeDetail {
        display: none;
        width: 60%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #noticeDetail .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    div.modal-body img {	/* Modal창 안에 표시되는 내용의 이미지 사이즈 강제 조정*/
		max-width: 100%;
		height: auto;
	}
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
<div class="wrap">
	<div>
		<h3>공지사항</h3>
	</div>
	<div align="left">
		<font style="font-size: 9pt; color: red;">*확인 하실 공지글을 더블 클릭하면 상세 내용이 보여집니다.</font>
	</div>
	<div id="noticeGrid" align="center"></div>
	<div id="noticeDetail" align="center">
	    <a class="modal_close_btn">닫기</a>
	    <div class="modal-body"></div>
	    <div class="modal-storeInfo"></div>
	</div>
	<div style="margin: 1em 0em;">
		<button class="back-btn" type="button" onclick="history.back();">돌아가기</button>
	</div>
</div>
<script>
// 견적서 내역 그리드 생성
$(document).ready(function() {
	const Grid = tui.Grid;
	
	const noticeData = [
					<c:forEach items="${noticeSelectList}" var="list" varStatus="status">
					{
						notice_num: '${list.notice_num}',
						notice_title: '${list.notice_title}',
						notice_date: '<fmt:formatDate value="${list.notice_date}" pattern="yyyy-MM-dd" />'
					}
					<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				]
	
	console.log(noticeData);
	
	const noticeGrid = new Grid({
		el : document.getElementById('noticeGrid'),
		data: noticeData,
		columns : [
			{
				header: '글번호',
				name: 'notice_num',
				align: 'center',
				width: 100
			},
			{
				header:  '글 제목',
				name: 'notice_title',
				align: 'center',
				width: 900
				
			},
			{
				header: '올린 날짜',
				name: 'notice_date',
				align: 'center',
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
	noticeGrid.on('dblclick', function(ev) {
		var target = ev;
		
		var notice = noticeGrid.getValue(ev.rowKey,'notice_num');
		console.log(notice);
		
		$.ajax({
			url: 'notice/'+notice,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				console.log(result);
				showNotice(result);
			},
			error: function(xhr,status, msg) {
				alert("상태값 : "+status+" Http 에러메시지 : "+msg);
			}
		})
		
		function showNotice(data) {
			modal('noticeDetail');

			var nCode = data.notice_num;
			var nTitle = data.notice_title;
			var content = data.notice_content;
			var nDate = data.notice_date;
			var sName = data.store_name;

			var title = '<h3>'+nTitle+'</h3>';
			
			var tbl =$('<table />');
			var row = '<tr>';
			row += '<td style="height: 2em; width: 4em">글번호</td>';
			row += '<td style="height: 2em; text-align: left;">' + nCode + '</td>';
			row += '<td style="height: 2em; text-align: right;">' + nDate + '</td></tr>';
			row += '<tr><td colspan="3" style="padding: 3em 0em; font-size: 11.5pt;">' + content + '</td></tr>';
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
</script>
</body>
</html>