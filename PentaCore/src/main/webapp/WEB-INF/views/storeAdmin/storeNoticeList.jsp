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
    
    #storeNt-modal {
        display: none;
        width: 60%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #storeNt-modal .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    #storeNt-modal .modal-body{
    	font-size: 10pt;
    	border: 1px solid #00c0e2;
    	border-radius: 0.3em;
    }
    
   	input[type="text"] {
		background: white;
		border: 1px solid #5fd3e8;
		border-radius: 0.3em;
		width: 80%;
		height: 2.5em;
		padding: 5px;
		margin: 2em 0em;
	}
	
	#cke_editor1 {	/* 시도때도 없이 나오는 CK에디터 머리 참수 */
		display: none;
	}
	
	div.modal-body img {	/* Modal창 안에 표시되는 내용의 이미지 사이즈 강제 조정*/
		max-width: 100%;
		height: auto;
	}
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<!-- 게시판 오픈소스 : ckEditor4 -->
<script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
<script>
$(function() {
	CKEDITOR.replace('notice_content', {
		filebrowserUploadUrl:'${pageContext.request.contextPath }/fileUpload/imageUpload',
		enterMode : CKEDITOR.ENTER_BR,
		shiftEnterMode : CKEDITOR.ENTER_P,
		width: '90%'
	});
})
</script>
</head>
<body>
<div class="wrap">
	<div>
		<h3>공지사항 리스트</h3>
	</div>
	<div>
		<div id="storeNtGrid"></div>
		<div id="storeNt-modal">
			<a class="modal_close_btn">닫기</a>
			<div class="modal-header"></div>
			<div class="modal-body"></div>
			<textarea id="notice_content" name="notice_content"></textarea>
		</div>
	</div>
	<div class="bts">
		<button type="button" class="apply-btn" onclick="location.href='noticeForm'">글쓰기</button>&nbsp;&nbsp;
		<button type="button" class="back-btn" style="margin: 1em 0em;" onclick="history.back()">돌아가기</button>
	</div>
</div>
<script>
// 지점별 공지사항 그리드 생성
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
		rowHeaders: ['checkbox'],
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
	
	// Grid 컬럼 클릭 시 모달로 공지 내용 확인 및 수정
	storeNtGrid.on('dblclick', function(ev) {
		var target = ev;
		
		var snNum = storeNtGrid.getValue(ev.rowKey,'notice_num');
		console.log(snNum);
		
		$.ajax({
			url: 'storeNoticeSelect/'+snNum,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				console.log(result);
				showSnotice(result);
			},
			error: function(xhr,status, msg) {
				alert("상태값 : "+status+" Http 에러메시지 : "+msg);
			}
		})
		
		function showSnotice(data) {
			modal('storeNt-modal');

			var noNum = data.notice_num;
			var noTitle = data.notice_title;
			var noContent = data.notice_content;
			var noDate = data.notice_date;

			var title = '<input type="text" id="notice_title" name="notice_title" value="' + noTitle + '" />';
			
			var tbl =$('<table width="100%" />');
			var row = '<tr>';
			row += '<th style="width: 20%;">글번호</th>';
			row += '<td class="offer-row">' + noNum + '</td></tr>';
			row += '<tr><th style="width: 20%;">작성일자</th></tr>';
			row += '<td class="offer-row">' + noDate + '</td></tr>';
			row += '<tr><th colspan="2">내용</th></tr>';
			tbl.append(row);
			
			$(".modal-header").append(title);
			$(".modal-body").append(tbl);
			document.getElementById("notice_content").value=noContent;
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

})
</script>
</body>
</html>