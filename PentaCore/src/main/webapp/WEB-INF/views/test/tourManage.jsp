<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<div id="menu">
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

<script>
var cal;

cal = new tui.Calendar(document.getElementById('calendar'), {
    defaultView: 'week',
    useCreationPopup: false,
    useDetailPopup: false,
    // calendars: CalendarList,


});

cal.createSchedules([
    {
        
        calendarId: '1',
        title: '대구 중구 중앙로역 6번 출구',
        category: 'time',
        bgColor : '#bbdc00',
        start: '2021-08-05T09:00:00+09:00',
        end: '2021-08-05T18:00:00+09:00',
        isReadOnly: true    // schedule is read-only
    }
]);


</script>

</body>
</html>