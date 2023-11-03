<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 원데이클래스 리뷰목록</title>

<style>

/* 현재 클릭된 페이징 버튼 */
.custom-pagination .page-item.active .page-link {		
		border-color : 	#ffc107;
        background-color: 	#ffc107; 
        color: black; 
    }
    
/* 비활성 버튼 스타일 */
.custom-pagination .page-item .page-link { 	
		border-color : 	#ffc107;
        background-color: white; 
        color: 	#ffc107; 
    }

/*	게시글 제목(링크) 색상 */
tbody a { color : 	#333333; }

/* 게시글 제목(링크)에 마우스 올리면 진회색으로 표시 */
tbody a:hover { color : #ffc107; }			


/* 테이블의 텍스트 가운데 정렬, 제목만 왼쪽 정렬 */
table {  text-align: center; }
table td.title {    text-align: left;	}
  
  
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
    <h2>Oneday Class Review</h2>
  </div>
</div><!-- End Breadcrumbs -->


<!-- 메시지가 있는 경우, msg내용을 alert으로 띄우기 --> 
<c:if test="${!empty msg }">
	<script>
			alert('${msg}');
	</script>
</c:if>


<!-- ======= 나의 원데이클래스 리뷰 목록 ======= -->
 
<section id="project-details" class="project-details blog">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-description">
	    
	        <h2>🧾 내가 작성한 원데이클래스 리뷰</h2>
			<br>		
			<div class="container">
			<br>
			<!-- 리스트 출력 시작 구간 --------------------------------------->
			<!-- 게시물이 없는 경우 -->
			<c:if test="${empty myReviewList }">
				<div class="row">
				<div class="col" align="center"> 
					<p class="alert alert-warning p-5">
						작성한 리뷰가 없습니다.
					</p>
				</div>
				</div>
			</c:if>	
			
			<!-- 게시물이 있는 경우 -->
			<c:if test="${!empty myReviewList }">
				<table class="table table-hover">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>게시글 제목</th>
                            <th>작성자</th>
                            <th>조회수</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <!------------- Model 데이터 출력 ---------------> 
                    <c:forEach items="${myReviewList }" var="orvo">
                  		<tr>
                  			<td>${orvo.orRn }</td>
                  			<td class="title"><a class="move" href="${orvo.orNo }">${orvo.orTitle }</a>	</td><!-- href의 나머지 내용은 스크립트에서 처리-->
                  			<td>${orvo.mid }</td>
                  			<td>${orvo.orHit }</td>
                  			<td><fmt:formatDate value="${orvo.orDate}" pattern="yyyy/MM/dd"/></td>
                  		</tr>
                    </c:forEach>
                    <!------------- END Model 데이터 출력 ----------->
                    </tbody>
                </table> <!-- /.table-responsive -->
			</c:if>	
			<!-- END 리스트 출력 구간 --------------------------------------->
			
			<br>
			
			<!-- paging -------------------------------->
                <div class="pull-right">
					<ul class="pagination justify-content-center custom-pagination">
						<%-- 이전 버튼 --%>
						<c:if test="${pageDTO.prev }">
						<li class="page-item">
							<a href="${pageDTO.start - 1}" 
							   class="page-link">&laquo; Previous</a></c:if>
						
						<%-- 페이지 번호 버튼 --%>
						<c:forEach begin="${pageDTO.start }" 
								   end="${pageDTO.end }" var="i">
						<%-- <c:url var="link" value=""/> --%>
						<li class="page-item ${pageDTO.socri.pageNum == i ? 'active' : '' }">
							<a href="${i }" 
							   class="page-link">${i }</a>
						</c:forEach>
						
						<%-- 다음 버튼 --%>
						<c:if test="${pageDTO.next }">
						<li class="page-item">
							<a href="${pageDTO.end + 1}" 
							   class="page-link">Next &raquo;</a></c:if>
					</ul>					
                </div>
			<!-- END paging -------------------------------->

            <!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
			<form action="/odReview/myList" id="actionFrm">
				<input type="hidden" name="pageNum" value="${pageDTO.socri.pageNum}">
				<input type="hidden" name="amount"  value="${pageDTO.socri.amount}">
				<input type="hidden" name="type"  value="${pageDTO.socri.type}">
				<input type="hidden" name="keyword"  value="${pageDTO.socri.keyword}">
				<input type="hidden" name="mid" value="<sec:authentication property="principal.Username"/>">
				
				<!-- 시큐리티 -->
	          	<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
			</form>		

		</div><!-- End container -->
	    </div><!-- End portfolio-description -->
    </div><!-- End col-lg-8 mx-auto -->
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

//	$(function(){				//이거 붙여야 할 수도..? 게시글 등록, 삭제 후 목록으로 접속한 경우, 스크립트태그를 먼저 스캔하게 하려고

//페이징 이벤트 처리 ------------------------------
var actionFrm = $('#actionFrm');

$('.page-item a').on('click', function(e){						//페이징 버튼을 클릭하면
	e.preventDefault();
	
	//a 태그의 href 값을 actionFrm의 pageNum에 저장
	actionFrm.find("input[name='pageNum']")
			 	   .val($(this).attr('href'));
	
	actionFrm.submit();
});
//END 페이징 이벤트 처리 ------------------------------


//게시물 제목 클릭 이벤트 처리 ------------------------------
//단계 : 제목 클릭 > actionFrm에 hidden태그 추가 > action의 속성 변경 > 컨트롤러 도착   => 컨트롤러에 amount에 pageNum받을 수 있도록 만들어주기

$('.move').on('click', function(e){
	e.preventDefault();							//<a>태그의 href로 이동하는 것을 막음

	//a 태그의 href 값을 odNo에 저장 
	actionFrm.append("<input type='hidden' name='orNo' value='" + $(this).attr('href') + "'>");	 //this : <a>태그
	actionFrm.append("<input type='hidden' name='mid' value='" + '${pageContext.request.userPrincipal.name}' + "'>");
	
	//action의 속성값을 컨트롤러의 view메서드로 바꿔주기
	actionFrm.attr('action', '/odReview/view');
	
	actionFrm.submit();
});

//END 게시물 제목 클릭 이벤트 처리 ------------------------------




//		});//END 		//일단 다시 뗌


</script>


</body>
</html>
