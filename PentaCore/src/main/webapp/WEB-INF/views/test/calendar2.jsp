<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--  
	테스트 변경사항 : dropdown-menu -> dropdown-menu2
			이유 : 기존 tiles - header 에서도 dropdown-menu 사용으로 인해서 css가 맞지않음
-->

<!-- 나중에 실제작 시 js 및 css 위치 변경 필요? -->
<link rel="stylesheet" type="text/css" href="resources/fullcanlendar/tui-calendar.css" />
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
<link href='resources/fullcanlendar/default.css' rel='stylesheet' type="text/css"/>
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
<script src='resources/fullcanlendar/app.js'></script>
</body>
</html>