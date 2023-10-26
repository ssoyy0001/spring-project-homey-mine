<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>견적상담 전체 조회</title>
<style type="text/css">
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
/* 페이징 버튼 가운데 정렬 */
.pagination {
	justify-content: center;
	margin-top: 10px;
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
    <h2><a href="/consult/list">견적상담 전체 조회</a></h2> <!-- 클릭시 초기 리스트로 -->
  </div>
</div><!-- End Breadcrumbs -->

<!-- ======= 견적상담 전체 조회 표시 구간 ======= -->
    <section id="services" class="services section-bg blog"> <!-- blog를 추가해야 사이드바 스타일 활성화  -->
      <div class="container" data-aos="fade-up">
        <div class="row g-3">
    <!-- 견적상담 개수 표시 구간  -->
     <h3>견적 신청내역 ${totalCount }개</h3>
     <hr><!-- END 견적상담 개수 표시 구간  -->
    
    <!-- 검색 타입 및 검색 키워드 :: 견적 상담번호, 건물 유형 -->
		<form action="/consult/list" id="searchFrm">
		    <select name="type" style="height: 30px"> <!-- 검색어 입력칸과 높이 맞추기 -->
		        <option value="C" <c:if test="${pageDTO.cri.type == 'C'}">selected</c:if>>견적상담번호</option> <!--  검색 타입 남겨놓기-->
		        <option value="B" <c:if test="${pageDTO.cri.type == 'B'}">selected</c:if>>건물유형</option>
		    </select>
		    <input type="text" name="keyword"  value="${pageDTO.cri.keyword }" placeholder="상담번호는 숫자만 입력"> <!-- 검색 키워드 남겨놓기 -->
		    <button class="btn btn-default btn-sm searchBtn"><i class="bi bi-search"></i></button>
		    <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
		    <input type="hidden" name="amount"  value="${pageDTO.cri.amount}">
		</form>   		   
			<!-- 페이지 번호와 페이지에 표시할 게시물의 수 -->   
			<form>
			<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
			<input type="hidden" name="amount"  value="${pageDTO.cri.amount}">
			</form>   
	 <!-- END 검색 :: 견적 상담번호 -->

		<!-- 반복될 구간 -->
		<c:forEach items="${consultList}" var="cvo"> <!-- 컨트롤러 model에 담은 이름 그대로 -->
          <div class="col-lg-4 col-md-6 move" data-aos="fade-up" data-aos-delay="100">
            <div class="service-item  position-relative">
              <div class="icon">
                <i class="fa-solid fa-mountain-city"></i>
              </div>
              <h3>${cvo.buildingType}, ${cvo.address}</h3> <!-- 제목 -->
              <p>견적 상담 번호 : ${cvo.consultNo}</p>
              <p>견적 신청 날짜 : <fmt:formatDate value="${cvo.consultDate}" pattern="yyyy-MM-dd"/></p>
              <a href="/consult/consultManage?consultNo=${cvo.consultNo}" class="readmore stretched-link" data-consultno="${cvo.consultNo}">상세조회 <i class="bi bi-arrow-right"></i></a>
              	<!-- data-consultno : 상세 조회 값 보내야할 견적상담번호 표시-->
            </div>
          </div><!-- End Service Item -->
         </c:forEach> 
		<!-- 반복될 구간 END -->
    
    <!-- 페이징 -->
   <div>
		<ul class="pagination custom-pagination"> <!-- bootstrap4부터는 pull이 아니라 float , float-end는 오른쪽 끝-->
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
    <!-- 페이징 END -->
    
<!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
<form action="/consult/list" id="actionFrm">
	<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
	<input type="hidden" name="amount"  value="${pageDTO.cri.amount}">
	<input type="hidden" name="type"  value="${pageDTO.cri.type}">
	<input type="hidden" name="keyword"  value="${pageDTO.cri.keyword}"> <!-- VIEW페이지에 갔다왔더라도 검색 기능 남아있음 -->
</form>
				<%@ include file="../includes/sideMenuAdm.jsp"%>
    		</div>
        </div>
    </section><!-- End 견적상담 전체 조회 표시 구간  -->
</main>
<!--======= END main ======= -->

<!-- ======= script ======= -->
<script>
// consult/consultManage에서 견적상담 삭제 및 수정 성공 시 처리결과 alert창 표시 ----------------
$(document).ready(function () { // 페이지 로드하자마자
    var resultD = '${resultD}';
    var resultM = '${resultM}';
    
    checkResult(resultD, '삭제'); //뒤에오는게 action
    checkResult(resultM, '수정');
});

function checkResult(result, action) {
    if (result) {
        showAlert(result + '번 견적상담이 ' + action + '되었습니다.');
    }
}

function showAlert(message) {
    alert(message);
}
// END 결과 확인 및 alert 표시

$(function(){
	//58번 라인부터 하나의 견적상담 내용 클릭 시 이벤트 처리(상세조회로 보낼 값) -----------------------
	$('.move').on('click', function(e){
		e.preventDefault();
		const consultNo = $(this).find('.readmore').data('consultno');
		
		//hidden 태그를 생성하여 이름을 consultNo로 지정하고
		// 클릭한 요소의 "data-consultno" 값을 추가
		actionFrm.append("<input type='hidden' name='consultNo' value='" + consultNo + "'>");

		actionFrm.attr('action', '/consult/consultManage');
		
		actionFrm.submit();
	});
	//END 하나의 견적상담 내용 클릭 시 이벤트 처리-------------------
	
	//검색 버튼 이벤트 처리 ---------------------------
		var searchFrm = $('#searchFrm');
	
	$('.searchBtn').on('click', function(){
		//검색 키워드를 입력하지 않은 경우
			if(searchFrm.find("input[name='keyword']").val()==''){
				alert('검색 키워드를 입력하세요');
				return false;		
			}
		//검색 시 페이지 번호를 1이 되도록 설정
			searchFrm.find("input[name='pageNum']").val('1');
			searchFrm.submit();		
	});
	// END 검색 버튼 이벤트 처리 ---------------------------
	
	//페이징 이벤트 처리 ------------------------------
	var actionFrm = $('#actionFrm');
	
	$('.page-item a').on('click', function(e){
		e.preventDefault();
		
		//a 태그의 href 값을 pageNum에 저장
		actionFrm.find("input[name='pageNum']")
				 .val($(this).attr('href'));
		
		actionFrm.submit();
	});
	//END 페이징 이벤트 처리 ------------------------------
});//END $
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
