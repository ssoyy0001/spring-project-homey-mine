<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 나눔 등록</title>

<style>
	#notice {  color: red;		}
	.regiItemNm {	width: 150px;	}
	.regiItem {		width: 200px;	}
	.imgNotice {	font-size: 10px; color: lightcoral;   }
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
    <h2>HOMEY Product Trial</h2>
  </div>
</div><!-- End Breadcrumbs -->

 <!-- ======= 제품 나눔 게시글 등록 폼 ======= -->
 
<section id="project-details" class="project-details">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-description">
	        <h2>📝제품 나눔 안내글 등록</h2>
	        <span id="notice">* 항목은 필수 입력 항목입니다.</span>
	        <hr>
<!-----------------------start form----------------------->
	        <form action="/freePdt/register" method="post" role="form" enctype="multipart/form-data">
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 나눔물품</strong></label>
	                <input type="text" name="freePdt" class="regiItem" required>
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 수령일</strong></label>
	                <input type="date" name="fpGetDate" class="regiItem" min="2020-01-01" max="2030-12-31">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 수령장소</strong></label>
	                <input type="text" name="fpGetPlace" class="regiItem" required>
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 당첨인원</strong></label>
	                <input type="number" name="fpPeople" class="regiItem" value="0" min="0" max="100" step="1">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 모집마감일</strong></label>
	                <input type="date" name="fpDeadline" class="regiItem" min="2020-01-01" max="2030-12-31">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 제   목</strong></label>
	                <input type="text" name="fpTitle" class="form-control" required>
	            </div>
	            
	            <div class="form-group mt-3">
		            <label class="regiItemNm"><strong>* 내   용</strong></label>
		            <textarea class="form-control" name="fpContent" id="" rows="10" required></textarea>
	        	</div>
	            
	            <br>
	            
	            <div class="form-group mt-3">
	            	<!-- 파일 선택 버튼  -->
	            	<div class = "form-group uploadDiv">
	            		<input type="file" name="uploadFile"  onchange="checkImg(this);"/>
	            	</div>
	                <!-- 이미지 미리보기 -->
    				<img src="#" id="imagePreview" style="display: none; max-width: 200px; max-height: 200px;">
	                
	                <div class="imgNotice">* 이미지 파일은 10mb 이내, 파일 확장자는 jpg 혹은 png만 가능</div>
	            </div>
	            
	            <input type="hidden" name="mid" value="${pageContext.request.userPrincipal.name}">
	            
	            <!-- 스프링 시큐리티 ( 서버에서 들어오는 정보 ) -->
	            <!-- 서버에서 _csrf의 토큰을 받아오면서 침입인 건지 아닌지를 판별함(토큰이 없으면 침입으로 간주) -->
	            <input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
                
	            <br>
	            <br>
	            
	            <div class="text-center" id="btn-group">
					<button type="button" class="btn btn-secondary" onclick="insertCancel(event);">취소</button>
					<button type="submit" class="btn btn-warning regBtn">등록</button>
	            </div>
	            
	        </form>
<!-----------------------end form----------------------->
	        
	    </div><!-- End portfolio-description -->
    </div><!-- End col-lg-8 mx-auto -->
    </div><!-- End row justify-content-between -->
    </div><!-- End container -->
</section><!-- End Project Details Section -->


</main><!-- End #main -->


<%@ include file="../includes/footer.jsp"%>

  <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>
  
  <!-- 자바스크립트 파일 -->
  <script src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../resources/assets/vendor/aos/aos.js"></script>
  <script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="../resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="../resources/assets/vendor/php-email-form/validate.js"></script>
  <!-- Template Main JS File -->
  <script src="../resources/assets/js/main.js"></script>


<script>


//업로드 제한(사이즈, 확장자) 확인-------------------------------------------------

function checkImg(input) {
  var fileName = input.value;						//선택된 파일의 이름
  var fileSize = input.files[0].size;				//선택된 파일목록의 첫번째 요소의 파일크기

  if (checkExtension(fileName, fileSize)) {	//10mb이하인 이미지파일이라면
      showImg(input);									//미리보기 띄움 : showImg 함수 활용
  }else{
  	input.value = "";								//파일 선택 취소
  	$('#imagePreview').hide(); 				// 이미지 미리보기를 숨김
  }
}


var regEx = new RegExp("\\.(bmp|gif|jpg|jpeg|png)$");		//정규표현식 : 이미지 파일만 업로드 가능
var maxSize = 10485760;													//사이즈제한 : 10mb까지만 업로드 가능

function checkExtension(fileName, fileSize){
			//확장자 확인 및 알림 메시지 출력 및 중단
			if (!regEx.test(fileName)) {								//파일이름의 확장자부분을 regEx로 테스트
	            alert("이미지 형식의 파일이 아닌 경우 업로드할 수 없습니다.");
	            return false;
	        }
			//크기 확인 및 알림 메시지 출력 및 중단 (파일 사이즈가 5mb보다 크면, 업로드 불가)
			if (fileSize > maxSize) {
	            alert("파일 크기(10MB) 초과 - 업로드 불가");
	            return false;
	        }				
			//그 외의 경우 업로드 가능
			return true;
}
//END 업로드 제한 확인-----------------------------------------------------------


//파일 첨부했을 때, 미리보기 띄워주기------------------------------------------
function showImg(input) {
  if (input.files && input.files[0]) {		//this.files : 선택한 파일들의 목록이 있다면~ , this.files[0] : 목록의 첫 항목이 존재하면~
    var reader = new FileReader();		//파일리더 객체 생성 : 첨부된 파일의 정보를 읽어오기 위함
    
    //reader.onload : (이벤트핸들러) 파일 읽기 작업이 완료되면 호출됨. 파일을 읽은 후 비동기적으로 이벤트핸들러가 실행돼야해서 미리 정의해논 것
    reader.onload = function(e) {		//e에 파일리더 객체가 읽어온 첨부파일 정보가 담겨있음
    	 $('#imagePreview').attr('src', e.target.result);
         $('#imagePreview').show(); // 이미지 미리보기 표시
    };
    reader.readAsDataURL(input.files[0]);		//파일 리더 객체가 파일을 읽음
  }
}
//END 파일 첨부했을 때, 미리보기 띄워주기------------------------------------------



//원데이클래스 등록 폼에서 [취소] 버튼 클릭 시 
function insertCancel(event){
	if(confirm('작성하던 글이 모두 사라집니다. \n게시글 등록을 취소하시겠습니까?')){
		 history.back(); 
    }else if(!cancel){
        	  event.preventDefault();
    };
}


//원데이클래스 등록 폼에서 [등록] 버튼 클릭 시
$('.regBtn').click(function(event) {
	event.preventDefault(); 						//form 제출 막기

	// 필수 입력 필드의 값들을 가져와서 검사
	var fpTitle = $('input[name="fpTitle"]').val();
	var fpContent = $('input[name="fpContent"]').val();
	var freePdt = $('input[name="freePdt"]').val();
	var fpPeople = $('input[name="fpPeople"]').val();
	var fpDeadline = $('input[name="fpDeadline"]').val();
	var fpGetDate = $('input[name="fpGetDate"]').val();
	var fpGetPlace = $('input[name="fpGetPlace"]').val();

	if ( fpTitle === "" || fpContent === "" || freePdt === "" || fpPeople === "" || fpDeadline === "" || fpGetDate === "" || fpGetPlace === "" ) {
	 	//입력 필수항목 중 빈 값이 있을 경우
		alert("미입력 항목을 확인해주세요.");	
	 	
	}else{
			if (confirm('등록하시겠습니까?')) {
				$('form').submit();
			}
	}
	
});



//수령일, 모집마감일을 과거 혹은 오늘로 선택했을 경우 알림창 표시
function checkDate(dateValue, inputValue) {
    
    var today = new Date();					//오늘 날짜
    today.setHours(0, 0, 0, 0); 					//오늘 날짜의 시간 부분을 00:00:00으로 설정

    var selectedDate = new Date(dateValue);		//입력받은 날짜를 Date 객체로 변환

    if (selectedDate < today) {					//입력받은 날짜가 과거/오늘 날짜라면?
        alert("잘못된 날짜입니다. 오늘 이후의 날짜를 선택하세요.");
    
     	//이전 값 그대로 유지
        inputValue.value = inputValue.getAttribute('data-original');
    }
}//END checkDate()

//수령일 날짜 검토
var fpGetDate = document.querySelector('input[name="fpGetDate"]');
fpGetDate.setAttribute('data-original', fpGetDate.value); 					//초기값 저장
fpGetDate.addEventListener('change', function () {
    checkDate(this.value, this);
});

//모집마감일 날짜 검토
var fpDeadline = document.querySelector('input[name="fpDeadline"]');
fpDeadline.setAttribute('data-original', fpDeadline.value); 		//초기값 저장
fpDeadline.addEventListener('change', function () {
    checkDate(this.value, this);


});

//END 진행일시, 모집마감일을 과거 혹은 미래로 선택했을 경우 알림창 표시




</script>


</body>
</html>
