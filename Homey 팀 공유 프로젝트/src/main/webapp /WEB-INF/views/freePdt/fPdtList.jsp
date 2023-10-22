<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 나눔 목록</title>

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
tbody a:hover { color : black; }			


/* 테이블의 텍스트 가운데 정렬, 제목만 왼쪽 정렬 */
table {  text-align: center;
			 font-size: 14px; }
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
    <h2>HOMEY Ptoduct Trial</h2>
  </div>
</div><!-- End Breadcrumbs -->


<!-- 문의글 등록/삭제 완료 메시지가 있는 경우, fPdtList.jsp로 돌아오면서 msg내용을 alert으로 띄우기 --> 
<c:if test="${!empty msg }">
	<script>
			alert('${msg}');
	</script>
</c:if>


<!-- ======= 원데이클래스 게시글 목록 ======= -->
 
<section id="project-details" class="project-details">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-description">
	    
	        <h2>📃 제품 나눔 안내글 목록</h2>
			<br>
			
			<div class="container">
			
			<!-- 검색 타입 및 검색 키워드 --------------------------------------->
	        <!-- 타입 : 제목T, 내용C, 제목/내용TC -->
			<div class="row">
				<div class="col-lg-12">
		        <form id="searchFrm" action="/freePdt/list">
		        	<select name="type">
						<option value="T" ${pageDTO.cri.type == 'T' ? 'selected' : ''} >제목</option>
						<option value="C" ${pageDTO.cri.type == 'C' ? 'selected' : ''}>내용</option>
						<option value="TC" ${pageDTO.cri.type == 'TC' ? 'selected' : ''}>제목 or 내용</option>
					</select>
					<input type="text" name="keyword" value="${pageDTO.cri.keyword }"/>
					<button class="btn btn-outline-warning btn-xs searchBtn">검색</button>
		                	
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
		          	<input type="hidden" name="amount"  value="${pageDTO.cri.amount}">
		        </form>
	           	</div>
	        </div>
		    <!-- END 검색 타입 및 검색 키워드  ---------------------------------->
		
			<br>
			
			<!-- 리스트 출력 시작 구간 --------------------------------------->
			<!-- 게시물이 없는 경우 -->
			<c:if test="${empty list }">
				<div class="row">
				<div class="col" align="center"> 
					<p class="alert alert-warning p-5">
						등록된 게시글이 없습니다.
					</p>
				</div>
				</div>
			</c:if>	
			
			<!-- 게시물이 있는 경우 -->
			<c:if test="${!empty list }">
				<table class="table table-hover">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>모집현황</th>
                            <th>게시글 제목</th>
                            <th>참여인원</th>
                            <th>모집인원</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <!------------- Model 데이터 출력 ---------------> 
                    <c:forEach items="${list }" var="fpvo">
                  		<tr>
                  			<td>${fpvo.fpRn }</td>
                  			<td>
                  				<c:choose>
		                            <c:when test="${fpvo.fpState == 0}">나눔중</c:when>
		                            <c:when test="${fpvo.fpState == 1}">신청마감</c:when>
		                        </c:choose>
                  			</td>
                  			<td class="title"><a class="move" href="${fpvo.fpNo }">${fpvo.fpTitle }</a>	</td><!-- href의 나머지 내용은 스크립트에서 처리-->
                  			<td>${fpvo.fpNowPeople }</td>
                  			<td>${fpvo.fpPeople }</td>
                  			<td><fmt:formatDate value="${fpvo.fpWDate}" pattern="yyyy-MM-dd"/></td>
                  		</tr>
                    </c:forEach>
                    <!------------- END Model 데이터 출력 ----------->
                    </tbody>
                </table> <!-- /.table-responsive -->
			</c:if>	
			<!-- END 리스트 출력 구간 --------------------------------------->
			
			<br>
			<!------ 글작성 버튼 ------>
			<div class="text-center">
				<sec:authorize access="hasRole('ROLE_ADMIN')"><!-- ROLE_ADMIN 권한을 가진 사람이 로그인했을 때만 버튼 표시 -->
			    <a href="/freePdt/register" class="btn btn-warning">글작성</a>
			    </sec:authorize>
			</div>
			
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
						<li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : '' }">
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
				<form action="/freePdt/list" id="actionFrm">
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
					<input type="hidden" name="amount"  value="${pageDTO.cri.amount}">
					<input type="hidden" name="type"  value="${pageDTO.cri.type}">
					<input type="hidden" name="keyword"  value="${pageDTO.cri.keyword}">
				</form>		

		</div><!-- End container -->
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

//	$(function(){				//이거 붙여야 할 수도..? 게시글 등록, 삭제 후 목록으로 접속한 경우, 스크립트태그를 먼저 스캔하게 하려고

//검색 버튼 이벤트 처리 ---------------------------
var searchFrm = $('#searchFrm');

$('.searchBtn').on('click', function(e){
	
	//검색어 없이 검색버튼 클릭 시 얼럿 뜨도록 -> searchFrm.submit() 보다 위에 있어야 함
    if (searchFrm.find("input[name='keyword']").val() === "") {		//이렇게 하거나, 아님 input에 아이디 붙여서 #OOO으로 간단하게 써도 됨
        alert("검색어를 입력하세요.");
    	return false;
    }
	
    //검색버튼을 눌렀을 때, pageNum이 1페이지로 바뀌도록
    searchFrm.find("input[name='pageNum']")
					.val(1);
    searchFrm.submit();
});
	
//END 검색 버튼 이벤트 처리 ---------------------


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
	
	//hidden태그를 생성하여 이름을 fpNo로 지정하고,
	//a 태그의 href 값을 fpNo에 저장 
	actionFrm.append("<input type='hidden' name='fpNo' value='" + $(this).attr('href') + "'>");	 //this : <a>태그
	
	//"freePdt/view"로 갈 때, mid도 보내야 함. (중복신청체크! 원데이클래스 신청하기 버튼 표시 유무 때문에)
	actionFrm.append("<input type='hidden' name='mid' value='" + '${pageContext.request.userPrincipal.name}' + "'>");
	
	//원래 form의 actionform은 "/oneday/list"였는데, 이제 게시글제목을 클릭했기 때문에 view페이지로 이동해야 함.
	//action의 속성값을 컨트롤러의 view메서드로 바꿔주기
	actionFrm.attr('action', '/freePdt/view');
	
	actionFrm.submit();
});

//END 게시물 제목 클릭 이벤트 처리 ------------------------------


//		});//END 		//function~ 넣게 되면 살려야 함


</script>


</body>
</html>
