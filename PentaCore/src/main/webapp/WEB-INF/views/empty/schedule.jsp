<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- fullCalendar  -->
<link href="${pageContext.request.contextPath}/resources/full/css/mobiscroll.jquery.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/full/js/mobiscroll.jquery.min.js"></script>
<style>
	td {
		height: 30px;
	}

	#my_offer {	/*모달창*/
        display: none;
        width: 30%;
        padding: 30px 20px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #my_offer .modal_close_btn {	/*모달창 닫기버튼*/
        position: absolute;
        top: 20px;
        right: 20px;
        cursor: pointer;
        color: #cecece;
    }
    
    #cancel {	/*모달 신청 취소 버튼*/
    	background: #00c0e2;
    	border-radius: 0.3em;
    	color: white;
    	padding: 8px;
    }
    
    .comment {	/*모달 내용 작은 코멘트*/
    	font-size:9pt;
    	color:#00c0e2;
    	margin: 0 0 0;
    }
    
    .mo-tbl {	/*모달 테이블 내용*/
    	padding: 3px;
    }
</style>
</head>
<body>
<!-- fullCalendar -->
<div align="center" style=" padding-bottom:100px"> 
	<div id="demo-desktop-month-view"></div>
</div>
<div id="my_offer" align="center">
  	<a class="modal_close_btn"> 
  		<div style="border: 2px solid #cecece; border-radius:3px; width: 22px;"><b>X</b></div></a>
    <div class="modal-header"></div>
    <div class="modal-body"></div>
</div>
<!-- jstl 추가하기 -->
<!-- 색상 추가해야함. 3개 너무 적음 // 추가할 시 calendar2.jsp에도 같이 추가 -->
<c:set var="bgcolor" value="<%=new String[]{\"#fdec94\", \"#bde5fe\", \"#f9bdbd\" }%>"></c:set>
<script>

mobiscroll.setOptions({
    theme: 'ios',
    themeVariant: 'light',
    clickToCreate: false,
    dragToCreate: false,
    dragToMove: false,
    dragToResize: false
});

$(function(){
	var inst = $('#demo-desktop-month-view').mobiscroll().eventcalendar({
	    width: '80%',
	    height: '700px',
	    view: {
	        calendar: { labels: true }
	    },
	    onEventClick: function (event, inst) {
	    	modal('my_offer');
			var tbl =$('<table />');
			var row = '<tr>';
			row += '<td>'+event.event.store+'</td></tr>';
			row += '<td>'+event.event.addr1+'</td></tr>';
			row += '<td>'+event.event.addr2+'</td></tr>';
			row += '<td>'+event.event.driver+'</td></tr>';
			row += '<td>'+event.event.memo+'</td></tr>';
			row += '<td>'+event.event.time+'</td></tr>';
			
			tbl.append(row);
			$(".modal-body").append(tbl);
	    },
	    data: [
			<c:forEach items="${list}" var="list" varStatus="status">
			{
				start: '${list.start}',
				end: '${list.end}',
				title: '${list.member_name}',
				color: '${bgcolor[status.index%3]}',
				// 아래부터는 커스텀 변수
				store: '지점 : ' + '${list.store_name}',
				addr1: '운송 전 주소지 : ' + '${list.convey_before}',
				addr2: '운송 후 주소지 : ' + '${list.convey_after}',
				driver: '기사 : ' + '${list.convey_driver}',
				memo: '특이사항 : ' + '${list.convey_memo}',
				time: '시간 : ' + '${list.start}'.substr(11,16) + ' ~ ' + '${list.end}'.substr(11,16)
			}
			<c:if test="${not status.last}">,
			</c:if>
		</c:forEach>
		]
	    
	});
})
	
//Modal 세부 함수			
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
</script>
</body>
</html>