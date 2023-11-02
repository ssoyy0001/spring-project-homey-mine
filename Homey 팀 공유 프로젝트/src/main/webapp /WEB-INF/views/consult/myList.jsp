<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>견적상담 전체 조회</title>
<style type="text/css">
/* 현재 클릭된 페이징 버튼 */
.custom-pagination .page-item.active .page-link {
	border-color: #ffc107;
	background-color: #ffc107;
	color: black;
}

/* 비활성 버튼 스타일 */
.custom-pagination .page-item .page-link {
	border-color: #ffc107;
	background-color: white;
	color: #ffc107;
}
/* 페이징 버튼 가운데 정렬 */
.pagination {
	justify-content: center;
	margin-top: 10px;
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
				<h2>
					<a href="/consult/list">나의 견적상담 전체 조회</a>
				</h2>
				<!-- 클릭시 초기 리스트로 -->
			</div>
		</div>
		<!-- End Breadcrumbs -->

		<!-- ======= 견적상담 전체 조회 표시 구간 ======= -->
		<section id="services" class="services section-bg blog">
			<!-- blog를 추가해야 사이드바 스타일 활성화  -->
			<div class="container" data-aos="fade-up">
				<div class="row g-3">

					<!-- 등록된 게시물이 없을 시 -->
					<c:if test="${empty consultList}">
						<div class="col" align="center">
							<p class="alert alert-warning p-5">등록된 게시물이 없습니다.</p>
						</div>
					</c:if>

					<!-- 반복될 구간 -->
					<c:forEach items="${consultList}" var="cvo">
						<!-- 컨트롤러 model에 담은 이름 그대로 -->
						<div class="col-lg-4 col-md-6 move" data-aos="fade-up"
							data-aos-delay="100">
							<div class="service-item  position-relative">
								<div class="icon">
									<i class="fa-solid fa-mountain-city"></i>
								</div>
								<h3>${cvo.buildingType},${cvo.address}</h3>
								<!-- 제목 -->
								<p>견적 상담 번호 : ${cvo.consultNo}</p>
								<p>
									견적 신청 날짜 :
									<fmt:formatDate value="${cvo.consultDate}" pattern="yyyy-MM-dd" />
								</p>
								<a href="/consult/consultManage?consultNo=${cvo.consultNo}"
									class="readmore stretched-link"
									data-consultno="${cvo.consultNo}">상세조회 <i
									class="bi bi-arrow-right"></i></a>
								<!-- data-consultno : 상세 조회 값 보내야할 견적상담번호 표시-->
							</div>
						</div>
						<!-- End Service Item -->
					</c:forEach>
					<!-- 반복될 구간 END -->


					<!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
					<form action="/consult/myList" id="actionFrm"></form>

					<%@ include file="../includes/sideMenuMem.jsp"%>
				</div>
			</div>
		</section>
		<!-- End 견적상담 전체 조회 표시 구간  -->
	</main>
	<!--======= END main ======= -->

	<!-- ======= script ======= -->
	<script>
		// consult/consultManage에서 견적상담 삭제 및 수정 성공 시 처리결과 alert창 표시 ----------------
		$(document).ready(function() { // 페이지 로드하자마자
			var resultD = '${resultD}';
			var resultM = '${resultM}';

			checkResult(resultD, '삭제'); //뒤에오는게 action
			checkResult(resultM, '수정');
		});

		function checkResult(result, action) {
			if (result) {
				showAlert(result + '번 견적상담이 ' + action + '되었습니다.');
			}
		}

		function showAlert(message) {
			alert(message);
		}
		// END 결과 확인 및 alert 표시

		$(function() {
			//58번 라인부터 하나의 견적상담 내용 클릭 시 이벤트 처리(상세조회로 보낼 값) -----------------------
			$('.move')
					.on(
							'click',
							function(e) {
								e.preventDefault();
								const consultNo = $(this).find('.readmore')
										.data('consultno');

								//hidden 태그를 생성하여 이름을 consultNo로 지정하고
								// 클릭한 요소의 "data-consultno" 값을 추가
								actionFrm
										.append("<input type='hidden' name='consultNo' value='" + consultNo + "'>");

								actionFrm.attr('action',
										'/consult/consultManage');

								actionFrm.submit();
							});
			//END 하나의 견적상담 내용 클릭 시 이벤트 처리-------------------

			//페이징 이벤트 처리 ------------------------------
			var actionFrm = $('#actionFrm');

			$('.page-item a').on(
					'click',
					function(e) {
						e.preventDefault();

						//a 태그의 href 값을 pageNum에 저장
						actionFrm.find("input[name='pageNum']").val(
								$(this).attr('href'));

						actionFrm.submit();
					});
			//END 페이징 이벤트 처리 ------------------------------
		});//END $
	</script>
	<!-- ======= END script ======= -->


	<!-- ======= Footer ======= -->
	<%@ include file="../includes/footer.jsp"%>

	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
	<div id="preloader"></div>
	<!-- Vendor JS Files -->
	<script
		src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="../resources/assets/vendor/aos/aos.js"></script>
	<script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script
		src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script
		src="../resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
	<script src="../resources/assets/vendor/php-email-form/validate.js"></script>
	<!-- Template Main JS File -->
	<script src="../resources/assets/js/main.js"></script>
	<!-- ======= END Footer ======= -->

</body>
</html>
