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
    
    #my-ask {	/*모달창*/
        display: none;
        width: 60%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
        height: 80%;
		overflow-y: auto; /*세로 스크롤 생성*/
    }

    #my-ask .modal_close_btn {	/*모달창 닫기버튼*/
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
     #my-ask::-webkit-scrollbar {
	    width: 10px;
	  }

	 #my-ask::-webkit-scrollbar-thumb {
	    background-color: #00c0e2;
	    border-radius: 10px;
	    background-clip: padding-box;
	    border: 2px solid transparent;
	  }
	  #my-ask::-webkit-scrollbar-track {
	    background-color: #CEF6F5;
	    border-radius: 10px;
	    box-shadow: inset 0px 0px 5px white;
	  }
    
    .ask-table {
    	display: table;
    	width: 100%;
    	margin-top: 2em;
    	border-top: 1px solid #00c0e2;
    }
    
    .ask-row1, .ask-row2, .ask-row3 {
    	display: table-row;
    }

    .form-title, .ct-title, .choice-store, .ct-content, .ct-content2, .form-area, .bts {
    	display: table-cell;
    	height: 2em;
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
		font-weight: bold;
		padding: 0.4em;
    }
    
    .choice-store {
    	margin: 2em 0em;
    }
    
    .cs-call {
    	background-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-weight: bold;
		font-size: 20pt;
		width: 15em;
		height: 2em;
    }
    
    .cs-mail {
    	background-color: #819FF7;
		border-radius: 0.3em;
		color: white;
		font-weight: bold;
		font-size: 18pt;
		width: 16.5em;
		height: 2.3em;
    }
    
    input[type="text"] {
		background: white;
		border: 1px solid #5fd3e8;
		border-radius: 0.3em;
		width: 42%;
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
	
	.modal-body {
		border: 1px solid #00c0e2; 
	 	border-radius: 0.3em;
	 	overflow: auto;
	 	word-break: break-word;
      	min-height: 200px;
	}
	
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<!-- 게시판 오픈소스 : ckEditor4 -->
<script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
<script>
	$(function() {
		CKEDITOR.replace('question_content', {
			filebrowserUploadUrl:'${pageContext.request.contextPath }/fileUpload/imageUpload',
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			height: '30em'
		});
	})
	
	function formCheck() {
		if (frm.question_title.value == "") {
			alert("제목을 입력하세요.");
			frm.question_title.focus();
		}
		if (frm.question_content.text == "") {
			alert("내용을 입력하세요.");
			frm.question_content.focus();
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
		    <div class="modal-header"></div>
		    <div class="modal-body"></div>
	    </div>
	</div>
	<form id="frm" action="registAsk" method="POST">
		<div class="ask-table">
			<div class="ask-row1">
				<div class="form-title">
					<h3 align="left">1:1 문의하기</h3>
				</div>
				<div class="ct-title">
					<h3 align="left" style="margin-left: 1em;">무엇이든 물어보세요!</h3>
				</div>
			</div>
			<div class="ask-row2">
				<div class="choice-store" style="width:60%;">
					제목&nbsp;&nbsp;<input type="text" id="question_title" name="question_title" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<font style="color: #00c0e2;">
						*문의를 원하시는 지점을 선택해주세요&nbsp;&nbsp;
					</font>
					<select id="store_code" name="store_code">
						<c:forEach items="${storeList }" var="st">
							<option value="${st.store_code }">${st.store_name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="ct-content" align="left" style="padding-left: 2em;">
					법인, 특수목적 등 별도 문의가 필요한 경우는<br>
					대표 고객센터로 연락하시거나 메일로 문의사항을 제출해주세요.
				</div>
			</div>
			<div class="ask-row3">
				<div class="form-area" align="center">
					<textarea id="question_content" name="question_content"></textarea>
				</div>
				<div class="ct-content2" style="vertical-align: top;">
					<div style="padding:1em 0em;">
						<button class="cs-call" type="button">1661-5959</button><br>
					</div>
					<div>
						월-일 10:00 ~ 18:00, 점심시간 12:00 ~ 13:00
					</div>
					<div style="padding:1em 0em;">
						<button class="cs-mail" type="button">cs_center@mystorage.kr</button>
					</div>
				</div>
			</div>
			<div class="bts">
				<button type="button" class="apply-btn" onclick="formCheck()">등록</button>&nbsp;&nbsp;
				<button type="button" class="back-btn" style="margin: 1em 0em;" onclick="location.href='myPageInfo'">돌아가기</button>
			</div>
		</div>
	</form>
</div>
<script>
// 문의 내역 그리드 생성
$(document).ready(function() {
	const Grid = tui.Grid;
	
	const myAskData = [
		<c:forEach items="${myAskList}" var="list" varStatus="status">
		
		{
			question_num: '${list.question_num}',
			store_name: '${list.store_name}',
			<c:choose>
				<c:when test="${empty list.question_title}">
					question_title: '제목이 없습니다.',
				</c:when>
				<c:otherwise>
					question_title: '${list.question_title}',
				</c:otherwise>
			</c:choose>
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
			header:  '문의 제목',
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
		console.log(myAsk);
		
		$.ajax({
			url: 'askSelect/'+myAsk,
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
			
			var q_code;
			var q_parents;
			var q_title;
			var q_content;
			var q_store;
			var q_date;
			var group_cnt;
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
				group_cnt = item.group_cnt;
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
						if(group_cnt > 1){
						row += '<tr><td style="padding: 0.3em;"><img src="resources/assets/images/re.png">&nbsp;답변 </td><td>' + q_date + '</td></tr>';
						row += '<tr style="border-bottom: 1px dashed lightgray;"><td colspan="2" style="padding: 0.3em;">' + q_content + '</td></tr>';
						}
						else {
							row += '<tr><td>아직 등록된 답변이 없습니다.</td></tr>';
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