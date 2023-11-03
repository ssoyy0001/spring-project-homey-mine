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
			<div class="row justify-content-between gy-4 mt-4">
					<div class="col-lg-8 mx-auto">
				
					<form action="/gen/memberModify" method="post" class="form-horizontal">
						<div class="form-group row">

							<label class="col-sm-2">아이디</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="mid" id="mid"
									value="${mvo.mid }" readonly>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-2">이름</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="mname" id="mname"
									value="${mvo.mname }">
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-2">이메일</label>
							<div class="col-sm-6">
								<div class="input-group">
									<input type="text" id="memail1" name="memail" class="form-control"
										value="${mvo.memail }">
								</div>
							</div>
						</div>

						<div class="form-group row">
							<label class="col-sm-2">주소</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" name="maddr" id="maddr"
									value="${mvo.maddr }">
							</div>
							<div class="col-sm-2">
										<input type="button" class="btn btn-outline-secondary"
											value="검색" onclick="execDaumPostcode()">
							</div>
						</div>
						<div id="wrap"
									style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
									<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
										id="btnFoldWrap"
										style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
										onclick="foldDaumPostcode()" alt="접기 버튼">
								</div>
								<!-- end 카카오 주소 api  -->


						<div class="form-group row">
							<label class="col-sm-2">연락처</label>
							<div class="col-sm-3 ">
								<div class="input-group">
									<input type="text" name="mphone" id="mphone"
										class="form-control" value="${mvo.mphone }">
								</div>
							</div>
						</div>
						<div class="form-group row text-center">
							<div class="col-sm-offset-2 col-sm-10">
							<hr>
								<input type="submit" class="btn btn-warning" value="회원 정보 수정"
									id="register-button"> <input type="button" class="btn btn-secondary"
									onclick="history.back()" value="취소">
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }">
					<input type="hidden" name="pageNum" value="${param.pageNum}">
					<input type="hidden" name="amount"  value="${param.amount}">
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//카카오 주소 API -----------------------------------------
// 우편번호 찾기 찾기 화면을 넣을 element
   var element_wrap = document.getElementById('wrap');

   function foldDaumPostcode() {
       // iframe을 넣은 element를 안보이게
       element_wrap.style.display = 'none';
   }

   function execDaumPostcode() {
       // 현재 scroll 위치를 저장
       var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
       new daum.Postcode({
           oncomplete: function(data) {
               // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기
               var addr = ''; // 주소 변수
               var extraAddr = ''; // 참고항목 변수

               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져옴
               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                   addr = data.roadAddress;
               } else { // 사용자가 지번 주소를 선택했을 경우(J)
                   addr = data.jibunAddress;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣음

               document.getElementById("maddr").value = addr;
               // 커서를 상세주소 필드로 이동

               // iframe을 넣은 element를 안보이게 함
               // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않음
               element_wrap.style.display = 'none';

               // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌림
               document.body.scrollTop = currentScroll;
           },
           // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성. iframe을 넣은 element의 높이값을 조정
           onresize : function(size) {
               element_wrap.style.height = size.height+'px';
           },
           width : '100%',
           height : '100%'
       }).embed(element_wrap);

       // iframe을 넣은 element를 보이게 함.
       element_wrap.style.display = 'block';
   }
//END 카카오 주소 API -----------------------------------------
</script>
