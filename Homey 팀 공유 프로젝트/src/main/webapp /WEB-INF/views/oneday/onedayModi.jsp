<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원데이클래스 수정</title>

<style>
	#notice {  color: red;		}
	.regiItemNm {	width: 150px;	}
	.regiItem {		width: 200px;	}
	.imgNotice {	font-size: 10px; color: lightcoral;   }
	.odWriter{		width: 200px;	
						border: none;
        				outline: none;	}
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
    <h2>Oneday Class</h2>
  </div>
</div><!-- End Breadcrumbs -->

 <!-- ======= 원데이클래스 게시글 수정 폼 ======= -->
 
<section id="project-details" class="project-details">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-description">
	        <h2>📝원데이클래스 안내글 수정</h2>
	        <span id="notice">* 항목은 필수 입력 항목입니다.</span>
	        <hr>
<!-----------------------start form----------------------->
	        <form action="/oneday/modify" method="post" role="form" enctype="multipart/form-data">
	            
	            <input type="hidden" name="odNo" value="${odvo.odNo }">
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 작성자</strong></label>
	                <input type="text" name="mid" class="regiItem odWriter" value="${odvo.mid }" readonly>
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 모집현황</strong></label>
	                <select name="odState">
				        <option value="0" ${odvo.odState == '0' ? 'selected' : ''}>모집중</option>
				        <option value="1" ${odvo.odState == '1' ? 'selected' : ''}>모집마감</option>
				    </select>
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 진행일시</strong></label>
	                <input type="datetime-local" name="odDate" class="regiItem" value="${odvo.odDate}">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 진행장소</strong></label>
	                <input type="text" name="odPlace" class="regiItem"  value="${odvo.odPlace}">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 진행자</strong></label>
	                <input type="text" name="odMc" class="regiItem"  value="${odvo.odMc}">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 예상소요시간</strong></label>
	                <input type="text" name="odTime" class="regiItem"  value="${odvo.odTime}">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 모집인원</strong></label>
	                <input type="number" name="odPeople" class="regiItem" value="${odvo.odPeople}" min="0" max="100" step="1">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 모집마감일</strong></label>
	                <input type="date" name="odDeadline" class="regiItem" value="${odvo.odDeadline}" min="2020-01-01" max="2030-12-31">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 원데이클래스명</strong></label>
	                <input type="text" name="odName" class="regiItem"  value="${odvo.odName}">
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 제   목</strong></label>
	                <input type="text" name="odTitle" class="form-control"  value="${odvo.odTitle}">
	            </div>
	            
	            <div class="form-group mt-3">
		            <label class="regiItemNm"><strong>* 내   용</strong></label>
		            <textarea class="form-control" name="odContent" id="" rows="10" required>${odvo.odContent}</textarea>
	        	</div>
	            
	            <br>
	            
	            <div class="form-group mt-3">
	            	<!---- 파일 선택 버튼 --------------------------------------->
	            	<div class = "form-group uploadDiv">
	            		<input type="file" name="uploadFile"  onchange="checkImg(this);"/>
	            	</div>
	            	<!---- 기존 이미지파일을 표시하는 구간 ------------------------>
	            	<img src="../oneday/display?fileName=${odvo.odImg}" id="imagePreview" style="display: show; max-width: 200px; max-height: 200px;">
	                <div class="imgNotice">* 이미지 파일은 10mb 이내, 파일 확장자는 jpg 혹은 png만 가능</div>
	            </div>
	            
<%-- 	            <input type="hidden" name="mid" value="${pageContext.request.userPrincipal.name}"> --%>
	            
	            <!---- 수정 이후에 Criteria 내용을 유지하기 위함 ------------------------>
	            <input type="hidden" name="pageNum" value="${socri.pageNum}">
		        <input type="hidden" name="amount"  value="${socri.amount}">
	            <input type="hidden" name="type" value="${socri.type}">
		        <input type="hidden" name="keyword"  value="${socri.keyword}">
	            
	            <!-- 스프링 시큐리티 ( 서버에서 들어오는 정보 ) -->
	            <!-- 서버에서 _csrf의 토큰을 받아오면서 침입인 건지 아닌지를 판별함(토큰이 없으면 침입으로 간주) -->
	            <input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
                
	            <br>
	            <br>
	            
	            <div class="text-center" id="btn-group">
					<button type="button" class="btn btn-secondary" onclick="modifyCancel(event);">취소</button>
					<button type="submit" class="btn btn-warning modiBtn">수정</button>
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



//원데이클래스 수정 폼에서 [취소] 버튼 클릭 시 
function modifyCancel(event){
	if(confirm('수정하던 글이 모두 사라집니다. \n게시글 수정을 취소하시겠습니까?')){
		 history.back(); 
    }else if(!cancel){
        	  event.preventDefault();
    };
}


//원데이클래스 수정 폼에서 [수정] 버튼 클릭 시
$('.modiBtn').click(function(event) {
	event.preventDefault(); 						//form 제출 막기

	// 필수 입력 필드의 값들을 가져와서 검사
	var odDate = $('input[name="odDate"]').val();
	var odPlace = $('input[name="odPlace"]').val();
	var odMc = $('input[name="odMc"]').val();
	var odTime = $('input[name="odTime"]').val();
	var odPeople = $('input[name="odPeople"]').val();
	var odDeadline = $('input[name="odDeadline"]').val();
	var odName = $('input[name="odName"]').val();
	var odTitle = $('input[name="odTitle"]').val();
	var odContent = $('textarea[name="odContent"]').val();

	if ( odDate === "" || odPlace === "" || odMc === "" || odTime === "" || odPeople === "" || odName === "" || odTitle === "" || odContent === "" || odDeadline === "") {
	 	//입력 필수항목 중 빈 값이 있을 경우
		alert("미입력 항목을 확인해주세요.");	
	 	
	}else{
			if (confirm('수정하시겠습니까?')) {
				$('form').submit();
			}
	}
	
});

</script>


</body>
</html>
