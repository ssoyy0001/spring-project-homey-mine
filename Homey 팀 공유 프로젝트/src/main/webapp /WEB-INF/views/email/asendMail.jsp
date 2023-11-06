<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 발송</title>

<style>
/* 공지사항 글자 색상 */
#notice {  color: red;		}

/* 제목 부분 길이 지정 */
.regiItemNm {	width: 150px;	}

/* 메일 내용 길이 지정 */
.mailItem {		width: 700px;	}
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
    <h2>send mail</h2>
  </div>
</div><!-- End Breadcrumbs -->

<!-- 메일발송 완료 메시지가 있는 경우, msg내용을 alert으로 띄우기 --> 
<c:if test="${!empty msg }">
	<script>
			alert('${msg}');
	</script>
</c:if>

 <!-- ======= 메일 발송 ======= -->
 
<section id="project-details" class="project-details">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-description">
	        <h2>📧 메일 발송</h2>
	        <span id="notice">* 항목은 필수 입력 항목입니다.</span>
	        <hr>
<!-----------------------start form----------------------->
	        <form action="/asend/sendMail" method="get" role="form">
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 이 메 일</strong></label>
	                <input type="text" name="mailAddress" class="mailItem" value="${mailAddress }">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 제    목</strong></label>
	                <input type="text" name="mailTitle" class="mailItem" required>
	            </div>

	            <div class="form-group mt-3">
		            <label class="regiItemNm"><strong>* 내    용</strong></label>
		            <textarea class="form-control" name="mailContent" id="" rows="10"  placeholder=""></textarea>
	        	</div>
	            
	            <br>
	            
				<!-- 외부 API로 가는 거라서 일단 시큐리티 빼볼게 -->
                
	            <br>
	            <br>
	            
	            <div class="text-center" id="btn-group">
	            	<a href="/asboard/aslist" class="btn btn-secondary">목록으로</a>
				<button type="submit" class="btn btn-warning regBtn">전송</button>
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

//메일 전송 폼에서 [취소] 버튼 클릭 시 
function insertCancel(event){
	if(confirm('작성하던 글이 모두 사라집니다. \n메일 작성을 취소하시겠습니까?')){
		 history.back(); 
    }else if(!cancel){
        	  event.preventDefault();
    };
}


//원데이클래스 등록 폼에서 [등록] 버튼 클릭 시
$('.regBtn').click(function(event) {
	event.preventDefault(); 						//form 제출 막기

	// 필수 입력 필드의 값들을 가져와서 검사
	var mailAddress = $('input[name="mailAddress"]').val();
	var mailTitle = $('input[name="mailTitle"]').val();
	var mailContent = $('input[name="mailContent"]').val();

	if ( mailAddress === "" || mailTitle === "" || mailContent === "" ) {
	 	//입력 필수항목 중 빈 값이 있을 경우
		alert("미입력 항목을 확인해주세요.");	
	 	
	}else{
			if (confirm('전송하시겠습니까?')) {
				$('form').submit();
			}
	}
	
});

</script>


</body>
</html>
