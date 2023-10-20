<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>견적상담 신청</title>
<style>
/* 모달창 */
    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.5);
    }

    .modal-content {
      background-color: #fff;
      margin: 15% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
      max-width: 600px;
    }

    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }
/* 모달창 end */    
/* callout 문구 강조 */
#callout {background-color: #FFAF00; color: white; padding: 5px 5px 5px;
			border-radius: 40px 80px; width: 90%; text-align: center; margin-top: 10px}
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
    <h2>견적상담 등록</h2>
  </div>
</div><!-- End Breadcrumbs -->

 <!-- ======= Projet Details Section (견적상담 입력 폼)======= -->
    <section id="project-details" class="project-details">
      <div class="container" data-aos="fade-up" data-aos-delay="100">
        <div class="row justify-content-between gy-4 mt-4">
          <div class="col-lg-8">
            <div class="portfolio-description">
            
    <!-- 견적상담 등록 폼 -->
	<form action="/consult/register" method="post" role="form">
              <!-- BUILDINGTYPE 선택 -->
              <h2>1. 어떤 건물을 인테리어 하실건가요?</h2>
				<div class="form-group">
				    <label class="radio-inline">
				        <input type="radio" name="buildingType" id="buildingType1" value="아파트" required>
				        아파트 &nbsp;		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="buildingType" id="buildingType2" value="빌라">
				        빌라 &nbsp;		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="buildingType" id="buildingType3" value="주택">
				        주택 &nbsp;
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="buildingType" id="buildingType4" value="오피스텔">
				        오피스텔 &nbsp;
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="buildingType" id="buildingType5"  value="그 외">
				        그 외 <input type="text" name="buildingType" placeholder="건물 유형을 입력해주세요" >
				    </label>
				</div>
				<hr>
				<br>
              <!-- BUILDINGTYPE 선택 END -->
              <!-- PYEONGSU -->
              <h2>2. 시공할 건물의 평수를 입력해주세요.</h2>
				<div style="display: flex; align-items: center;">
				    <input type="number" name="pyeongsu" id="pyeongsu" class="form-control" value="0" min="0" step="10" style="width: 70px;" required> 
				    <span style="margin-left: 5px;">평</span>
				</div>
			  <hr>
              <br>
              <!-- PYEONGSU END -->
              <!-- SCHEDULEDDATE -->
              <h2>3. 공사 예정일이 언제인가요?</h2>
				<div class="form-group">
				    <label class="radio-inline">
				        <input type="radio" name="scheduledDate" id="scheduledDate1" value="1개월 이내" required>
				        1개월 이내 &nbsp;		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="scheduledDate" id="scheduledDate2" value="3개월 이내">
				        3개월 이내 &nbsp;		
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="scheduledDate" id="scheduledDate3" value="미정">
				        미정 &nbsp;
				    </label>
				    <label class="radio-inline">
				        <input type="radio" name="scheduledDate" id="scheduledDate4" value="그 외">
				        그 외 <input type="text" name="scheduledDate" placeholder="기간을 직접 입력해주세요">
				    </label>
				    <br>
				    <div id="callout">
					 종합 리모델링 공사의 경우, 시공까지 2~3주 이상 여유가 있어야 상담진행이 가능합니다.
					 <br>시공이 임박했거나 3달 이후인 경우 상담이 어려울 수 있습니다.
					</div>
				</div>
				<hr>
				<br>
              <!-- SCHEDULEDDATE END -->
              <!-- BUDGET -->
              <h2>4. 대략적인 인테리어 예산을 알려주세요.</h2>
				<div style="display: flex; align-items: center;">
					 <input type="number" name="budget" id="budget" class="form-control" 
					 value="1000" step="1000" style="width: 200px" required>
					<span style="margin-left: 5px;">만(원)</span>
				</div>
				<hr>
				<br>
              <!-- BUDGET END -->
              <!-- ITEM -->
              <h2>5. 원하시는 시공을 모두 선택해주세요.</h2>
              	<!-- 조건 : 체크박스가 선택되면 1로, 선택되지 않으면 0으로  -->
				<div class="form-group" style="display:inline-block; width:300px; line-height:50px;">
				    <label class="checkbox-inline">
				        <input type="checkbox" name="tiling" id="tilingCheck" class="item" value="1">도배/벽 &nbsp;
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox" name="flooring" id="flooringCheck" class="item" value="1">바닥 &nbsp;
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox" name="kitchen" id="kitchenCheck" class="item" value="1">주방 &nbsp;
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox" name="bathroom" id="bathroomCheck" class="item" value="1">욕실 &nbsp;
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox" name="entrance" id="entranceCheck" class="item" value="1">현관 &nbsp;
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox" name="balcony" id="balconyCheck" class="item" value="1">발코니 &nbsp;
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox" name="lighting" id="lightingCheck" class="item" value="1">조명 &nbsp;
				    </label>
				    <label class="checkbox-inline">
				        <input type="checkbox" name="door" id="doorCheck" class="item" value="1">문 &nbsp;
				    </label> 
				    <label class="checkbox-inline">
				        <input type="checkbox" name="etc" id="etcCheck" class="item" value="1">그 외(문의) &nbsp;
				    </label>
				</div>
				<hr>
				<br>
              <!-- ITEM END -->
              <!-- MPHONE, POSTCODE, ADDRESS, DETAILADDRESS -->
              <h2>6. 시공할 곳의 주소, 연락처를 알려주세요.</h2>
					<div class="form-group row" style="margin-bottom: 10px"> 
							<label class="col-sm-2">아이디</label>
							<div class="col-sm-3"> <input type="text" name="mid" value="${mid}" readonly="readonly" required></div>
					</div>
					<div class="form-group row" style="margin-bottom: 10px"> 
							<label class="col-sm-2">휴대폰 번호</label>
							<div class="col-sm-5"><input type="text" name="mphone" id="mphone" class="form-control" 
							required placeholder="- 없이 숫자만 입력해주세요"></div>
					</div>
					<!-- 카카오 주소 api  -->
					<div class="form-group row" style="margin-bottom: 10px"> 
						<label class="col-sm-2">우편번호</label>
						<div class="col-sm-3"><input type="text" name="postcode" id="postcode" class="form-control" required placeholder="우편번호"></div>
						<div class="col-sm-2"><input type="button" class="btn btn-outline-secondary" value="검색" onclick="execDaumPostcode()"></div>
					</div>
					<div class="form-group row" style="margin-bottom: 10px"> 
						<label class="col-sm-2">도로명 주소</label>
						<div class="col-sm-6"><input type="text" name="address" id="address" class="form-control" required placeholder="주소"></div>
					</div>
					<div class="form-group row" style="margin-bottom: 10px"> 
						<label class="col-sm-2">상세 주소</label>
						<div class="col-sm-6"><input type="text" name="detailAddress" id="detailAddress" class="form-control" placeholder="상세주소"></div>
					</div>
					<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
					<!-- end 카카오 주소 api  -->
					
					<hr>
					<!-- 약관동의 -->
					<div class="form-check"> <!--flexCheckDefault이면 미체크, flexCheckChecked이면 체크된 상태로 나타남 -->
						<input class="form-check-input" type="checkbox" id="flexCheckDefault" required>
						<label class="form-check-label" for="flexCheckDefault" style="font-weight: bold;">
							HOMEY 약관 & 개인정보 수집 및 이용에 대한 안내 동의 (필수) &nbsp;
						</label>
						<button id="showModalBtn" class="btn btn-sm btn-warning">보기</button>
					</div>
					<!-- 약관동의 모달창 -->
					  <div id="myModal" class="modal">
					    <div class="modal-content">
					      <span class="close" id="closeModal">&times;</span>
					      <!-- 약관 내용 및 동의 체크박스 -->
					      <h4>약관 & 개인정보 수집 및 이용에 대한 안내 동의</h4>
					      <p>
					      	① “HOMEY”은(는) 제 7조 제 2항의 신청서기재사항 이외에 “이용자”의 콘텐츠이용에 필요한 최소한의 정보를 수집할 수 있습니다.
							이를 위해 “핀테리어”이(가) 문의한 사항에 관해 “이용자”는 진실한 내용을 성실하게 고지하여야 합니다.
							② “HOMEY”이(가) “이용자”의 개인 식별이 가능한 “개인정보”를 수집하는 때에는 당해 “이용자”의 동의를 받습니다.
							③ “HOMEY”은(는) “이용자”가 이용신청 등에서 제공한 정보와 제 1항에 의하여 수집한 정보를 당해 “이용자”의 동의 없이 목적 외로 이용하거나 제 3자에게 제공할 수 없으며, 이를 위반한 경우에 모든 책임은 “핀테리어”이(가) 집니다. 다만, 다음의 경우에는 예외로 합니다.
					      </p>
					      <p>자세한 사항은 <a href="/notice/list">공지사항</a>에서 확인해주세요.</p>
					    </div>
					  </div>
					<!-- END 약관동의 모달창 -->
					<hr>
					<br>
			<!-- 약관동의 END -->
              <!-- MPHONE, POSTCODE, ADDRESS, DETAILADDRESS END -->
              
              <!-- HAPPYCALL -->
              <h2>7. 해피콜 희망 일시를 알려주세요.</h2>
			    <div id="callout">
					해피콜 운영시간은 평일 9시 ~ 오후 5시입니다.
					<br>10분 단위로만 선택해주세요.
				</div>   
				<br>
				<label for="datetime">날짜와 시간을 선택하세요
				<br>
				  <input type="datetime-local"
				         id="happyCall"
				         name="happyCall"
				         value="2023-10-18T12:30"
				         oninput="validateDateTime(this)"> <!-- 함수 사용 -->
				         
				</label> 
				<br>
	          <!-- HAPPYCALL END -->  
	          
             <!-- 견적상담 신청 버튼-->
            <div class="position-absolute end-50"> 
				<button type="reset" class="btn btn-light">
					Reset</button>
				<button type="button" class="btn btn-secondary"
						onclick="history.back()">
					Cancel</button>
				<button type="submit" class="btn btn-warning" id="submit">
					견적상담 신청</button>  
			</div>           
            	<!-- 시큐리티 -->
            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
            <!-- 견적상담 신청 버튼 END-->
             
             </form>
				<!-- END 견적상담 등록 폼 -->              
            </div>
          </div>
		  <!-- 오른쪽 사이드 바 -->		
          <div class="col-lg-3">
            <div class="portfolio-info" style="background: linear-gradient(#FDDCAA, #FDF5E6); padding: 5px 5px 5px">
              <h3>견적 상담, <br>어떻게 이루어지나요?</h3>
              <ul>
                <li><strong>견적 상담 신청</strong> <span>원하시는 인테리어 시공의 정보를<br> 알려주세요 ✏ </span></li>
                <li><strong>해피콜</strong> <span>해피콜 시간에 상담사가 연락드려요. 간단한 상담과 방문 실측 스케줄을 <br>상의해요 🤗 </span></li>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//라디오박스, 체크박스 하나이상 체크 알림 -----------------------------------------
document.getElementById('submit').onclick = function() {
    var radioBuildingType = document.querySelector('input[type=radio][name=buildingType]:checked');
    var radioScheduledDate = document.querySelector('input[type=radio][name=scheduledDate]:checked');
    //var checkItem = document.querySelector('input[type=checkbox][name=item]:checked');
    var checkItem = document.querySelector('input[type=checkbox][class=item]:checked');
    
    if (!radioBuildingType && ! radioScheduledDate) {
        alert('1. 어떤 건물을 인테리어 하실건지 체크해주세요.\n3. 공사예정일이 언제인지 체크해주세요.');
    }
    else if (!radioBuildingType) {
        alert('1. 어떤 건물을 인테리어 하실건지 체크해주세요.');
    }
    else if (!radioScheduledDate) {
        alert('3. 공사예정일이 언제인지 체크해주세요.');
    }
    else if (!checkItem) { //checkbox는 required 하면 모든 체크박스 선택을 요구해서 대안
        alert('5. 원하시는 시공을 선택해주세요');
        event.preventDefault();
    }
    
}//end
//라디오박스, 체크박스 하나이상 체크 알림 -----------------------------------------

// 141번 라인 체크박스 해당 항목에 대한 값을 1로 설정하고, 선택되지 않았을 때는 0으로 설정-----------------------------------------
document.addEventListener('DOMContentLoaded', function() {
    // 각 체크박스의 요소를 가져옵니다
    var tilingCheck = document.getElementById('tilingCheck');
    var flooringCheck = document.getElementById('flooringCheck');
    var kitchenCheck = document.getElementById('kitchenCheck');
    var bathroomCheck = document.getElementById('bathroomCheck');
    var entranceCheck = document.getElementById('entranceCheck');
    var balconyCheck = document.getElementById('balconyCheck');
    var lightingCheck = document.getElementById('lightingCheck');
    var doorCheck = document.getElementById('doorCheck');
    var etcCheck = document.getElementById('etcCheck');

    // 체크박스 상태가 변경되면 실행할 함수를 정의합니다
    function handleCheckboxChange(checkbox, value) {
        if (checkbox.checked) {
            // 체크박스가 선택된 경우 1로 설정
            value.value = 1;
        } else {
            // 체크박스가 선택되지 않은 경우 0으로 설정
            value.value = 0;
        }
    }
});
//END 체크박스 해당 항목에 대한 값을 1로 설정하고, 선택되지 않았을 때는 0으로 설정 -----------------------------------------


//카카오 주소 API -----------------------------------------
 // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
//END 카카오 주소 API -----------------------------------------


//모달창 -----------------------------------------
const showModalBtn = document.getElementById("showModalBtn");
    const modal = document.getElementById("myModal");
    const closeModal = document.getElementById("closeModal");

    showModalBtn.addEventListener("click", () => {
      modal.style.display = "block";
    });

    closeModal.addEventListener("click", () => {
      modal.style.display = "none";
    });
//모달창 END -----------------------------------------


//232번 라인 해피콜 입력받을 때 조건 설정 함수 -------------------------
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
// END232번 라인 해피콜 입력받을 때 조건 설정 함수 -------------------------

</script>
<!-- ======= END script ======= -->

</body>
</html>
