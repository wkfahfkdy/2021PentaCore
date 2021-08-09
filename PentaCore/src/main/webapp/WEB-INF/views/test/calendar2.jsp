<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- fullCalendar  -->
<link href="resources/full/css/mobiscroll.javascript.min.css" rel="stylesheet" />
<script src="resources/full/js/mobiscroll.javascript.min.js"></script>

</head>
<body>
<!-- jstl 추가하기 -->
<!-- fullCalendar -->
<div align="center" style=" padding-bottom:100px"> 
	<div id="demo-desktop-week-view""></div>
</div>
<div id="my_offer" align="center">
    <a class="modal_close_btn">닫기</a>
    <div class="modal-header"></div>
    <div class="modal-body"></div>
</div>
<!-- 색상 추가해야함. 3개 너무 적음 // 추가할 시 calendar.jsp에도 같이 추가 -->
<c:set var="bgcolor" value="<%=new String[]{\"#000080\", \"#05abf7\", \"#f70ca5\"}%>"></c:set>
<script>
var inst = mobiscroll.eventcalendar('#demo-desktop-week-view', {
    theme: 'ios',
    themeVariant: 'light',
    clickToCreate: true,
    dragToCreate: false,
    dragToMove: false,
    dragToResize: false,
    width: '80%',
    height:'700px',
    view: {
        schedule: { type: 'week' }
    },
    onEventClick: function (event, inst) {
    	// 모달창 같은 기능
    	mobiscroll.confirm({
    		title: event.event.title,
    		// <br> 같은 태그 안먹힘
    		message: event.event.start + ' ~ ' + event.event.end
    	});
    },
    data: [
		<c:forEach items="${list}" var="list" varStatus="status">
		{
			start: '${list.start}',
			end: '${list.end}',
			title: '${list.member_name}',
			color: '${bgcolor[status.index%3]}'
		}
		<c:if test="${not status.last}">,
		</c:if>
	</c:forEach>
	]
});

</script>
</body>
</html>