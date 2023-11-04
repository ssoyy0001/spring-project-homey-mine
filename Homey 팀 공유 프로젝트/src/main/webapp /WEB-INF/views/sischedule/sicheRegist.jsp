<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시공작업스케줄</title>

<style>
#odTitleBox {
	border: 2px solid #FFA500; /* 진노랑색 테두리 */
	padding: 10px; /* 텍스트와 테두리 사이의 간격을 10px로 지정 */
}

.regiItemNm {
	width: 150px;
	font-weight: bold;
}

.regiItem {
	width: 200px;
	border: none; /* 테두리 없음 */
	outline: none; /* 포커스 표시 없음 */
}

.imgNotice {
	font-size: 10px;
	color: lightcoral;
}

#odItem {
	margin-bottom: 20px;
}

#pvoImg {
	width: 40%;
	display: block;
	margin: auto;
} /* 띄울 사진 크기*/
.tags, p {
	color: #F44336;
}

.regiText {
	color: #FFA000;
}

.reqForm {
	background-color: #FFF8E1;
}

/* 원데이클래스 게시글 제목(링크)에 마우스 올리면 색상변화 */
.content a:hover {
	color: black;
}

/* 첨부파일 표시하는 li태그에 블릿 제거 */
li {
	list-style: none;
}

/* 첨부파일 크기 조절*/
.uploadResult ul li img {
	max-width: 100%; /* 이미지를 부모 요소 너비에 맞게 조절 */
	max-height: auto;
	display: block;
}

select {
	width: 130px;
}
</style>

</head>
<body>
	<!-- ======= header ======= -->
	<%@ include file="../includes/header.jsp"%>

	<!--======= main ======= -->
	<main id="main">

		<!-- ======= Breadcrumbs ======= -->
		<div class="breadcrumbs d-flex align-items-center"
			style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
			<div
				class="container position-relative d-flex flex-column align-items-center"
				data-aos="fade">
				<h2>Schedule Modify</h2>
			</div>
		</div>
		<!-- End Breadcrumbs -->

		<!-- 원데이클래스 신청완료 메시지가 있는 경우, qnaListAll.jsp로 돌아오면서 msg내용을 alert으로 띄우기 -->
		<c:if test="${!empty msg }">
			<script>
				alert('${msg}');
			</script>
		</c:if>

		<!-- ======= 원데이클래스 후기 상세조회 ======= -->

		<section id="blog" class="blog">
			<div class="container" data-aos="fade-up" data-aos-delay="100">
				<div class="row g-5">
					<div class="col-lg-8 mx-auto">
						<article class="blog-details">

							<h2 class="title">시공작업등록</h2>
							<br>
							<!-- ======= 상세내용이 표시되기 시작함 ======= -->
							<div class="content">
								<br>
								<form action="/sischedule/sicheRegist" method="POST" role="form"
									id="actionFrm">

									<!--------------------- 후기 상세조회 -------------------->
									<div class="form-group" id="odItem">
										<label class="regiItemNm">시공의뢰번호</label> <input type="number"
											name="sireqNo" value="${sireqVO.sireqNo }" readonly>
									</div>
									<div class="form-group" id="odItem">
										<label class="regiItemNm">견적서번호</label> <input type="number"
											name="quoNo" value="${sireqVO.quotationvo.quoNo}" readonly>
									</div>
									<div class="form-group" id="odItem">
										<label class="regiItemNm">의뢰인</label> <input type="text"
											name="mid" value="${sireqVO.mvo.mid}" readonly>
									</div>
									<div class="form-group" id="odItem">
										<label class="regiItemNm">잔금처리현황</label> <select
											name="balanceStatus">
											<option value="잔금처리대기">잔금처리대기</option>
											<option value="잔금처리완료">잔금처리완료</option>
										</select>

									</div>
									<div class="form-group" id="odItem">
										<label class="regiItemNm">시공진행현황</label> <select
											name="constructionStatus">
											<option value="착수전">착수전</option>
											<option value="진행중">진행중</option>
											<option value="중도취소">중도취소</option>
											<option value="시공완료">시공완료</option>
										</select>
									</div>
									<div class="form-group" id="odItem">
										<label class="regiItemNm">작업할 시공팀</label> <select
											name="workCrew" id="workCrew">
											<option value="A팀">A팀</option>
											<option value="B팀">B팀</option>
											<option value="C팀">C팀</option>
										</select>
									</div>
									<div class="form-group" id="odItem">
										<label class="regiItemNm">시공 일정</label> <input type="date"
											value="<fmt:formatDate value="${sireqVO.quotationvo.constScheduleStart}" pattern="yyyy-MM-dd" />"
											name="startDateStr">~ <input type="date"
											value="<fmt:formatDate value="${sireqVO.quotationvo.constScheduleEnd}" pattern="yyyy-MM-dd" />"
											name="endDateStr">
									</div>
									<div class="form-group" id="odItem">
										<label class="regiItemNm">주택유형</label> <input type="text"
											name="buildingType" value="${sireqVO.consultvo.buildingType}" readonly>
									</div>
									<br>
									<hr>
									<br> <input type="hidden" name="${_csrf.parameterName }"
										value="${_csrf.token }">
								</form>
							</div>
							<!-- End post content -->
						</article>
						<!-- End blog post -->
					</div>
				</div>
			</div>
		</section>
		<!-- End Blog Details Section -->
		<!-- 시큐리티 -->
		<div class="text-center" id="btn-group">
			<button type="button" class="btn btn-secondary"
				onclick="history.back()">뒤로가기</button>
			<input type="button" class="btn btn-warning" id="regiBtn" value="등록" />

		</div>
		<br> <br> <br>

	</main>
	<!-- End #main -->
	<script>
var csrfHeaderName = '${_csrf.headerName}';//csrf 토큰 관련 변수
var csrfTokenValue = '${_csrf.token}';

function openSchedule() {//등록시 스케줄을 보게하기 위함
	 window.open("/sischedule/sicheList", "schedule", "width=800,height=600");

};
openSchedule();

$("#regiBtn").on("click",function(e){
	e.preventDefault();
	var workcrew=$('#workCrew').val();
    var inputStartDate = new Date($("input[name=startDateStr]").val());
    var inputEndDate = new Date($("input[name=endDateStr]").val());
    var today = new Date(); // 오늘 날짜
     today.setHours(0,0,0,0); // 시간을 제거
    inputStartDate.setHours(0,0,0,0); 
    inputEndDate.setHours(0,0,0,0); 
    // 오늘 이후의 날짜만 등록할 수 있게
    if (inputStartDate <= today || inputEndDate <= today) {
        alert('오늘 날짜나 이전 날짜로는 예약할 수 없습니다.');
        return;
    }

    $.ajax({
        url: '/sischedule/checkDate', // 서버의 URL
        type: 'POST',
        data: { workCrew: workcrew }, // 'workcrew' 데이터를 서버로 보냅니다.
        dataType: "json",
        beforeSend: function(xhr) {
	        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	      },
        success: function(data, status, xhr) {

        for (var i = 0; i < data.length; i++) {
            // JSON 형식이므로, 직접 'start'와 'end' 값을 가져올 수 있습니다.
            var dbStartDate = new Date(data[i].start);
            var dbEndDate = new Date(data[i].end);
		dbStartDate.setHours(0,0,0,0);
		dbEndDate.setHours(0,0,0,0);
            if ((dbStartDate >= inputStartDate && dbStartDate <= inputEndDate) ||
                (dbEndDate >= inputStartDate && dbEndDate <= inputEndDate) ||
                (dbStartDate <= inputStartDate && dbEndDate >= inputEndDate)) {
                alert('해당 기간에는 다른 일정이 있습니다.');
                return;
            }

        }

        if(confirm('등록하시겠습니까?')){
            $("#actionFrm").submit();
        }
        },
        error: function(xhr, status,error) {
        	console.log(error);
        }
    });
	
});


</script>
	<%@ include file="../includes/footer.jsp"%>
