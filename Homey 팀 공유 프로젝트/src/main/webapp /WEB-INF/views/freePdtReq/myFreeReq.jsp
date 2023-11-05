<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 제품 나눔 신청목록</title>


<style>
.portfolio-description p{		color: coral;	}

/*	게시글 제목(링크) 색상 */
tbody a { color : 	#333333; }

/* 게시글 제목(링크)에 마우스 올리면 주황색으로 표시 */
tbody a:hover { color : orange; }			


/* 테이블의 텍스트 가운데 정렬, 제목만 왼쪽 정렬 */
table {  text-align: center; }
table td.title {    	text-align: left;
							padding-left: 40px;	/*테이블에서 게시글제목 부분이 너무 번호랑 붙어있어서 조금 뗌 */}

/* 당첨 뱃지 스타일 */
.badge-lucky {
    background-color: 	#FF8C00; /* 배경-빨간색 */
    color: white; /* 글자-흰색 */
    border-radius: 5px;
    padding: 5px 10px;
}

/* 미당첨 뱃지 스타일 */
.badge-unlucky {
    background-color: 	#696969	; /* 배경-진회색 */
    color: white; /* 글자-흰색 */
    border-radius: 5px;
    padding: 5px 10px;
}
  
  
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
    <h2>My Request List</h2>
  </div>
</div><!-- End Breadcrumbs -->


<!-- 문의글 등록/삭제 완료 메시지가 있는 경우, qnaListAll.jsp로 돌아오면서 msg내용을 alert으로 띄우기 --> 
<c:if test="${!empty msg }">
	<script>
			alert('${msg}');
	</script>
</c:if>


<!-- ======= 제품 나눔 신청 목록 ======= -->
 
<section id="project-details" class="project-details blog">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-9 mx-auto">
	    <div class="portfolio-description">
	    
	        <h2>😎 나의 제품 나눔 신청목록</h2>
	        <p>* 이벤트 신청내역은 최근 20개까지 확인가능합니다.</p>
			<br>
			
			<div class="container">
			<br>
			
			<!-- 리스트 출력 시작 구간 --------------------------------------->
			<!-- 게시물이 없는 경우 -->
			<c:if test="${empty myfreePdtList }">
				<div class="row">
				<div class="col" align="center"> 
					<p class="alert alert-warning p-5">
						신청내역이 없습니다.
					</p>
				</div>
				</div>
			</c:if>	
			
			<!-- 게시물이 있는 경우 -->
			<c:if test="${!empty myfreePdtList }">
				<table class="table table-hover">
                    <thead>
                        <tr>
                            <th>게시글 제목</th>
                            <th>수령일</th>
                            <th>수령장소</th>
                            <th>후기 작성</th>
                        </tr>
                    </thead>
                    <tbody>
                    <!------------- Model 데이터 출력 ---------------> 
                    <c:forEach items="${myfreePdtList}" var="fpvo">
					    <tr>
					        <td class="title"><a href="/freePdt/view?fpNo=${fpvo.fpNo }&mid=<sec:authentication property="principal.Username"/>">${fpvo.fpTitle }</a>	</td>
					   		<td>${fpvo.fpGetDate }</td>
					        <td>${fpvo.fpGetPlace }</td>
					        <td><button type="button" class="btn btn-success btn-sm regiReviewBtn" data-fpno="${fpvo.fpNo}">후기 작성</button></td>
					    </tr>
					</c:forEach>
                    <!------------- END Model 데이터 출력 ----------->
                    </tbody>
                </table> <!-- /.table-responsive -->
			</c:if>	
			<!-- END 리스트 출력 구간 --------------------------------------->
			
			<br>
			<div class="text-center" id="btn-group">
				<button  class="btn btn-warning" onclick="history.back()">이전으로</button>
			</div>

		</div><!-- End container -->
	    </div><!-- End portfolio-description -->
    </div><!-- End col-lg-9 mx-auto -->
    <!-- 사이드바 -->
    <%@ include file="../includes/sideMenuMem.jsp"%>
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

//[후기작성]버튼이 클릭됐을 때, 이미 작성된 후기가 있는지 체크

$(document).ready(function () {
        $(".regiReviewBtn").click(function () {
            var fpNo = $(this).data("fpno");
            var mid = '<sec:authentication property="principal.Username"/>';
			console.log('버튼 클릭됨');
			console.log(fpNo);
            $.ajax({
                type: "GET",
                url: "/fpReview/checkReview",
                data: { mid: mid, fpNo: fpNo },
                success: function (result) {
                    if (result === "true") {
                        // 이미 후기 작성한 경우
                        alert("이미 리뷰를 작성한 게시글입니다.");
                    }else {
                        // 아직 후기 작성하지 않은 경우, 해당 후기 작성 페이지로 이동
                        alert("리뷰 작성화면으로 이동합니다.");
                        window.location.href = "/fpReview/register?fpNo=" + fpNo;
                    }
                }
            });
        });
    });

//END [후기작성]버튼이 클릭됐을 때, 이미 작성된 후기가 있는지 체크

</script>


</body>
</html>
