<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시공작업스케줄</title>

<style>
#notice {
	color: red;
}

.reqNotice {
	text-align: center;
	color: red;
} /*이미 신청했거나 모집마감된 게시글이라고 알려줄 때 */
#odTitleBox {
	border: 2px solid #FFA500; /* 진노랑색 테두리 */
	padding: 10px; /* 텍스트와 테두리 사이의 간격을 10px로 지정 */
}

.regiItemNm {
	width: 150px;
	font-weight: bold;
}

.regiItem {
	width: 200px;
	border: none; /* 테두리 없음 */
	outline: none; /* 포커스 표시 없음 */
}

.imgNotice {
	font-size: 10px;
	color: lightcoral;
}

#odItem {
	margin-bottom: 20px;
}

#pvoImg {
	width: 40%;
	display: block;
	margin: auto;
} /* 띄울 사진 크기*/
.tags, p {
	color: #F44336;
}

.regiText {
	color: #FFA000;
}

.reqForm {
	background-color: #FFF8E1;
}

/* 원데이클래스 게시글 제목(링크)에 마우스 올리면 색상변화 */
.content a:hover {
	color: black;
}

/* 첨부파일 표시하는 li태그에 블릿 제거 */
li {
	list-style: none;
}

/* 첨부파일 크기 조절*/
.uploadResult ul li img {
	max-width: 100%; /* 이미지를 부모 요소 너비에 맞게 조절 */
	max-height: auto;
	display: block;
}
</style>

</head>
<body>
	<!-- ======= header ======= -->
	<%@ include file="../includes/header.jsp"%>

	<!--======= main ======= -->
	<main id="main">

		<!-- ======= Breadcrumbs ======= -->
		<div class="breadcrumbs d-flex align-items-center"
			style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
			<div
				class="container position-relative d-flex flex-column align-items-center"
				data-aos="fade">
				<h2>Schedule Detail</h2>
			</div>
		</div>
		<!-- End Breadcrumbs -->

		<!-- 원데이클래스 신청완료 메시지가 있는 경우, qnaListAll.jsp로 돌아오면서 msg내용을 alert으로 띄우기 -->
		<c:if test="${!empty msg }">
			<script>
				alert('${msg}');
			</script>
		</c:if>

		<!-- ======= 원데이클래스 후기 상세조회 ======= -->

		<section id="blog" class="blog">
			<div class="container" data-aos="fade-up" data-aos-delay="100">
				<div class="row g-5">
					<div class="col-lg-8 mx-auto">
						<article class="blog-details">

							<h2 class="title">시공작업번호-${sicheVO.sicheNo }</h2>
							<br>
							<!-- ======= 상세내용이 표시되기 시작함 ======= -->
							<div class="content">
								<br>
								<!--------------------- 후기 상세조회 -------------------->
								<div class="form-group" id="odItem">
									<label class="regiItemNm">시공의뢰번호</label>${sicheVO.sireqNo }
								</div>
								<div class="form-group" id="odItem">
									<label class="regiItemNm">견적서번호</label>${sicheVO.quoNo }
								</div>
								<div class="form-group" id="odItem">
									<label class="regiItemNm">의뢰인</label>${sicheVO.mid }님
								</div>
								<div class="form-group" id="odItem">
									<label class="regiItemNm">잔금처리현황</label>${sicheVO.balanceStatus }
								</div>
								<div class="form-group" id="odItem">
									<label class="regiItemNm">시공진행현황</label>${sicheVO.constructionStatus }
								</div>
								<div class="form-group" id="odItem">
									<label class="regiItemNm">작업할 시공팀</label>${sicheVO.workCrew}
								</div>
								<div class="form-group" id="odItem">
									<label class="regiItemNm">시공 일정</label>
									<fmt:formatDate value="${sicheVO.startDate}"
										pattern="yyyy-MM-dd" />
									~
									<fmt:formatDate value="${sicheVO.endDate}" pattern="yyyy-MM-dd" />
								</div>
								<div class="form-group" id="odItem">
									<label class="regiItemNm">주택유형</label>${sicheVO.buildingType}
								</div>


								<br>
								<hr>
								<br>


							</div>
							<!-- End post content -->

						</article>
						<!-- End blog post -->
					</div>
				</div>
			</div>
		</section>
		<!-- End Blog Details Section -->
		<div class="text-center" id="btn-group">
			<button type="button" class="btn btn-secondary"
				onclick="window.close()">닫기</button>

	 		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a href="/sischedule/sicheModify?sicheNo=${sicheVO.sicheNo }"
				class="btn btn-warning">수정</a>
			<button type="button" id="RemoveBtn" class="btn btn-danger">삭제</button>
			<c:if test="${sicheVO.constructionStatus=='시공완료' }">
			<a href="/showcase/caseRegist?sicheNo=${sicheVO.sicheNo }"
				class="btn btn-primary">시공사례 등록</a></c:if>
			</sec:authorize>

		</div>
		<br>
		<br>
		<br>


	</main>
	<!-- End #main -->

	<%@ include file="../includes/footer.jsp"%>
	<script>
	var csrfHeaderName = '${_csrf.headerName}';//csrf 토큰 관련 변수
	var csrfTokenValue = '${_csrf.token}';
	$('#RemoveBtn').on('click', function() {
	    if(confirm('삭제하시겠습니까?')) {
	        $.ajax({
	            url: "/sischedule/sicheRemove",
	            type: "post",
	            data: { 
	                sicheNo: ${sicheVO.sicheNo }       
	            },
	            beforeSend : function(xhr) {//xhr; xml http request
					//전송 전 csrf 헤더 설정	
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
	            success: function(response) {
	                alert('삭제가 완료되었습니다.');
	                window.close();
	            },
	            error: function(xhr, status, error) {
	                alert('삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
	            }
	        });
	    }
	});
	</script>