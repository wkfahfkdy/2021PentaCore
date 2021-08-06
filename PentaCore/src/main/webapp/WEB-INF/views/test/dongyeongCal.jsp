<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/locales-all.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.css">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.js"></script>
    <script>
    $(document).ready(function() {
    	  var calendarEl = document.getElementById('calendar');
          var calendar = new FullCalendar.Calendar(calendarEl, {
              plugins: ['dayGrid', 'timeGrid', 'list', 'interaction'],
              header: {
                  left: 'prev,next today',
                  center: 'title',
                  right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
              },
              defaultView: 'timeGridWeek',
              locale: 'ko',
              navLinks: true, // can click day/week names to navigate views
              editable: true,
              allDaySlot: false,
              eventLimit: true, // allow "more" link when too many events
              minTime: '10:00:00',
              maxTime: '24:00:00',
              contentHeight: 'auto',
              eventSources: [{
                  events: function (info, successCallback, failureCallback) {
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
                  }
              }]
          });
          calendar.render();
    }
    </script>

</head>

<body>
    <div id='calendar' style="width:80;"></div>
</body>

</html>