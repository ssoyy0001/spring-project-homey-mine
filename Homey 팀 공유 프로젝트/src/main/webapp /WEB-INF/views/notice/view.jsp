<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세 조회</title>
<style type="text/css">
/* 라벨 강조 */
.form-group label {
       font-weight: bold;
   }
/* 조절  */ 
.row {display: flex; justify-content: center;}
 
/* 간격 조절 */
.form-group label,
.form-group div {
    display: table-cell;
    padding: 5px 15px;
}   
/* 첨부파일 크기 조절*/
.uploadResult ul li img {
    max-width: 100%; /* 이미지를 부모 요소 너비에 맞게 조절 */
    max-height: auto;
    display: block;
    width:50%;
    margin:auto;
}
</style>


</head>
<body>

<!-- ======= header ======= -->
<%@ include file="../includes/header.jsp" %>
<!-- ======= main ======= -->
<main id="main">
<!-- ======= Breadcrumbs ======= -->
<div class="breadcrumbs d-flex align-items-center" style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
  <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
    <h2>공지사항 상세조회</h2>
  </div>
</div><!-- End Breadcrumbs -->
    
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up" data-aos-delay="100">
        <div class="row g-5">
          <div class="col-lg-8 mx-auto">
            <article class="blog-details">
        
           		
           	<!-- 내용 표시 시작 -------------------------- -->
           	
           	<h2 class="title">${nvo.notTitle }</h2>
           	
  			<div class="meta-top">
				  <ul>
				    <li class="d-flex align-items-center"><i class="bi bi-list-ol"></i> No. ${nvo.notNo } </li>
				    <li class="d-flex align-items-center"><i class="bi bi-tags-fill"></i> 분류 | ${nvo.notCategory } </li>
				    <li class="d-flex align-items-center"><i class="bi bi-person-fill"></i> 작성자 | ${nvo.mid } </li>
				    <li class="d-flex align-items-center"><i class="bi bi-calendar-check-fill"></i> 작성일 | <fmt:formatDate value="${nvo.notDate}" pattern="yyyy-MM-dd (E)"/>  </li>
				  </ul>
			</div><!-- End meta top -->

		<div class="content">
			<p>${nvo.notCont }</p>
		</div>
				<br>
				<hr>
				<br>
								
				 <!-- 첨부파일 -->
				<div class = "row">
					<div class = "col-lg-12">
						<div class = "panel panel-default">
							<div class = "panel-body">
						<!-- 업로드 결과 출력 -->				
						<div class="uploadResult">
						<ul> </ul>
						</div>
						<!-- 업로드 결과 출력 -->				
						
						<!-- 썸네일 원본 이미지 표시 결과 출력 -->				
						<div class="originImgDiv">
							<div class="originImg"> </div>
						</div>
						<!-- 썸네일 원본 이미지 표시 결과 출력 -->				
							</div>
						</div>
					</div>
				</div>			

			<form action="/notice/modify">
				<input type="hidden" name="notNo" value="${nvo.notNo }">
					<sec:authorize access="hasRole('ROLE_ADMIN')"> <!-- 관리자만 수정 -->		
					    <button data-oper="modify" class="btn btn-warning">
					        수정
					    </button>
					</sec:authorize>
						<button data-oper="list" class="btn btn-primary"
							 	formaction="/notice/list">
							목록으로</button>
					<!-- 페이지 번호와 페이지에 표시할 게시물의 수, 검색 타입, 키워드 -->
                	<input type="hidden" name="type" 	value="${cri.type}">
                	<input type="hidden" name="keyword" value="${cri.keyword}">	
					<input type="hidden" name="pageNum" value="${cri.pageNum}">
                	<input type="hidden" name="amount"  value="${cri.amount}">
                	
		</form>
				
			<!-- 내용 표시 끝 -------------------------- -->
	       
	        </article><!-- End blog post -->
				</div><!-- End post content -->	       	
        </div>
      </div>
    </section><!-- End Blog Details Section -->
    
</main>

<!-- ======= script ======= -->
<script>
var notNoVal = '${nvo.notNo}';

//첨부파일 가져오기 -----------------------------
(function() {
	  // 첨부파일 목록 가져오기
	  $.getJSON("/notice/attachList", { notNo: notNoVal }, function(result) {
	    console.log(result);
				

//업로드 결과 파일 이름 출력 ver2
var resultUL = $('.uploadResult ul');
	var liTag = '';							//str을 초기화 시키고
      $(result).each(function(i, obj){
          if(obj.image) { //** 이미지는 썸네일과 파일명 표시 
			var fileCallPath = encodeURIComponent(obj.upFolder + "/s_" + obj.uuid + "_" + obj.fileName); // thumbImg
			
          	//1. 원본 이미지 경로 및 파일명
			var orginImg = obj.upFolder + "\\" + obj.uuid + "_" + obj.fileName;
			
			//2. \ 를 /로 변경
			orginImg = orginImg.replace(new RegExp(/\\/g),"/");
			
			//3. 썸네일 이미지 클릭 시 원본 이미지 표시 함수 호출하도록 링크 만들기
			liTag += "<li><a href='javascript:showOriginal(\"" 
		          + orginImg + "\")'><img src='/display?fileName=" + orginImg + "'></a><br>" 
		          + obj.fileName +
		          "<span data-file='" + fileCallPath + "' " +
		          "data-type='image'> X </span>" +
		          "</li>";
		          
	          } else {	//**일반 파일은 attach.png 이미지와 파일명 표시, 파일명 클릭 시 다운로드
				var fileCallPath = encodeURIComponent(obj.upFolder + "/" + obj.uuid + "_" + obj.fileName);
				liTag += "<li><a href='/download?fileName=" + fileCallPath + "'>"
		         + "<img src='/resources/img/attach.png'></a><br>" 
		         + obj.fileName +
		         "<span data-file='" + fileCallPath + "' " +
		         "data-type='file'> X </span>" +
		         "</li>";
	          } 
});										
	resultUL.append(liTag);
	  });										
})();

//썸네일 원본 이미지 표시
function showOriginal(orginImg) {
	//alert(orginImg); ---- 확인하기
	
	//보이게 함
	$(".originImgDiv").css("display", "flex").show();

	$(".originImg")
	.html("<img src = '/display?fileName=" + orginImg +"'>")
	.animate({width:'100%', height:'100%'}, 1000); //1초  = 1000
	
	//[ <div> 이벤트 처리 ] : 썸네일원본 이미지 클릭 이벤트 처리
	//다시 클릭하면 숨기기
	$(".originImgDiv").on("click", function(){
		$(".originImg").animate({width : '0%', height : '0%'}, 1000);
		setTimeout(() => {
			$(this).hide();
		}, 1000);
	});

}//END 썸네일 원본 이미지 표시
//END 첨부파일 가져오기 -----------------------------

</script>
<!-- ======= END script ======= -->


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
</body>
</html>
