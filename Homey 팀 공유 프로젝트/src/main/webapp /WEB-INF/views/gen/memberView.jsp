<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
.form-group {
	margin: 10px;
}
</style>
<c:if test="${!empty msg }">
   <script>
         alert('${msg}');
         console.log("${msg}");
   </script>
</c:if>
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
					<div class="form-group row">
					
						<label class="col-sm-3">아이디</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="mid" id="mid" value="${mvo.mid }" readonly>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-3">이름</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="mname" id="mname"
							value="${mvo.mname }"readonly>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-3">이메일</label>
						<div class="col-sm-6">
							<div class="input-group">
								<input type="text" id="email1" class="form-control" value="${mvo.memail }"readonly>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-3">주소</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="addr" id="addr"
						value="${mvo.maddr }"readonly>
						</div>
					</div>


					<div class="form-group row">
						<label class="col-sm-3">연락처</label>
						<div class="col-sm-5 ">
							<div class="input-group">
								<input type="text" name="phone1" id="phone1" 
									class="form-control" value="${mvo.mphone }"readonly>
							</div>
						</div>
					</div>
					<hr>
					<div class="form-group row text-center">
						<div class="col-sm-offset-2 col-sm-10">
							<form action="/gen/memberRemove" method="post">
							<a href="/gen/memberModify?mid=${mvo.mid }&pageNum=${param.pageNum}&amount=${param.amount}" type="button" class="btn btn-info" 
								id="register-button">회원 정보 수정하러 가기</a>
							<a href="/gen/pwModify" type="button" class="btn btn-warning" 
								id="register-button">비밀번호 수정하러 가기</a>
							<c:if test="${mvo.mid !='admin' }">
							<sec:authorize access="hasRole('ROLE_MEMBER')">
							<button type="button" class="btn btn-danger" id="memberRbtn">회원 탈퇴하기</button>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
							<button type="button" class="btn btn-danger" id="adminRbtn">회원정보 삭제</button>
							</sec:authorize>
							</c:if>
								 <a href="/gen/memberList?pageNum=${param.pageNum}&amount=${param.amount}" class="btn btn-secondary"  >뒤로가기</a>
						<input type="hidden" name="mid" value="${mvo.mid}">
						<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }">
						</form>
						</div>
					</div>
					
				</div>
				 <sec:authorize access="hasRole('ROLE_ADMIN')">
				<%@ include file="../includes/sideMenuAdm.jsp"%>
				</sec:authorize>
				 <sec:authorize access="hasRole('ROLE_MEMBER')">
				 <%@ include file="../includes/sideMenuMem.jsp"%>
				 </sec:authorize>
			</div>
			<!-- row g-5 -->
		</div>

	</section>
</main>
<!-- End Blog Details Section -->
<script>
$('#memberRbtn').click(function(){
    if(confirm('탈퇴 하시겠습니까?')) {
	$('form').submit();
    }
});
$('#adminRbtn').click(function(){
    if(confirm('삭제 하시겠습니까?')) {
    	 $('form').attr('action', '/gen/adminRemove'); // 새로운 URL로 액션 변경
    	$('form').submit();
    }
});
</script>
<%@ include file="../includes/footer.jsp"%>
