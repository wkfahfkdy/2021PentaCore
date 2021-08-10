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
		
   .apply-btn, #edit-btn {
    	background-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
		
	.back-btn, #del-btn {
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
    }
    
    .modal-header {
    	padding: 1em;
    }
    
   	input[type="text"] {
		background: white;
		border: 1px solid #5fd3e8;
		border-radius: 0.3em;
		width: 80%;
		height: 2.5em;
		padding: 5px;
		margin: 1em 0em;
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
			width: '100%'
		});
	})
	
	//CK 에디터 이미지 업로드시 업로드 탭으로 바로 시작하게 하기
	CKEDITOR.on('dialogDefinition', function (ev) {
            var dialogName = ev.data.name;
            var dialog = ev.data.definition.dialog;
            var dialogDefinition = ev.data.definition;
           
            if (dialogName == 'image') {
                dialog.on('show', function (obj) {
                    this.selectPage('Upload'); //업로드텝으로 시작
                });
                dialogDefinition.removeContents('advanced'); // 자세히탭 제거
                dialogDefinition.removeContents('Link'); // 링크탭 제거
            }
        });
	
	// 공지사항 수정 함수
	function editNotice() {
		var data = $("form[id=frm]").serialize();
		//CK에디터 수정한 내용 받아오기...
		var myText = CKEDITOR.instances['notice_content'].getData();
		console.log(data+myText);
		
		if(confirm('수정하시겠습니까?')){
			$.ajax({
				url: 'editNotice',
				type: 'POST',
				data: data+myText,
				success: function(result) {
					console.log(result);
					alert('수정이 완료되었습니다.');
					location.reload();
				},
				
				error: function(xhr, status, msg) {
					alert('수정에 실패하였습니다. 상태값 : ' + status + '에러메시지 : ' + msg);
				}
			})
		} else {
			return false;
		}
	}
	
	// 공지사항 삭제 함수
	function deleteNotice() {
		var notice_num = $('#frm #notice_num').val();  
		console.log(notice_num);
		
		if(confirm('삭제하시겠습니까?')){
			$.ajax({
				url: 'deleteNotice/'+notice_num,
				type: 'GET',
				success: function(result) {
					console.log(result);
					alert('삭제가 완료되었습니다.');
					location.reload();
				},
				error: function(xhr, status, msg) {
					alert('삭제에 실패하였습니다. 상태값 : ' + status + '에러메시지 : ' + msg);
				}
			})
		} else {
			return false;
		}
	}
</script>
</head>
<body>
<div class="wrap">
	<div>
		<h3>공지사항 리스트</h3>
	</div>
	<div>
		<div id="storeNtGrid">
	</div>
		<div id="storeNt-modal">
			<form id="frm">
			<input type="hidden" id="notice_num" name="notice_num" value="" />
				<a class="modal_close_btn">닫기</a>
				<div class="modal-header"></div>
				<div class="modal-body"></div>
				<textarea id="notice_content" name="notice_content"></textarea>
				<div class="modal-footer">
					<button id="edit-btn" type="button" onclick="editNotice()">수정</button>&nbsp;
					<button id="del-btn" type="button" onclick="deleteNotice()">삭제</button>
				</div>
			</form>
		</div>
	</div>
	<div>
		<button type="button" class="apply-btn" onclick="location.href='noticeForm'">글쓰기</button>&nbsp;&nbsp;
		<button type="button" class="back-btn" style="margin: 1em 0em;" onclick="location.href='home'">돌아가기</button>
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
			width: 100
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
			width: 200
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
			row += '<th style="width: 10%;">글번호</th>';
			row += '<td style="text-align: left;">' + noNum + '</td>';
			row += '<th style="width: 20%;">작성일자</th>';
			row += '<td style="text-align: left;">' + noDate + '</td></tr>';
			tbl.append(row);
			
			$(".modal-header").append(title);
			$(".modal-body").append(tbl);
			//CK에디터용 기본 값 붙이기
			CKEDITOR.instances['notice_content'].setData(noContent);
			// input type hidden value값 붙이기
			$('#notice_num').attr('value',noNum);
			
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