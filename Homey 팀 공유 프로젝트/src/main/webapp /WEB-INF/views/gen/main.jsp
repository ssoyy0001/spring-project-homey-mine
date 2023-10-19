<%@ include file="../includes/header.jsp" %>
	<!-- ======= Hero Section ======= -->
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
				style="background-image: url(../resources/assets/img/hero-carousel/hero-carousel-1.jpg)"></div>
			<div class="carousel-item"
				style="background-image: url(../resources/assets/img/hero-carousel/hero-carousel-2.jpg)"></div>
			<div class="carousel-item"
				style="background-image: url(../resources/assets/img/hero-carousel/hero-carousel-3.jpg)"></div>
			<div class="carousel-item"
				style="background-image: url(../resources/assets/img/hero-carousel/hero-carousel-4.jpg)"></div>
			<div class="carousel-item"
				style="background-image: url(../resources/assets/img/hero-carousel/hero-carousel-5.jpg)"></div>

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
        showAlert(result + '번 견적상담이 등록되었습니다.');
    }
}

function showAlert(message) {
    alert(message);
}
// END 결과 확인 및 alert 표시
</script>
<!-- ======= END script ======= -->