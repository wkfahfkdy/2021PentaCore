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
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
<link rel="stylesheet" type="text/css" href="resources/fullcanlendar/tui-calendar.css" />
<link href='resources/fullcanlendar/default.css' rel='stylesheet' type="text/css"/>
<link href='resources/fullcanlendar/icons.css' rel='stylesheet' type="text/css"/>
</head>
<body>
<div align="center" style="min-height:890px">
	
	   <div id="lnb">
	       <div class="lnb-new-schedule">
	           <button id="btn-new-schedule" type="button" class="btn btn-default btn-block lnb-new-schedule-btn" data-toggle="modal">
	               New schedule</button>
	       </div>
	       <div id="lnb-calendars" class="lnb-calendars">
	           <div>
	               <div class="lnb-calendars-item">
	                   <label>
	                       <input class="tui-full-calendar-checkbox-square" type="checkbox" value="all" checked>
	                       <span></span>
	                       <strong>View all</strong>
	                   </label>
	               </div>
	           </div>
	           <div id="calendarList" class="lnb-calendars-d1">
	           </div>
	       </div>
	       <div class="lnb-footer">
	           © NHN Corp.
	       </div>
	   </div>
	   <div id="right">
	       <div id="menu">
	           <span class="dropdown">
	               <button id="dropdownMenu-calendarType" class="btn btn-default btn-sm dropdown-toggle" type="button" data-toggle="dropdown"
	                   aria-haspopup="true" aria-expanded="true">
	                   <i id="calendarTypeIcon" class="calendar-icon ic_view_month" style="margin-right: 4px;"></i>
	                <span id="calendarTypeName">Dropdown</span>&nbsp;
	                <i class="calendar-icon tui-full-calendar-dropdown-arrow"></i>
	            </button>
	            <ul class="dropdown-menu2" role="menu" aria-labelledby="dropdownMenu-calendarType">
	                <li role="presentation">
	                    <a class="dropdown-menu2-title" role="menuitem" data-action="toggle-daily">
	                        <i class="calendar-icon ic_view_day"></i>Daily
	                    </a>
	                </li>
	                <li role="presentation">
	                    <a class="dropdown-menu2-title" role="menuitem" data-action="toggle-weekly">
	                        <i class="calendar-icon ic_view_week"></i>Weekly
	                    </a>
	                </li>
	                <li role="presentation">
	                    <a class="dropdown-menu2-title" role="menuitem" data-action="toggle-monthly">
	                        <i class="calendar-icon ic_view_month"></i>Month
	                    </a>
	                </li>
	                <li role="presentation">
	                    <a class="dropdown-menu2-title" role="menuitem" data-action="toggle-weeks2">
	                        <i class="calendar-icon ic_view_week"></i>2 weeks
	                    </a>
	                </li>
	                <li role="presentation">
	                    <a class="dropdown-menu2-title" role="menuitem" data-action="toggle-weeks3">
	                        <i class="calendar-icon ic_view_week"></i>3 weeks
	                    </a>
	                </li>
	                <li role="presentation" class="dropdown-divider"></li>
	                <li role="presentation">
	                    <a role="menuitem" data-action="toggle-workweek">
	                        <input type="checkbox" class="tui-full-calendar-checkbox-square" value="toggle-workweek" checked>
	                        <span class="checkbox-title"></span>Show weekends
	                    </a>
	                </li>
	                <li role="presentation">
	                    <a role="menuitem" data-action="toggle-start-day-1">
	                        <input type="checkbox" class="tui-full-calendar-checkbox-square" value="toggle-start-day-1">
	                        <span class="checkbox-title"></span>Start Week on Monday
	                    </a>
	                </li>
	                <li role="presentation">
	                    <a role="menuitem" data-action="toggle-narrow-weekend">
	                        <input type="checkbox" class="tui-full-calendar-checkbox-square" value="toggle-narrow-weekend">
	                        <span class="checkbox-title"></span>Narrower than weekdays
	                    </a>
	                </li>
	            </ul>
	        </span>
	        <span id="menu-navi">
	            <button type="button" class="btn btn-default btn-sm move-today" data-action="move-today">Today</button>
	            <button type="button" class="btn btn-default btn-sm move-day" data-action="move-prev">
	                <i class="calendar-icon ic-arrow-line-left" data-action="move-prev"></i>
	            </button>
	            <button type="button" class="btn btn-default btn-sm move-day" data-action="move-next">
	                <i class="calendar-icon ic-arrow-line-right" data-action="move-next"></i>
	            </button>
	        </span>
	        <span id="renderRange" class="render-range"></span>
	    </div>
	    <div id="calendar"></div>
	</div>
</div>
    
<script src="https://uicdn.toast.com/tui.code-snippet/v1.5.2/tui-code-snippet.min.js"></script>
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.min.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.min.js"></script>
<script src="resources/fullcanlendar/tui-calendar.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chance/1.0.13/chance.min.js"></script>
<script src='resources/fullcanlendar/calendars.js'></script>
<script src='resources/fullcanlendar/schedules.js'></script>
<script src='resources/fullcanlendar/app.js'></script>
</body>
</html>