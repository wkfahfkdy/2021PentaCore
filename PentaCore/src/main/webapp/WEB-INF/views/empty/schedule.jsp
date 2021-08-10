<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html> <head> <meta charset="UTF-8">
<!-- fullCalendar  -->
<link href="resources/full/css/mobiscroll.javascript.min.css" rel="stylesheet" />
<script src="resources/full/js/mobiscroll.javascript.min.js"></script>
<style>

	.cal {
		padding-top: 2%;
	}

</style>
</head>
<body>
<!-- fullCalendar -->
<div class="cal" align="center" style=" padding-bottom:100px"> 
	<div><h3>스케줄관리</h3></div> <br>
	<div id="demo-desktop-month-view"></div>
</div>
<!-- jstl 추가하기 -->
<!-- 색상 추가해야함. 3개 너무 적음 // 추가할 시 calendar2.jsp에도 같이 추가 -->
<c:set var="bgcolor" value="<%=new String[]{\"#000080\", \"#05abf7\", \"#f70ca5\"}%>"></c:set>
<script>
	var inst = mobiscroll.eventcalendar('#demo-desktop-month-view', {
	    theme: 'ios',
	    themeVariant: 'light',
	    clickToCreate: false,
	    dragToCreate: false,
	    dragToMove: false,
	    dragToResize: false,
	    width: '80%',
	    height: '700px',
	    view: {
	        calendar: { labels: true }
	    },
	    onEventClick: function (event, inst) {
	    	// 모달창 같은 기능
	    	mobiscroll.confirm({
	    		title: event.event.title,
	    		// <br> 같은 태그 안먹힘
	    		message: event.event.start + ' ~ ' + event.event.end
	    	});
	    },
	    
	});
</script>
</body>
</html>