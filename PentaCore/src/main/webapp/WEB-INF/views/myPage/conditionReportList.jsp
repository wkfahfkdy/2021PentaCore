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
		padding: 50px 30px;
	}
	
	#myReport {
        display: none;
        width: 60%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #myReport .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    #myReport .modal-body{
    	font-size: 10pt;
    }
    
   	.back-btn {
    	background-color: #006DFC;
		border-radius: 0.3em;
		color: white;
		font-size: 11pt;
		padding: 0.4em;
    }
</style>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
</head>
<body>
<div class="wrap">
	<div>
		<h3>Premium Service : 컨디션 보고서</h3>
	</div>
	<div id="reportGrid" align="center"></div>
	<div id="myReport">
		<a class="modal_close_btn">닫기</a>
		<div class="modal-body"></div>
	</div>	
	<div style="margin: 1em 0em;">
		<button class="back-btn" type="button" onclick="history.back();">돌아가기</button>
	</div>
</div>
<script>
// 보관 컨디션 보고서 그리드 생성
$(document).ready(function() {
	var list = '<c:out value="${reportList}"/>';
	
	const Grid = tui.Grid;
	
	const reportData = [
					<c:forEach items="${reportList}" var="list" varStatus="status">
					{
						condition_num: '${list.condition_num}',
						store_name: '${list.store_name}',
						condition_title: '${list.condition_title}',
						condition_date:'<fmt:formatDate value="${list.condition_date}" pattern="yyyy-MM-dd" />'
					}
					<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				]
	
	console.log(reportData);
	
	const reportGrid = new Grid({
		el : document.getElementById('reportGrid'),
		data: reportData,
		columns : [
			{
				header: '보고서 코드',
				name: 'condition_num',
				align: 'center',
				width: 100
			},
			{
				header: '이용 지점',
				name: 'store_name',
				align: 'center',
				width: 100
			},
			{
				header:  '제목',
				name: 'condition_title',
				align: 'center',
				width: 600
				
			},
			{
				header: '등록 날짜',
				name: 'condition_date',
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
	
	// Grid 컬럼 클릭 시 모달로 보고서 상세 조회 요청
	reportGrid.on('dblclick', function(ev) {
		var target = ev;
		
		var myReport = reportGrid.getValue(ev.rowKey,'condition_num');
		console.log(myReport);
		
		$.ajax({
			url: 'myReport/'+myReport,
			type: 'GET',
			dataType: 'json',
			success: function(result) {
				console.log(result);
				showReport(result);
			},
			error: function(xhr,status, msg) {
				alert("상태값 : "+status+" Http 에러메시지 : "+msg);
			}
		})
		
		function showReport(data) {
			modal('myReport');

			var rTitle = data.condition_title;	// 보고서 제목
			var rCode = data.condition_num;	// 보고서 코드
			var sName = data.store_name;	// 이용 지점 이름
			var rDate = data.condition_date;	// 보고서 업로드 날짜
			var uNum = data.use_num;	// 이용 중인 스토리지 번호
			var uStart = data.use_start;	// 이용 시작일
			var uEnd = data.use_end;	// 이용 만료일
			var oProduct = data.offer_product;	// 보관 중인 품목
			var rComment = data.condition_comment;	// 사진 및 코멘트

			var title = '${loginName}님의 ' + rTitle;
			
			var tbl =$('<table border="1" />');
			var row = '<tr>';
			row += '<td>' + '보고서 코드' + '</td>';
			row += '<td>' + rCode + '</td>';
			row += '<td>' + "이용 지점명" + '</td>';
			row += '<td>' + sName + '</td>';
			row += '<td>' + "보고서 등록일" + '</td>';
			row += '<td>' + rDate + '</td></tr>';
			row += '<tr><td>' + "이용 중인<br>스토리지 번호" + '</td>';
			row += '<td>' + uNum + '</td>';
			row += '<td>' + "이용 기간" + '</td>';
			row += '<td colspan="4">' + uStart + " ~ " + uEnd + '</td></tr>';
			row += '<tr><td>' + "보관 품목 정보" + '</td>';
			row += '<td colspan="6">' + oProduct + '</td></tr>';
			row += '<tr><td colspan="7">' + "상태 보고" + '</td></tr>';
			row += '<tr><td colspan="7">' + rComment + '</td></tr>';
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