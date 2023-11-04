<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<style>
#loading {
	display: none;
	position: absolute;
	top: 10px;
	right: 10px;
}

.ateam {
	background-color: blue;
	border-color: blue;
}

.bteam {
	background-color: brown;
	border-color: brown;
}

.cteam {
	background-color: green;
	border-color: green;
}
</style>
<main id="main">
<c:if test="${!empty msg }">
			<script>
				alert('${msg}');
			</script>
		</c:if>
	<!-- ======= Breadcrumbs ======= -->
	<div class="breadcrumbs d-flex align-items-center"
		style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
		<div
			class="container position-relative d-flex flex-column align-items-center"
			data-aos="fade">

			<h2>Schedule</h2>


		</div>
	</div>
	<section id="projects" class="projects">
		<div class="container" data-aos="fade-up">
			<div class="row justify-content-between gy-4 mt-4">
				<div class="col-lg-9 mx-auto">
					<div id='loading'>loading...</div>
					<div id='calendar'></div>

				</div>
				<%@ include file="../includes/sideMenuAdm.jsp"%>
			</div>
		</div>
	</section>
</main>
<!-- fullCalendar -->
<link href="../resources/fullcalendar/main.css" rel="stylesheet" />
<script src="../resources/fullcalendar/main.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
	$(function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar: {
				left: 'prev,next today',
				center: "title",
				right: 'dayGridMonth,dayGridWeek'
			},
			initialView: 'dayGridMonth',
			locale: 'ko',
			timezone: 'UTC',
			firstDay: 1,
			weekends: true,
			selectable: true,
			selectMirror: true,
			editable: true,
			navLinks: true,
			loading: function(bool) {
				document.getElementById('loading').style.display = bool ? 'block' : 'none';
			},
			events: function(fetchInfo, successCallback, failureCallback) {
				$.ajax({
					url: '/sischedule/list',
					method: 'GET',
					dataType: 'json',
					success: function(data) {
						successCallback(data);
					},
					error: function() {
						failureCallback();
					}
				});
			},
			eventClick: function(info) {//팝업창으로 view를 보여주며 팝업이 닫히면 캘린더 업데이트
				var eventpk = info.event.extendedProps.sicheNo;
				var popupWindow = window.open('/sischedule/sicheView?sicheNo=' + eventpk, 'mywindow', 'width=600,height=600');
				var checkClosed = setInterval(function() {
					if (popupWindow.closed) {
						clearInterval(checkClosed);
						calendar.getEventSources()[0].refetch();
					}
				}, 500);
			},
			displayEventTime: false,
			eventClassNames: function(info) {
				var eventTitle = info.event.title;
				var classNames = [];
				if (eventTitle === 'A팀') {
					classNames.push('ateam');
				} else if (eventTitle === 'B팀') {
					classNames.push('bteam');
				} else {
					classNames.push('cteam');
				}
				return classNames;
			}
		});
		calendar.render();
	});
});
</script>
<!-- END fullCalendar -->

<%@ include file="../includes/footer.jsp"%>
