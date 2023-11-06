<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
.alert{height: 300px;}
</style>
<body>
<main id="main">
	<c:if test="${!empty msg }">
		<script>
			alert('${msg}');
	</script>
	</c:if>

	<!-- ======= Breadcrumbs ======= -->
	<div class="breadcrumbs d-flex align-items-center"
		style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
		<div
			class="container position-relative d-flex flex-column align-items-center"
			data-aos="fade">

			<h2>My Scrab</h2>


		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- ======= Our Projects Section ======= -->
	<section id="projects" class="projects">
		<div class="container" data-aos="fade-up">
			<div class="row justify-content-between gy-4 mt-4">
				<div class="col-lg-9 mx-auto">
					<div class="portfolio-isotope" data-portfolio-filter="*"
						data-portfolio-layout="masonry"
						data-portfolio-sort="original-order">

						<!-- End Projects Filters -->
						<!-- End Projects Filters -->
						<sec:authorize access="isAuthenticated()">
							<input type="hidden" id="mid"
								value="<sec:authentication property='principal.username' />">
						</sec:authorize>
						<sec:authorize access="!isAuthenticated()">
							<input type="hidden" id="mid" value="">
						</sec:authorize>
						<c:if test="${empty list }">
					<div class="row">
						<div class="col" align="center">
							<p class="alert alert-warning p-5">등록된 게시글이 없습니다.</p>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty list }">
						<div class="row gy-4 portfolio-container" data-aos="fade-up"
							data-aos-delay="200">
							<c:forEach items="${list}" var="showcase" varStatus="status">
								<div class="col-lg-4 col-md-6 portfolio-item filter-remodeling">
									<div class="portfolio-content h-100">
										<!-- imageId 변수로 img 태그의 id 속성 값을 설정합니다. -->
										<img src="../resources/assets/img/projects/construction-1.jpg"
											class="img-fluid" id="image_${status.index}"
											style="height: 300px">
										<div class="portfolio-info">

											<i class="fa-solid fa-star fa-beat" id="star_${status.index}"
												style="background-color: none"></i>

											<p>${showcase.scTitle}</p>
											<a href="${showcase.scid }" title="More Details"
												class="details-link" style="left: 45%"> <i
												class="fa-solid fa-plus"></i></a>
										</div>
									</div>

									<!-- JavaScript 코드를 여기에 배치합니다 -->
									<script type="text/javascript">
     var upFolder = "${showcase.attachList[0].upFolder.replace("\\", "/")}";
      var uuid = "${showcase.attachList[0].uuid}";
      var fileName = "${showcase.attachList[0].fileName}";

      var imagePath = encodeURIComponent(upFolder + "/" + uuid + "_" + fileName);

      // 사용자마다 고유한 ID를 가진 imageId 값
      var imageId = "image_" + ${status.index};

 	document.getElementById(imageId).src = "/display?fileName="+imagePath; 
 	
 	var scid='${showcase.scid}'
 	var csrfHeaderName = '${_csrf.headerName}';//csrf 토큰 관련 변수
	var csrfTokenValue = '${_csrf.token}';
 	var starId="star_" + ${status.index};
 	var mid=$('#mid').val();
 	function scrabCnt(starId){//게시물의 scrab수
		$.ajax({
	        url: "/scrab/scrabCnt", // AJAX 요청을 보낼 URL
	        type: "POST", // HTTP 요청 방식 (POST)
	        data: {
	            scid: scid, // scid 값 설정 (원하는 값으로 변경)
	        },
	        dataType: 'text',
	        beforeSend : function(xhr) {//xhr; xml http request
				//전송 전 csrf 헤더 설정    
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
	        success: function(result, status, xhr) {
	        	document.getElementById(starId).innerHTML = result;
	        },
	        error: function(xhr, status, error) {
	       	console.log(error);
	        }
	    });
	}
	scrabCnt(starId);
	function updateStar(starId){//개인마다 스크랩 표시
		  $.ajax({
		        url: "/scrab/isScrab", // AJAX 요청을 보낼 URL
		        type: "POST", // HTTP 요청 방식 (POST)
		        data: {
		            scid: scid, // scid 값 설정 (원하는 값으로 변경)
		            mid: mid // mid 값 설정 (원하는 값으로 변경)
		        },
		        beforeSend : function(xhr) {//xhr; xml http request
					//전송 전 csrf 헤더 설정    
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
		        success: function(response) {
		            if (response == 'scrab') {
		            	document.getElementById(starId).style.color = "yellow";
		            } else{
		            	document.getElementById(starId).style.color = "white";
		            }      
		        },
		        error: function(xhr, status, error) {
		        	
		        }
		    });
	}
	updateStar(starId);
    </script>

								</div>
								<!-- End Projects Item -->
							</c:forEach>



						</div>
						<!-- End Projects Container -->
						</c:if>
					</div>
				</div><%@ include file="../includes/sideMenuMem.jsp"%></div>

		</div>
	</section>
	<div class="pull-right">
		<ul class="pagination justify-content-center custom-pagination">
			<%-- 이전 버튼 --%>
			<c:if test="${pageDTO.prev }">
				<li class="page-item"><a href="${pageDTO.start - 1}"
					class="page-link">&laquo; Previous</a>
			</c:if>

			<%-- 페이지 번호 버튼 --%>
			<c:forEach begin="${pageDTO.start }" end="${pageDTO.end }" var="i">
				<%-- <c:url var="link" value=""/> --%>
				<li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : '' }">
					<a href="${i }" class="page-link">${i }</a>
			</c:forEach>

			<%-- 다음 버튼 --%>
			<c:if test="${pageDTO.next }">
				<li class="page-item"><a href="${pageDTO.end + 1}"
					class="page-link">Next &raquo;</a>
			</c:if>
		</ul>
	</div>
	<!-- END paging -------------------------------->

	<!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
	<form action="/showcase/caseList?pageNum=1&amount=12" id="actionFrm">
		<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
		<input type="hidden" name="totalRange"
			value="${pageDTO.cri.totalRange}"> <input type="hidden"
			name="sizeRange" value="${pageDTO.cri.sizeRange}"> <input
			type="hidden" name="buildingType" value="${pageDTO.cri.buildingType}">
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }">
	</form>
	<!-- End Our Projects Section -->

</main>
</body>
<!-- End #main -->
<script>
var actionFrm = $('#actionFrm');

$('.page-item a').on('click', function(e){						//페이징 버튼을 클릭하면
	e.preventDefault();
	
	//a 태그의 href 값을 actionFrm의 pageNum에 저장
	actionFrm.find("input[name='pageNum']")
			 	   .val($(this).attr('href'));
	
	actionFrm.submit();
});


$('.details-link').on('click',function(e){//카테고리값들 넘기기위해
	e.preventDefault();
	actionFrm.append("<input type='hidden' name='scid' value='" + 
			$(this).attr('href') + "'>")
	actionFrm.attr('action', '/showcase/caseView');
	actionFrm.submit();
});
</script>
<%@ include file="../includes/footer.jsp"%>
