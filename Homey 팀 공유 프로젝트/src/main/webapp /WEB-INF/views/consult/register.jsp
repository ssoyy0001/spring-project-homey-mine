<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>견적상담 등록</title>
</head>
<body>
<!-- ======= header ======= -->
<%@ include file="../includes/header.jsp" %>

<!--======= main ======= -->
<main id="main">

<!-- ======= Breadcrumbs ======= -->
<div class="breadcrumbs d-flex align-items-center" style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
  <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
    <h2>견적상담 등록</h2>
  </div>
</div><!-- End Breadcrumbs -->

 <!-- ======= Projet Details Section (견적상담 입력 폼)======= -->
    <section id="project-details" class="project-details">
      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row justify-content-between gy-4 mt-4">

          <div class="col-lg-8">
            <div class="portfolio-description">
             
              <!-- BUILDINGTYPE 선택 -->
              <h2>1. 어떤 건물을 인테리어 하실건가요?</h2>
				<div class="form-group">
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1">
				        아파트		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">
				        빌라		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">
				        주택
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">
				        오피스텔
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">
				        그 외 <input type="text" placeholder="건물 유형을 입력해주세요">
				    </label>
				</div>
				<hr>
				<br>
              <!-- BUILDINGTYPE 선택 END -->
              <!-- PYEONGSU -->
              <h2>2. 시공할 건물의 평수를 입력해주세요.</h2>
				<input type="text" placeholder="숫자만 입력해주세요"> 평 <br>
			  <hr>
              <br>
              <!-- PYEONGSU END -->
              <!-- SCHEDULEDDATE -->
              <h2>3. 공사 예정일이 언제인가요?</h2>
				<div class="form-group">
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1">
				        1개월 이내		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">
				        3개월 이내		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">
				        미정
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">
				        그 외 <input type="text" placeholder="기간을 직접 입력해주세요">
				    </label>
				    <br>
				    <div>
				종합 리모델링 공사의 경우, 시공까지 2~3주 이상 여유가 있어야 상담진행이 가능합니다.
					<br>시공이 임박했거나 3달 이후인 경우 상담이 어려울 수 있습니다.
					</div>    
				</div>
				<hr>
				<br>
              <!-- SCHEDULEDDATE END -->
              <!-- BUDGET -->
              <h2>4. 대략적인 인테리어 예산을 알려주세요.</h2>
				<div class="form-group">
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1">
				        1천만원 미만		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">
				         3천만원 이상		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">
				        미정
				    </label>
				</div>
				<hr>
				<br>
              <!-- BUDGET END -->
              <!-- ITEM -->
              <h2>5. 원하시는 시공을 모두 선택해주세요.</h2>
				<div class="form-group">
				    <label class="checkbox-inline">
				        <input type="checkbox">도배/벽
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox">바닥
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox">주방
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox">욕실
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox">현관
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox">발코니
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox">조명
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox">문
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox">그 외(문의)
				    </label>
				</div>
				<hr>
				<br>
              <!-- ITEM END -->
              <!-- MPHONE, POSTCODE, ADDRESS, DETAILADDRESS -->
              <h2>6. 시공할 곳의 주소와 이름, 연락처를 알려주세요.</h2>
					<div class="form-group row" style="margin-bottom: 10px"> 
							<label class="col-sm-2">이름</label>
							<div class="col-sm-3">TEST의 이름</div>
						</div>
					<div class="form-group row" style="margin-bottom: 10px"> 
							<label class="col-sm-2">휴대폰 번호</label>
							<div class="col-sm-5"><input type="text" name="phone" id="phone" class="form-control" 
							required placeholder="- 없이 숫자만 입력해주세요"></div>
						</div>
						<hr>
					<p>
					<button type="button" class="btn btn-secondary">시공 주소</button>
					</p>
					<div class="form-group row" style="margin-bottom: 10px"> 
						<label class="col-sm-2">우편번호</label>
						<div class="col-sm-3"><input type="text" name="zipNo" id="zipNo" class="form-control" required></div>
						<div class="col-sm-2"><input type="button" class="btn btn-outline-secondary" value="검색" onclick="goPopup();"></div>
					</div>
					<div class="form-group row" style="margin-bottom: 10px"> 
						<label class="col-sm-2">도로명 주소</label>
						<div class="col-sm-6"><input type="text" name="addr1" id="addr1" class="form-control" required></div>
					</div>
					<div class="form-group row" style="margin-bottom: 10px"> 
						<label class="col-sm-2">상세 주소</label>
						<div class="col-sm-3"><input type="text" name="addr2" id="addr2" class="form-control"></div>
						<div class="col-sm-3"><input type="text" name="addr3" id="addr3" class="form-control"></div>
					</div>
					<hr>
					<!-- 약관동의 -->
						<script>
						$(function() {
						    $("#flexCheckAll").click(function() {
						        $(".form-check-input").prop("checked", this.checked);
						    });
						    $(".form-check-input").click(function() {
						    	// 다른 체크박스 중 하나라도 체크가 해제되면 "flexCheckAll" 체크박스도 체크하지 않도록
								if (!$(this).prop("checked")) {
						            $("#flexCheckAll").prop("checked", false);
						        }
						    });
						});
						</script>
					<p>
					<button type="button" class="btn btn-secondary">약관동의</button>
					</p>						
							<div class="form-check">
								<input class="form-check-input" type="checkbox" value="" id="flexCheckAll" required>
								<label class="form-check-label" for="flexCheckAll" style="font-weight: bold; color: #e96b56">
									구매조건/약관 및 개인정보 이용에 모두 동의합니다.
								</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								<label class="form-check-label" for="flexCheckDefault">
									HOMEY 약관 동의 (필수)
								</label>
				                <textarea class="form-control" rows="3" readonly>
								[HOMEY 약관 동의] 
								이용 약관에 동의합니다.
								상품 구매 시 반드시 사이트 이용약관을 확인하시기 바랍니다.
				                </textarea>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" value="" id="flexCheckChecked">
								<label class="form-check-label" for="flexCheckChecked">
									개인정보 수집 및 이용에 대한 안내 (필수)
								</label>
				                <textarea class="form-control" rows="3" readonly>
								[개인정보 수집 및 이용에 대한 안내]
								회사는 회원 가입, 상품 구매 및 배송 등 최적화된 서비스 제공을 위해 일부 필수 개인정보를 수집합니다.
								회원은 언제든지 제공한 개인정보를 수정 및 삭제할 수 있습니다.
								회사는 회원의 개인정보 보호를 위해 최선을 다하며, 회원의 동의 없이 제3자에게 개인정보를 제공하지 않습니다.
				                </textarea>									
							</div>
							<hr>
							<br>
					<!-- 약관동의 END -->
              <!-- MPHONE, POSTCODE, ADDRESS, DETAILADDRESS END -->
              
              <!-- HAPPYCALL -->
              <h2>7.해피콜 희망 일시를 알려주세요.</h2>
			    <div>
					해피콜 운영시간은 평일 9시 ~ 오후 5시입니다.
					<br>
					10분 단위로만 선택해주세요.
				</div>   
				<br>
				<label for="datetime">날짜와 시간을 선택하세요:
				<br>
				  <input type="datetime-local"
				         id="datetime"
				         max="2030-06-20T21:00"
				         min="2023-10-10T12:30"
				         value="2023-10-18T12:30"
				         oninput="validateDateTime(this)"> <!-- 함수 사용 -->
				</label>
				<br>

	          <!-- HAPPYCALL END -->  
	          
             <!-- 견적상담 신청 버튼-->              
            </div>
            <a href="#" class="btn-visit align-self-start">Visit Website</a>
           	<button type="button" class="btn btn-white btn-lg col-lg-4" style="background-color: #e96b56; color: white;"  onclick="requestPay()">결제 하기</button>
          	</div>
             <!-- 견적상담 신청 버튼 END-->

		  <!-- 오른쪽 사이드 바 -->		
          <div class="col-lg-3">
            <div class="portfolio-info">
              <h3>견적 상담, <br>어떻게 이루어지나요?</h3>
              <ul>
                <li><strong>견적 상담 신청</strong> <span>원하시는 인테리어 시공에 대한 정보를<br> 알려주세요 ✏ </span></li>
                <li><strong>해피콜</strong> <span>해피콜 시간에 상담사가 연락드릴게요. 간단한 상담과 방문 실측 스케줄을 <br>상의해요 🤗 </span></li>
                <li><strong>방문 실측 견적 상담</strong> <span>실측 후 견적서를 제공해드려요 🏠 </span></li>
              </ul>
            </div>
          </div>
         <!-- 오른쪽 사이드 바 END -->		

        </div>

      </div>
    </section><!-- End Projet Details Section (END 견적상담 입력 폼)-->

</main><!-- End #main -->

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
//232번 라인 해피콜 입력받을 때 조건 설정 함수 -------------------------
function validateDateTime(input) {
// 	<!--  입력된 날짜와 시간 가져오기 -->
    var selectedDateTime = new Date(input.value);
    
// 	<!-- 날짜와 시간에 대한 유효성 검사 -->
    if (isValidWeekday(selectedDateTime) && isValidTime(selectedDateTime)) {
// 	<!-- 유효한 경우, 아무 작업 없이 통과 -->
    } else {
// 	<!-- 유효하지 않은 경우, 초기 값을 복구 (이전 유효한 값으로) -->
        input.value = "2023-10-18T12:30";
        alert("평일만 입력하고 10분 단위로 선택하세요.");
    }
}

function isValidWeekday(dateTime) {
// 	<!--  주말 (토요일: 6, 일요일: 0)이 아니라면 유효 -->
    var day = dateTime.getDay();
    return day !== 0 && day !== 6;
}

function isValidTime(dateTime) {
// 	<!-- 분 단위가 10의 배수인 경우 유효 -->
    var minutes = dateTime.getMinutes();
    return minutes % 10 === 0;
}
// END232번 라인 해피콜 입력받을 때 조건 설정 함수 -------------------------

</script>
<!-- ======= END script ======= -->

</body>
</html>
