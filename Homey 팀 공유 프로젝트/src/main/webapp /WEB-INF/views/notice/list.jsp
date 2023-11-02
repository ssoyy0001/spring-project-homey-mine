<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 전체 조회</title>
<style type="text/css">
/* 현재 클릭된 페이징 버튼 */
.custom-pagination .page-item.active .page-link {
	border-color: #ffc107;
	background-color: #ffc107;
	color: black;
}

/* 비활성 버튼 스타일 */
.custom-pagination .page-item .page-link {
	border-color: #ffc107;
	background-color: white;
	color: #ffc107;
}
/* 페이징 버튼 가운데 정렬 */
.pagination {
	justify-content: center;
	margin-top: 10px;
}
/* 검색 버튼 */
#searchBtn {
	border-color: #ffc107;
	background-color: #ffc107;
}
/* 카테고리 버튼 */
#categoryBtn {
	float: left;
	border-color: #ffc107;
	background-color: #ffc107;
}
</style>
</head>
<body>

	<!-- ======= header ======= -->
	<%@ include file="../includes/header.jsp"%>

	<!-- ======= main ======= -->
	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<div class="breadcrumbs d-flex align-items-center"
			style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
			<div
				class="container position-relative d-flex flex-column align-items-center"
				data-aos="fade">
				<h2>
					<a href="/notice/list">공지사항</a>
				</h2>
				<!-- 클릭시 초기 리스트로 -->
				<h4 style="color: white;">일반 / 서비스 안내</h4>
			</div>
		</div>
		<!-- End Breadcrumbs -->

		<section id="services" class="services section-bg blog">
			<!-- blog를 추가해야 사이드바 스타일 활성화  -->
			<div class="container" data-aos="fade-up">
				<div class="row g-3">

					<!-- 검색 -->
					<form action="/notice/list" id="searchFrm">
						<!-- 카테고리 선택 -->
						<div id="categoryBtn">
							<button class="btn btn-sm searchBtn"
								onclick="selectCategory('일반')">일반</button>
							<button class="btn btn-sm searchBtn"
								onclick="selectCategory('서비스안내')">서비스안내</button>
						</div>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
							<select name="type">
								<option value="T"
									<c:if test="${pageDTO.cri.type == 'T'}">selected</c:if>>제목</option>
								<!--  검색 타입 남겨놓기-->
								<option value="C"
									<c:if test="${pageDTO.cri.type == 'C'}">selected</c:if>>내용</option>
								<option value="W"
									<c:if test="${pageDTO.cri.type == 'W'}">selected</c:if>>작성자</option>
								<option value="TC"
									<c:if test="${pageDTO.cri.type == 'TC'}">selected</c:if>>제목
									or 내용</option>
								<option value="TW"
									<c:if test="${pageDTO.cri.type == 'TW'}">selected</c:if>>제목
									or 작성자</option>
								<option value="TCW"
									<c:if test="${pageDTO.cri.type == 'TCW'}">selected</c:if>>제목
									or 내용 or 작성자</option>
								<option value="G"
									<c:if test="${pageDTO.cri.type == 'G'}">selected</c:if>>카테고리</option>
							</select> <input type="text" name="keyword"
								value="${pageDTO.cri.keyword }">
							<!-- 검색 키워드 남겨놓기 -->
							<button class="btn btn-sm searchBtn" id="searchBtn">검색</button>
							<input type="hidden" name="pageNum"
								value="${pageDTO.cri.pageNum}"> <input type="hidden"
								name="amount" value="${pageDTO.cri.amount}">
							<!-- 공지사항 등록(관리자만) -->
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<button id="regBtn" type="button" class="btn btn-warning btn-sm">
									등록</button>
							</sec:authorize>
						</div>
					</form>
					<!-- END 검색 -->

					<!-- 게시물이 없는 경우 -->
					<c:if test="${empty noticeList }">
						<div class="row">
							<div class="col" align="center">
								<p class="alert alert-warning p-5">등록된 글이 없습니다.</p>
							</div>
						</div>
					</c:if>

					<!-- 공지사항 전체 조회 표시 구간 -->
					<c:if test="${!empty noticeList }">
						<table class="table caption-top table-hover">
							<caption>전체 게시물 ${totalCount }건</caption>
							<!-- 공지사항 전체 개수 -->
							<thead>
								<tr class="table-active">
									<!-- table-active : 행 강조 -->
									<th class="text-center">No.</th>
									<th class="text-center">분류</th>
									<th class="text-center">제목</th>
									<th class="text-center">작성자</th>
									<th class="text-center">작성일자</th>
									<th class="text-center">조회수</th>
								</tr>
							</thead>
							<tbody>
								<!-- Model 데이터 출력 -->
								<c:forEach items="${noticeList}" var="nvo">
									<tr>
										<td class="text-center">${nvo.notNo}</td>
										<td class="text-center">${nvo.notCategory}</td>
										<td class="text-center"><a class="move"
											href="${nvo.notNo}"> ${nvo.notTitle} </a></td>
										<td class="text-center">${nvo.mid}</td>
										<td class="text-center"><fmt:formatDate
												value="${nvo.notDate}" pattern="yyyy-MM-dd" /></td>
										<td class="text-center">${nvo.notHit }</td>
									</tr>
								</c:forEach>
								<!-- END Model 데이터 출력 -->
							</tbody>
						</table>
					</c:if>
					<form>
						<!-- 페이지 번호와 페이지에 표시할 게시물의 수 -->
						<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
					</form>
					<!-- END -----------검색 타입 및 검색 키워드 -->

					<!-- paging -------------------------------->
					<ul class="pagination custom-pagination">
						<%-- 이전 버튼 --%>
						<c:if test="${pageDTO.prev }">
							<li class="page-item"><a href="${pageDTO.start - 1}"
								class="page-link">&laquo; Previous</a>
						</c:if>

						<%-- 페이지 번호 버튼 --%>
						<c:forEach begin="${pageDTO.start }" end="${pageDTO.end }" var="i">
							<%-- <c:url var="link" value=""/> --%>
							<li
								class="page-item ${pageDTO.cri.pageNum == i ? 'active' : '' }">
								<a href="${i }" class="page-link">${i }</a>
						</c:forEach>

						<%-- 다음 버튼 --%>
						<c:if test="${pageDTO.next }">
							<li class="page-item"><a href="${pageDTO.end + 1}"
								class="page-link">Next &raquo;</a>
						</c:if>
					</ul>
					<!-- END paging -->

					<!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
					<form action="/notice/list" id="actionFrm">
						<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
						<input type="hidden" name="type" value="${pageDTO.cri.type}">
						<input type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
						<!-- VIEW페이지에 갔다왔더라도 검색 기능 남아있음 -->
					</form>

					<!-- Modal 게시물 등록 완료 시 표시 -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">MESSAGE</h4>
								</div>
								<div class="modal-body">처리가 완료되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary close"
										data-dismiss="modal">Close</button>
<!-- 									                           <button type="button" class="btn btn-primary">Save changes</button> -->
								</div>
							</div>
<!-- 							/.modal-content -->
						</div>
<!-- 						/.modal-dialog -->
					</div>
<!-- 					/.modal -->

					
				</div>
			</div>
		</section>
	</main>

	<!-- ======= script ======= -->
	<script>
	$(function() {
	    // 모달 창 닫기
	    $('.close').on('click', function() {
	        $('#myModal').modal('hide');
	    });
	});
	
	
		/* 카테고리별 조회 */
		function selectCategory(category) {
			document.querySelector('select[name="type"]').value = 'G'; // 카테고리 선택
			document.querySelector('input[name="keyword"]').value = category; // 카테고리 키워드 입력
			document.getElementById('searchFrm').submit(); // 폼 제출
		}
		/* END 카테고리별 조회 */

		$(function() {
			//검색 버튼 이벤트 처리 ---------------------------
			var searchFrm = $('#searchFrm');

			$('.searchBtn').on('click', function() {
				//검색 키워드를 입력하지 않은 경우
				if (searchFrm.find("input[name='keyword']").val() == '') {
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

			$('.page-item a').on(
					'click',
					function(e) {
						e.preventDefault();

						//a 태그의 href 값을 pageNum에 저장
						actionFrm.find("input[name='pageNum']").val(
								$(this).attr('href'));

						actionFrm.submit();
					});
			//END 페이징 이벤트 처리 ------------------------------

			//게시물 제목 클릭 이벤트 처리 -----------------------
			$('.move')
					.on(
							'click',
							function(e) {
								e.preventDefault();

								//hidden 태그를 생성하여 이름을 bno로 지정하고
								//a 태그의 href 값을 bno에 저장한 후 actionFrm에 추가
								actionFrm
										.append("<input type='hidden' name='notNo' value='"
												+ $(this).attr('href') + "'>");

								actionFrm.attr('action', '/notice/view');

								actionFrm.submit();
							});
			//END 게시물 제목 클릭 이벤트 처리 -------------------

			//게시물 처리 결과 알림 모달창 처리 -------------------
			var result = '${result}';
			checkModal(result);

			//모달 창 재출력 방지
			history.replaceState({}, null, null); //history 초기화

			function checkModal(result) {
				//result 값이 있는 경우에 모달 창 표시
				if (result === '' || history.state) {
					return;
				}

				if (parseInt(result) > 0) { //게시물이 등록된 경우
					$('.modal-body').html(result + '번 게시물이 등록되었습니다.');
				}

				$('#myModal').modal('show');
			}
			//END 게시물 처리 결과 알림 모달창 처리

			//게시물 등록 버튼 클릭 이벤트 처리 -------------------
			$('#regBtn').on('click', function() {
				self.location = "/notice/register";
			});
			//END 게시물 등록 버튼 클릭 이벤트 처리
		});//END $
	</script>
	<!-- ======= END script ======= -->


	<!-- ======= Footer ======= -->
	<%@ include file="../includes/footer.jsp"%>
	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
	<div id="preloader"></div>
	<!-- Vendor JS Files -->
	<script
		src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="../resources/assets/vendor/aos/aos.js"></script>
	<script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script
		src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script
		src="../resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
	<script src="../resources/assets/vendor/php-email-form/validate.js"></script>
	<!-- Template Main JS File -->
	<script src="../resources/assets/js/main.js"></script>
	<!-- ======= END Footer ======= -->
</body>
</html>
