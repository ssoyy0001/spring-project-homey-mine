<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	<!-- ======= Hero Section ======= -->
<c:if test="${!empty msg }">
	<script>
			alert('${msg}');
	</script>
</c:if>
	<section id="hero" class="hero">
		<div class="info d-flex align-items-center">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-lg-6 text-center">
						<h2 data-aos="fade-down">
							Welcome to <span>HOMEY</span>
						</h2>
					</div>
				</div>
			</div>
		</div>

		<div id="hero-carousel" class="carousel slide" data-bs-ride="carousel"
			data-bs-interval="5000">

			<div class="carousel-item active"
				style="background-image: url(https://cdn.pixabay.com/photo/2017/03/28/12/10/chairs-2181947_1280.jpg"></div>
			<div class="carousel-item"
				style="background-image: url(https://cdn.pixabay.com/photo/2020/05/25/17/54/library-5219747_1280.jpg)"></div>
			<div class="carousel-item"
				style="background-image: url(https://cdn.pixabay.com/photo/2017/03/28/12/16/chairs-2181980_1280.jpg)"></div>
			<div class="carousel-item"
				style="background-image: url(https://cdn.pixabay.com/photo/2019/03/08/20/17/kitchen-4043098_1280.jpg)"></div>
			<div class="carousel-item"
				style="background-image: url(https://cdn.pixabay.com/photo/2020/02/02/17/07/living-room-modern-tv-4813591_1280.jpg)"></div>

			<a class="carousel-control-prev" href="#hero-carousel" role="button"
				data-bs-slide="prev"> <span
				class="carousel-control-prev-icon bi bi-chevron-left"
				aria-hidden="true"></span>
			</a> <a class="carousel-control-next" href="#hero-carousel" role="button"
				data-bs-slide="next"> <span
				class="carousel-control-next-icon bi bi-chevron-right"
				aria-hidden="true"></span>
			</a>
		</div>

	</section>
	<!-- End Hero Section -->

<%@ include file="../includes/footer.jsp" %>

<!-- ======= script ======= -->
<script>
// 하영 : consult/register에서 견적상담 등록 성공 시 처리결과 alert창 표시 ----------------
// 페이지 로드 시 alert로 확인
$(document).ready(function () {
    var result = '${result}';
    checkResult(result);
});

function checkResult(result) {
    if (result) {
        showAlert('견적상담이 등록되었습니다.\n 예정시간에 해피콜을 기다려주세요. \n 자세한 사항은 견적상담 내역 조회를 통해 확인해주시길 바랍니다.');
    }
}

function showAlert(message) {
    alert(message);
}
// END 결과 확인 및 alert 표시
</script>
<!-- ======= END script ======= -->
