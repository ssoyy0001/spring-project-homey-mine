<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>견적상담 상세조회</title>
<style>
/* callout 문구 강조 */
#callout {background-color: #FFAF00; color: white; padding: 5px 5px 5px;
			border-radius: 40px 80px; width: 70%; text-align: center;}
/* 항목 label들 강조 */			
.col-sm-2 {font-weight: 600; color: gray;}
</style>
</head>
<body>
<!-- ======= header ======= -->
<%@ include file="../includes/header.jsp" %>

<!--======= main ======= -->
<main id="main">

<!-- ======= Breadcrumbs ======= -->
<div class="breadcrumbs d-flex align-items-center" style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
  <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
    <h2>견적상담 상세 조회</h2>
  </div>
</div><!-- End Breadcrumbs -->

	<!-- ======= Blog Details Section (견적상담 상세조회 + 그외의 것들 구역)======= -->
	<section id="blog" class="blog">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row g-3">
				<div class="col-lg-9">
				
		<!-- 견적 상담 상세조회  -->
			<article class="blog-details">
				<h2>견적 신청 내용</h2>
				<!-- 4개 항목 시작  --> <!-- https://icons.getbootstrap.com/ -->
				<section id="stats-counter" class="stats-counter" style="padding: 10px;">
		          <div class="container">
		           <div class="row gy-4">
		           
		           <!-- 견적상담번호 -->
		           	<div class="col-lg-3 col-md-6"> <!-- lg : 큰화면, md : 중간 화면 비율 -->
		            <div class="stats-item d-flex align-items-center w-100 h-100" style="padding: 5px; box-shadow: 0px 0 0px">
		              <i class="bi bi-emoji-smile color-blue flex-shrink-0"></i>
		              <div>
		              	<p>견적 상담 번호</p>
		                <span style="font-size: 20px" data-purecounter-start="0" data-purecounter-end="${cvo.consultNo}" data-purecounter-duration="1" class="purecounter"></span>
		              </div>
		            </div>
		           </div><!-- End 견적상담번호 -->
		           <!-- 평수 -->
		           	<div class="col-lg-3 col-md-6"> <!-- lg : 큰화면, md : 중간 화면 비율 -->
		            <div class="stats-item d-flex align-items-center w-100 h-100" style="padding: 5px; box-shadow: 0px 0 0px ">
		              <i class="bi bi-buildings color-blue flex-shrink-0"></i>
		              <div>
		              	<p>평수</p>
		                <span style="font-size: 20px" data-purecounter-start="0" data-purecounter-end="${cvo.pyeongsu}" data-purecounter-duration="1" class="purecounter"></span>
		              </div>
		            </div>
		           </div><!-- End 평수 -->
		           <!-- 예산 -->
		           	<div class="col-lg-3 col-md-6"> <!-- lg : 큰화면, md : 중간 화면 비율 -->
		            <div class="stats-item d-flex align-items-center w-100 h-100" style="padding: 5px; box-shadow: 0px 0 0px">
		              <i class="bi bi-cash-coin color-blue flex-shrink-0"></i>
		              <div>
		              	<p>예상 예산</p>
		                <span style="font-size: 20px" data-purecounter-start="0" data-purecounter-end="${cvo.budget}" data-purecounter-duration="1" class="purecounter"></span>
		              </div>
		            </div>
		           </div><!-- End 예산 -->
		           <!-- 처리현황 -->
		           	<div class="col-lg-3 col-md-6"> <!-- lg : 큰화면, md : 중간 화면 비율 -->
		            <div class="stats-item d-flex align-items-center w-100 h-100" style="padding: 5px; box-shadow: 0px 0 0px">
		              <i class="bi bi-headset color-blue flex-shrink-0"></i>
		              <div>
		              	<p>처리현황</p>
		                <span style="font-size: 17px">${cvo.status}</span>
		              </div>
		            </div>
		           </div><!-- End 처리현황 -->
		           
		           </div>
		          </div>
		        </section>
				<!-- END 4개 항목 시작-->
						<br>
						<div class="form-group row" style="margin-bottom: 10px"> 
								<label class="col-sm-2">아이디</label>
								<div class="col-sm-3"> ${cvo.mid} </div>
						</div>
						<div class="form-group row" style="margin-bottom: 10px"> 
								<label class="col-sm-2">견적 신청 날짜</label>
								<div class="col-sm-3"><fmt:formatDate value="${cvo.consultDate}" pattern="yyyy-MM-dd"/></div>
						</div>
						<div class="form-group row" style="margin-bottom: 10px"> 
								<label class="col-sm-2">연락처</label>
								<div class="col-sm-5">${cvo.mphone} </div>
						</div>
						<div class="form-group row" style="margin-bottom: 10px"> 
								<label class="col-sm-2">시공 주소</label>
								<div class="col-sm-6"><span>(</span>${cvo.postcode}<span>)&nbsp;</span>${cvo.address}<span>&nbsp;</span>${cvo.detailAddress}  </div>
						</div>
						<div class="form-group row" style="margin-bottom: 10px"> 
								<label class="col-sm-2">건물 유형</label>
								<div class="col-sm-5">${cvo.buildingType} </div>
						</div>						
						<div class="form-group row" style="margin-bottom: 10px"> 
								<label class="col-sm-2">공사 예정</label>
								<div class="col-sm-5">${cvo.scheduledDate} </div>
						</div>											
						<div class="form-group row" style="margin-bottom: 10px"> 
								<label class="col-sm-2">시공 항목</label>
								<div class="col-sm-5">
								    <!-- cvo에 담긴 item이 1이면 표시하고 쉼표 `,`로 구분 -->
								    <c:if test="${cvo.item.tiling == 1}">도배/벽</c:if>
								    
								    <c:if test="${cvo.item.flooring == 1}">
								        <c:if test="${cvo.item.tiling == 1}">, </c:if>바닥
								    </c:if>
								    
								    <c:if test="${cvo.item.kitchen == 1}">
								        <c:if test="${cvo.item.tiling == 1 or cvo.item.flooring == 1}">, </c:if>주방
								    </c:if>
								    
								    <c:if test="${cvo.item.bathroom == 1}">
								        <c:if test="${cvo.item.tiling == 1 or cvo.item.flooring == 1 or cvo.item.kitchen == 1}">, </c:if>욕실
								    </c:if>
								    
								    <c:if test="${cvo.item.entrance == 1}">
								        <c:if test="${cvo.item.tiling == 1 or cvo.item.flooring == 1 or cvo.item.kitchen == 1 or cvo.item.bathroom == 1}">, </c:if>현관
								    </c:if>
								    
								    <c:if test="${cvo.item.balcony == 1}">
								        <c:if test="${cvo.item.tiling == 1 or cvo.item.flooring == 1 or cvo.item.kitchen == 1 or cvo.item.bathroom == 1 or cvo.item.entrance == 1}">, </c:if>발코니
								    </c:if>
								    
								    <c:if test="${cvo.item.lighting == 1}">
								        <c:if test="${cvo.item.tiling == 1 or cvo.item.flooring == 1 or cvo.item.kitchen == 1 or cvo.item.bathroom == 1 or cvo.item.entrance == 1 or cvo.item.balcony == 1}">, </c:if>조명
								    </c:if>
								    
								    <c:if test="${cvo.item.door == 1}">
								        <c:if test="${cvo.item.tiling == 1 or cvo.item.flooring == 1 or cvo.item.kitchen == 1 or cvo.item.bathroom == 1 or cvo.item.entrance == 1 or cvo.item.balcony == 1 or cvo.item.lighting == 1}">, </c:if>문
								    </c:if>
								    
								    <c:if test="${cvo.item.etc == 1}">
								        <c:if test="${cvo.item.tiling == 1 or cvo.item.flooring == 1 or cvo.item.kitchen == 1 or cvo.item.bathroom == 1 or cvo.item.entrance == 1 or cvo.item.balcony == 1 or cvo.item.lighting == 1 or cvo.item.door == 1}">, </c:if>그 외
								    </c:if>
								</div>
						</div>						
						<div class="form-group row" style="margin-bottom: 10px"> 
								<label class="col-sm-2">해피콜 일시</label>
								<fmt:parseDate value="${cvo.happyCall}" pattern="yyyy-MM-dd'T'HH:mm" var="date" />
								<fmt:formatDate value="${date}" pattern="yyyy-MM-dd a h시 mm분" var="formattedDate" />
								<div class="col-sm-5">${formattedDate}</div>
								<!-- fmt :  2023-10-18T12:30  >> 2023-10-18 오후 12시 30분 -->
								
									<!-- 해피콜 희망 일시 수정  -->
									<form id="modifyHappyCallForm" action="/consult/modify" method="POST">
									<label class="col-sm-5" style="font-weight: bold;color: green;">수정할 해피콜 날짜와 시간을 선택하세요.
									  <input type="datetime-local"
									         id="happyCall"
									         name="newHappyCall"
									         value="${cvo.happyCall}"
									         oninput="validateDateTime(this)">
									</label>
									<button type="submit" class="btn btn-success col-sm-2">해피콜 수정</button>
									</form>
									<!-- END 해피콜 희망 일시 수정  -->
						</div>
									<div id="callout">
										해피콜 운영시간은 평일 9시 ~ 오후 5시입니다.
										<br>10분 단위로만 선택해주세요.
									</div>    
									<div id="callout" style="margin-top: 10px">
								 	견적 상담 신청 내용을 수정하고 싶으신 분들은 기존 접수 건을 취소 후
								 	<br>신규로 다시 접수해주세요.
									</div>	 
			</article>
			<!-- END 견적 상담 상세조회 -->
			
			<!-- 방문 실측 스케줄 -->
			<article class="blog-details">
			</article>
			<!-- END 방문 실측 스케줄 -->
	
			<!-- 견적서 -->
			<article class="blog-details">
			</article>
			<!-- END 견적서 -->
				
				<!-- 견적상담 신청 버튼-->
            	<div class="float-end" style="margin-top: 20px">
				<button type="button" class="btn btn-light"
						onclick="history.back()">
					이전으로</button>
				<button type="submit" class="btn btn-danger" id="submit">
					견적상담 취소</button>  
				<button type="submit" class="btn btn-danger" id="submit">
					견적상담 삭제</button>  
				</div>           
            	<!-- 시큐리티 -->
            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
            	<!-- 견적상담 신청 버튼 END-->
            	
				</div>		
 				<%@ include file="../includes/sideMenuAdm.jsp"%>
			</div>
			<!-- row g-5 -->
		</div>
	</section>
	<!-- End Blog Details Section -->

</main>
<!-- End #main -->

<!-- ======= Footer ======= -->
<%@ include file="../includes/footer.jsp"%>

  <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>
  <!-- Vendor JS Files -->
  <script src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../resources/assets/vendor/aos/aos.js"></script>
  <script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="../resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="../resources/assets/vendor/php-email-form/validate.js"></script>
  <!-- Template Main JS File -->
  <script src="../resources/assets/js/main.js"></script>
<!-- ======= END Footer ======= -->

<!-- ======= script ======= -->
<script>
//
document.getElementById('modifyHappyCallForm').addEventListener('submit', function(e) {
    e.preventDefault(); // 기본 폼 제출 동작을 막음

    var newHappyCall = document.getElementById('happyCall').value; // 새로운 해피콜 일정을 가져옴

    var formData = new FormData(this); // 폼 데이터 객체 생성

    // 폼 데이터에 새로운 해피콜 일정 추가
    formData.append('newHappyCall', newHappyCall);

    // 폼 데이터를 서버로 보냄
    fetch('/consult/modify', {
        method: 'POST',
        body: formData,
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'success') {
            alert('해피콜 일정이 수정되었습니다.');
        } else if (data === 'error') {
            alert('해피콜 일정 수정에 실패했습니다.');
        } else {
            alert('서버 응답: ' + data);
        }
    })
    .catch(error => {
        alert('오류 발생: ' + error);
    });
});

//


//해피콜 입력받을 때 조건 설정 함수 -------------------------
function validateDateTime(input) {
	// 입력된 날짜와 시간 가져오기
    var selectedDateTime = new Date(input.value);
    // 현재 날짜 가져오기
    var currentDate = new Date();
    
// 	<!-- 날짜와 시간에 대한 유효성 검사 -->
    if (isValidWeekday(selectedDateTime) && 
    	isValidTime(selectedDateTime) && 
    	isValidTimeRange(selectedDateTime) &&
    	isFutureDate(selectedDateTime, currentDate)) {
        // 유효한 경우, 아무 작업 없이 통과
    } else {
// 	<!-- 유효하지 않은 경우, 초기 값을 복구 (이전 유효한 값으로) -->
        input.value = "2023-10-18T12:30";
        alert("평일 9시~17시만 10분단위로 선택 가능하며, 미래 날짜만 선택 가능합니다.");
    }
}

function isValidWeekday(dateTime) {
	// 주말 (토요일: 6, 일요일: 0)이 아니라면 유효
    var day = dateTime.getDay();
    return day !== 0 && day !== 6;
}
function isValidTime(dateTime) {
	// 	분 단위가 10의 배수인 경우 유효
    var minutes = dateTime.getMinutes();
    return minutes % 10 === 0;
}
function isValidTimeRange(dateTime) {
    // 시간 범위가 9:00 AM부터 5:00 PM까지인 경우 유효
    var hours = dateTime.getHours();
    return hours >= 9 && hours <= 17;
}
function isFutureDate(selectedDateTime, currentDate) {
    // 선택한 날짜가 현재 날짜보다 미래인 경우 유효
    return selectedDateTime > currentDate;
}
// 해피콜 입력받을 때 조건 설정 함수 -------------------------
</script>
<!-- ======= END script ======= -->

</body>
</html>

