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
		
	#tbl {
		white-space: pre;
	}
	
	.back-btn {
    	background-color: #006DFC;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		padding: 0.4em;
    }
    
    #askTitle {
    	margin: 2em 0em;
    }
    
    .apply-btn {
    	background-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-size: 10pt;
		font-weight: bold;
		padding: 0.4em;
		width: 6em;
		height: 3em;
    }
    
    textarea {
    	width: 100%;
    	height: 10em;
    	resize: none;
    	background: white;
    	border: 1px solid #5fd3e8;
    	border-radius: 0.3em;
    }
</style>
</head>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<body>
<div class="wrap">
	<h3>1:1문의 관리</h3>
	<div style="padding-bottom: 1em;" align="right">
		<button type="button" class="back-btn" onclick="location.href='${pageContext.request.contextPath }/home'">뒤로가기</button>
	</div>
	<div id="gridArea">
		<!-- 그리드 호출 -->
		<div id="customerAsk"></div>
	</div>
	<hr>
	<div id="askArea">
		<!-- 1:1문의 내역 상세 및 답글 등록 -->
		<form id="frm">
			<div id="askTitle"></div>
			<table id="tbl" width="100%"/>
		</form>
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
			question_date: '<fmt:formatDate value="${list.question_date}" pattern="yy-MM-dd" />',
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
				// 문의 띄워주는 거 내용 초기화 해버려
				$('#askTitle').empty();
				$('#tbl').empty();
				// 나타나라 문의문의
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
			
			var q_code, q_parents, q_title, q_content, q_date, title, group_cnt, member_id, q_group;
			
			$.each(data, function(idx, item) {
				console.log(item);
				console.log(idx);
				q_code = item.question_num;
				q_parents = item.question_parents;
				q_title = item.question_title;
				q_content = item.question_content;
				q_date = item.question_date;
				group_cnt = item.group_cnt;
				member_id = item.member_id;
				q_group = item.question_group;
				console.log(q_code, q_parents, q_title, q_content, q_date, group_cnt, member_id);
				
				title = '<h4>' + q_title + '</h4>';
				var row = '<tr>';
				if(q_parents == 1){
					row += '<th>글번호</th><td style="text-align: left; padding-left: 1em; width: 5em;">' + q_code + '</td>';
					row += '<th style="width: 4em;">작성자</th><td style="text-align: left;">' + member_id + '</td>'
					row += '<th style="text-align: right;">등록일</th><td>' + q_date + '</td></tr>';
					row += '<tr><td colspan="6" style="padding: 3em 0em; border-top: 1px lightgray solid; border-bottom: 1px lightgray solid;">' + q_content + '</td></tr>';
					if(group_cnt <= 1){
						row += '<tr><td colspan="6" style="padding: 2em 0em;"><b>아직 등록된 답변이 없습니다.</b></td></tr>';
						row += '<tr><input type="hidden" name="question_group" value="'+ q_group +'"/><td style="width: 3em;"><b>답변</b></td>'
						+ '<td colspan="4" style="padding: 2em 0em;"><textarea id="question_content" name="question_content"></textarea></td>'
						+'<td style="width: 8em;"><button id="answer" class="apply-btn" type="button">답글 등록</button></td></tr>';
					}
				} else {
					row += '<tr><td colspan="3" style="padding: 1em 2em; text-align: left;"><img src="resources/assets/images/re.png"></td><td colspan="3" style="padding: 0em 2em; text-align: right;">' + q_date +'</td></tr>';
					row += '<tr><td colspan="6" style="text-align: left; padding: 0em 2em;">' + q_content + '</td></tr>';
					row += '<tr><input type="hidden" name="question_group" value="'+ q_group +'"/><td style="width: 3em;"><b>답변</b></td>'
					+ '<td colspan="4" style="padding: 2em 0em;"><textarea id="question_content" name="question_content"></textarea></td>'
					+'<td style="width: 8em;"><button id="answer" class="apply-btn" type="button">답글 등록</button></td></tr>';
				}
				
				$('#tbl').append(row);
				if(idx == 0) {
					$('#askTitle').append(title);
				}
			}) // each 끝
			
			// 답변 등록
			$('#answer').on('click', function () {
				var data = $("form[id=frm]").serialize();
				console.log(data);
				
				if ($('#notice_content').val() == "") {
					alert("내용을 입력하세요.");
					frm.notice_content.focus();
					return false;
				}
				
				$.ajax({
					url: 'answerAsk',
					type: 'POST',
					data: data,
					success: function(result) {
						console.log(result);
						alert('답변이 등록되었습니다.');
						location.reload();
					},
					error: function(xhr, status, msg) {
						alert('답변 등록에 실패하였습니다. 상태값 : ' + status +' 에러메시지 : ' + msg);
					}
				})
			}) // 답변 등록 끝
		}	// showQuestion 끝
	})	// 더블클릭 이벤트 끝
})
</script>
</body>
</html>