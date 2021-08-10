<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		
	#askArea {
		margin-top: 2em;
		padding: 1em;
	}
	
	.back-btn {
    	background-color: #006DFC;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
    
    #askTitle {
    	margin: 2em 0em;
    }
</style>
</head>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<body>
<div class="wrap">
	<h3>1:1문의 관리</h3>
	<div style="padding-bottom: 1em;" align="right">
		<button type="button" class="back-btn">뒤로가기</button>
	</div>
	<div id="gridArea">
		<!-- 그리드 호출 -->
		<div id="customerAsk"></div>
	</div>
	<hr>
	<div id="askArea">
		<!-- 1:1문의 내역 상세 및 답글 등록 -->
		<div id="askTitle"></div>
		<table id="tbl" width="100%"/>
	</div>
</div>
<script>
// 지점별 1:1문의 그리드 생성
$(document).ready(function() {
	const Grid = tui.Grid;
	
	const ctAskData = [
		<c:forEach items="${customerAskList}" var="list" varStatus="status">
		
		{
			question_num: '${list.question_num}',
			question_title: '${list.question_title}',
			question_date: '${list.question_date}',
		}
			<c:if test="${not status.last}">,</c:if>
			</c:forEach>
		]
		
		console.log(ctAskData);
		
		const customerAsk = new Grid({
		el : document.getElementById('customerAsk'),
		data: ctAskData,
		columns : [
		{
			header: '글번호',
			name: 'question_num',
			align: 'center',
			width: 100
		},
		{
			header: '문의 제목',
			name: 'question_title',
			align: 'center',
		},
		{
			header: '작성일',
			name: 'question_date',
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
	
	// 그리드 컬럼 더블 클릭시 고객 문의글 가지고 옴
	customerAsk.on('dblclick', function(ev) {
		var target = ev;
		var qNum = customerAsk.getValue(ev.rowKey, 'question_num');
		console.log(qNum);
		
		$.ajax({
			url: 'custormerAskSelect/' + qNum,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				console.log(result);
				showQuestion(result);
			},
			error: function(xhr, status, msg) {
				alert("상태값 : " + status + " Http 에러메시지 : " + msg);
			}
		})
		
		$('#askArea').hide();
		function showQuestion(data) {
			// 나타나라 문의문의
			$('#askArea').show();
			
			var q_code, q_parents, q_title, q_content, q_date, title;
			
			$.each(data, function(idx, item) {
				console.log(item);
				console.log(idx);
				q_code = item.question_num;
				q_parents = item.question_parents;
				q_title = item.question_title;
				q_content = item.question_content;
				q_date = item.question_date;
				console.log(q_code, q_parents, q_title, q_content, q_date);
				
				title = '<h4>' + q_title + '</h4>';
				var row = '<tr>';
				if(q_parents == 1){
					row += '<th>글번호</th><td>' + q_code + '</td>';
					row += '<th>등록일</th><td>' + q_date + '</td></tr>';
					row += '<tr><td colspan="4">' + q_content + '</td></tr>';
				} else {
					if(q_content != null){
						row += '<tr><td><img src="resources/assets/images/re.png">&nbsp;답변</td><td>' + q_date +'</td></tr>';
						row += '<tr><td>' + q_content + '</td></tr>';
					} else {
						row += '<tr><td>아직 등록된 답변이 없습니다.</td></tr>';
					}
				}
				row += '<td colspan="3"><textarea id="question_content" name="qustion_content"></textarea></td>'
					+'<td><button id="apply-btn">답글 등록</button></td></tr>';
					
				$('#tbl').append(row);
				if(idx == 0) {
					$('#askTitle').append(title);
				}
			}) // each 끝
		}	// showQuestion 끝
	})	// 더블클릭 이벤트 끝
})
</script>
</body>
</html>