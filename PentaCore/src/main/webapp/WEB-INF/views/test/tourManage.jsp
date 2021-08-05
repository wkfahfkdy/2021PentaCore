<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/fullcanlendar/tui-calendar.css" />
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
<link href='resources/fullcanlendar/icons.css' rel='stylesheet' type="text/css"/>

</head>
<body>
<div id="menu" width="80%" height="80%">
  <span class="dropdown" style="display:none;">
      <span id="dropdownMenu-calendarType" class="btn btn-default btn-sm dropdown-toggle" type="label" data-toggle="dropdown"
      aria-haspopup="true" aria-expanded="true" disabled>
          <i id="calendarTypeIcon" class="calendar-icon ic_view_month" style="margin-right: 4px;"></i>
          <span id="calendarTypeName">Monthly</span>&nbsp;
          <i class="calendar-icon tui-full-calendar-dropdown-arrow"></i>
      </span>
      <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu-calendarType"></ul>
  </span>		            
    <span id="renderRange" class="render-range"></span>
    <span id="menu-navi">
	    <button type="button" class="btn btn-default btn-sm move-today" data-action="move-today">Today</button>
	    <button type="button" class="btn btn-default btn-sm move-day" data-action="move-prev">
	    	<i class="calendar-icon ic-arrow-line-left" data-action="move-prev"></i>
	    </button>
	    <button type="button" class="btn btn-default btn-sm move-day" data-action="move-next">
	    	<i class="calendar-icon ic-arrow-line-right" data-action="move-next"></i>
		</button>
	</span>
</div>
<div id="calendar"></div>


<script src="https://uicdn.toast.com/tui.code-snippet/v1.5.2/tui-code-snippet.min.js"></script>
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.min.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.min.js"></script>
<script src="resources/fullcanlendar/tui-calendar.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chance/1.0.13/chance.min.js"></script>
<script src="resources/fullcanlendar/calendars.js"></script>
<c:set var="bgcolor" value="<%=new String[]{\"#000080\", \"#05abf7\", \"#f70ca5\"}%>"></c:set>
<c:set var="fontcolor" value="<%=new String[]{\"#FFFFFF\", \"#FFFFFF\", \"#FFFFFF\"}%>"></c:set>
<script>
$(document).ready(function(){
	var cal, resizeThrottled;

	
	cal = new tui.Calendar(document.getElementById('calendar'), {
	    defaultView: 'week',
	    useCreationPopup: false,
	    useDetailPopup: false,
	    // calendars: CalendarList,
	});

	/*  
		예시
		[{
	        calendarId: '1',
	        title: '대구 중구 중앙로역 6번 출구',
	        category: 'time',
	        bgColor : '#bbdc00',
	        start: '2021-08-05T09:00:00+09:00',
	        end: '2021-08-05T18:00:00+09:00',
	        isReadOnly: true    // schedule is read-only
	    }]
	*/
	cal.createSchedules([
		<c:forEach items="${list}" var="list" varStatus="status">
			{
				calendarId: '${list.store_code}',
				title: '${list.member_name}',
				category: 'time',
				bgColor: '${bgcolor[status.index%3]}',
				color: '${fontcolor[status.index%3]}',
				start: '${list.start}',
				end: '${list.end}',
				isReadOnly: true
			}
			<c:if test="${not status.last}">,
			</c:if>
		</c:forEach>
		
	]);
})
</script>
	
</body>
</html>