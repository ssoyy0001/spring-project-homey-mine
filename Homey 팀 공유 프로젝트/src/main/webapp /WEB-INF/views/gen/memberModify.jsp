<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
.form-group {
	margin: 10px;
}
</style>
<div class="breadcrumbs d-flex align-items-center"
	style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
	<div
		class="container position-relative d-flex flex-column align-items-center"
		data-aos="fade">

		<h2>My information</h2>

	</div>
</div>
<!-- End Breadcrumbs -->
<main id="main">
	<!-- ======= Blog Details Section ======= -->
	<section id="blog" class="blog">
		<div class="container " data-aos="fade-up" data-aos-delay="100">
			<div class="row g-5 ">
				<div class="col-lg-8">
					<form action="/gen/memberModify" method="post" class="form-horizontal">
						<div class="form-group row">

							<label class="col-sm-3">아이디</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="mid" id="mid"
									value="${mvo.mid }" readonly>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-3">이름</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="mname" id="mname"
									value="${mvo.mname }">
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-3">이메일</label>
							<div class="col-sm-6">
								<div class="input-group">
									<input type="text" id="memail1" name="memail" class="form-control"
										value="${mvo.memail }">
								</div>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-3">주소</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="maddr" id="maddr"
									value="${mvo.maddr }">
							</div>
						</div>


						<div class="form-group row">
							<label class="col-sm-3">연락처</label>
							<div class="col-sm-5 ">
								<div class="input-group">
									<input type="text" name="mphone" id="mphone"
										class="form-control" value="${mvo.mphone }">
								</div>
							</div>
						</div>
						<div class="form-group row text-center">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="submit" class="btn btn-info" value="회원 정보 수정"
									id="register-button"> <input type="button" class="btn btn-secondary"
									onclick="history.back()" value="취소">
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }">
					</form>
				</div>
				<%@ include file="../includes/sideMenuAdm.jsp"%>
			</div>
			<!-- row g-5 -->
		</div>

	</section>
</main>
<!-- End Blog Details Section -->

<%@ include file="../includes/footer.jsp"%>
