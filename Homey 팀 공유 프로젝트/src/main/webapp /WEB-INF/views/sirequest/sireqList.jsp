<%@ include file="../includes/header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
@import
	url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900')
	;

body {
	font-family: 'Poppins', sans-serif;
	font-weight: 700;
	font-size: 17px;
	line-height: 1.7;
	color: var(- -color-secondary);
	margin-bottom: 20px;
	background-color: white;
	overflow-x: hidden;
}

a {
	cursor: pointer;
	transition: all 200ms linear;
}

a:hover {
	text-decoration: none;
}

.link {
	color: #c4c3ca;
}

.link:hover {
	color: #ffeba7;
}

p {
	font-weight: 500;
	font-size: 14px;
	line-height: 1.7;
}

h4 {
	font-weight: 600;
}

h6 span {
	padding: 0 20px;
	text-transform: uppercase;
	font-weight: 700;
}

.section {
	position: relative;
	width: 100%;
	display: block;
}

.full-height {
	min-height: 100vh;
}

.card-front, .card-back {
	width: 100%;
	height: 100%;
	background-color: #2a2b38;
	background-image:
		url('https://cdn.pixabay.com/photo/2014/02/25/22/06/staircase-274614_1280.jpg');
	/* url ('https: //s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg'); */
	background-position: bottom center;
	background-repeat: no-repeat;
	background-size: 300%;
	position: absolute;
	border-radius: 6px;
	left: 0;
	top: 0;
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-backface-visibility: hidden;
	-moz-backface-visibility: hidden;
	-o-backface-visibility: hidden;
	backface-visibility: hidden;
}

.center-wrap {
	position: absolute;
	width: 100%;
	padding: 0 35px;
	top: 50%;
	left: 0;
	transform: translate3d(0, -50%, 35px) perspective(100px);
	z-index: 20;
	display: block;
}

.form-group {
	position: relative;
	display: block;
	margin: 0;
	padding: 0;
}

.form-style {
	padding: 13px 20px;
	padding-left: 55px;
	height: 48px;
	width: 100%;
	font-weight: 500;
	border-radius: 4px;
	font-size: 14px;
	line-height: 22px;
	letter-spacing: 0.5px;
	outline: none;
	color: #c4c3ca;
	background-color: #1f2029;
	border: none;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
	box-shadow: 0 4px 8px 0 rgba(21, 21, 21, .2);
}

.form-style:focus, .form-style:active {
	border: none;
	outline: none;
	box-shadow: 0 4px 8px 0 rgba(21, 21, 21, .2);
}

.form-group input:-ms-input-placeholder {
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
	font-size: 26px;
	font-weight: 700;
	margin-bottom: 20px;
	color: var(- -color-secondary);
}

.form-group input:-moz-placeholder {
	color: var(- -color-secondary);
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input::-webkit-input-placeholder {
	color: var(- -color-secondary);
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus:-ms-input-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus::-moz-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus:-moz-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus::-webkit-input-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.btn {
	border-radius: 4px;
	height: 44px;
	width: 20%;
	font-size: 13px;
	font-weight: 600;
	text-transform: uppercase;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
	padding: 0 30px;
	letter-spacing: 1px;
	display: -webkit-inline-flex;
	display: -ms-inline-flexbox;
	display: inline-flex;
	-webkit-align-items: center;
	-moz-align-items: center;
	-ms-align-items: center;
	align-items: center;
	-webkit-justify-content: center;
	-moz-justify-content: center;
	-ms-justify-content: center;
	justify-content: center;
	-ms-flex-pack: center;
	text-align: center;
	border: none;
	background-color: #ffeba7;
	color: #102770;
	box-shadow: 0 8px 24px 0 rgba(255, 235, 167, .2);
}

.btn
:active
,
.btn
:focus

	
background-color
:
 
#102770
;

	
color
:
 
#ffeba7
;

	
box-shadow
:
 
0
 
8px
 
24px
 
0
 
rgba
(
16
,
39
,
112
,
.2
)
;


}
.btn:hover {
	background-color: #102770;
	color: #ffeba7;
	box-shadow: 0 8px 24px 0 rgba(16, 39, 112, .2);
}

/* callout 문구 강조 */
#callout {
	background-color: #FFAF00;
	color: white;
	padding: 20px;
	border-radius: 40px 80px;
	width: 100%;
	text-align: left; /* 왼쪽 정렬로 변경 */
	margin: 20px;
	font-size: 14px;
}

.checkbox-inline {
	display: flex;
	align-items: center;
}

.checkbox-inline input[type="number"] {
	margin-left: 5px; /* 원하는 간격으로 조정합니다. */
}
</style>

<c:if test="${!empty msg }">
	<script>
		alert('${msg}');
	</script>
</c:if>
<main id="main">

	<!-- ======= Breadcrumbs ======= -->
	<div class="breadcrumbs d-flex align-items-center"
		style="background-image: url('https://images.pexels.com/photos/2227832/pexels-photo-2227832.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');">
		<!-- 	../resources/assets/img/breadcrumbs-bg.jpg -->
		<div
			class="container position-relative d-flex flex-column align-items-center"
			data-aos="fade">
			<h2>시공의뢰 목록</h2>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- ======= Projet Details Section (시공의뢰 입력 폼)======= -->
	<section id="project-details" class="project-details blog">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-between gy-4 mt-4">
				<div class="col-lg-9">
					<div class="portfolio-description">
						<!-- /.row -->
						<div class="row">
							<div class="col-lg-20">
								<div class="panel panel-default">
									<div class="panel-heading">Sireq List Page</div>
									<!-- /.panel-heading -->
									<div class="panel-body">
										<!-- 검색 타입 및 검색 키워드 -------------------->
										<form action="/sirequest/sireqList" id="searchFrm">
											<select name="type">
												<c:set var="type" value="${pageDTO.cri.type}" />
												<option value="N" ${type == 'N' ? 'selected' : '' }>의뢰인</option>
												<option value="Q" ${type == 'Q' ? 'selected' : '' }>견적서
													번호</option>
											</select> <input type="text" name="keyword"
												value="${pageDTO.cri.keyword}">
											<button class="btn btn-primary">검색</button>


											<!-- 페이지 번호와 페이지에 표시할 게시물의 수 -->

											<input type="hidden" name="pageNum"
												value="${pageDTO.cri.pageNum}"> <input type="hidden"
												name="amount" value="${pageDTO.cri.amount}">
										</form>
										<!-- END 검색 타입 및 검색 키워드 -->

										<div class="row">
											<div class="col-lg-35">
												<div class="panel panel-default">
													<!-- /.panel-heading -->
													<div class="panel-body">
														<table class="table table-hover">
															<thead>
																<tr>
																	<th>시공의뢰번호</th>
																	<th>견적서 번호</th>
																	<th>의뢰인</th>
																	<th>시공의뢰등록일</th>
																	<th>의뢰진행현황</th>
																	<th>결제진행현황</th>
																	<th>수정일</th>
																	<th>계약취소여부</th>
																</tr>
															</thead>
															<!-- Model 데이터 출력 -->
															<c:forEach items="${list}" var="sireq">
																<tr>
																	<td><a class="move" href="${sireq.sireqNo}"> <c:out
																				value="${sireq.sireqNo}" /></a></td>
																	<td><c:out value="${sireq.quotationvo.quoNo}" /></td>
																	<td><c:out value="${sireq.mvo.mname}" /></td>
																	<td><fmt:formatDate value="${sireq.sireqDate}"
																			pattern="yyyy-MM-dd" /></td>
																	<td>${sireq.sireqStatus}</td>
																	<td>${sireq.payStatus}</td>
																	<td><fmt:formatDate
																			value="${sireq.sireqUpdateDate}" pattern="yyyy-MM-dd" /></td>
																</tr>
															</c:forEach>
															<!-- END Model 데이터 출력 -->
														</table>
														<!-- /.table-responsive -->

														<!-- paging -->
														<div class="pull-right">
															<ul class="pagination">
																<!-- 이전 버튼 -->
																<c:if test="${pageDTO.prev }">
																	<li class="paginate_button previous"><a
																		href="${pageDTO.start - 1}">&laquo; Previous</a></li>
																</c:if>

																<!-- 페이지 번호 버튼 -->
																<c:forEach begin="${pageDTO.start }"
																	end="${pageDTO.end }" var="num">
																	<li
																		class="paginate_button ${pageDTO.cri.pageNum == num ? 'active' : '' }">
																		<a href="${num}">${num}</a>
																	</li>
																</c:forEach>

																<!-- 다음 버튼 -->
																<c:if test="${pageDTO.next }">
																	<li class="paginate_button next"><a
																		href="${pageDTO.end + 1}"> Next &raquo;</a></li>
																</c:if>
															</ul>
														</div>
														<!-- END paging -->

														<!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
														<form action="/sirequest/sireqList" id="actionFrm"
															method="get">
															<input type="hidden" name="type"
																value="${pageDTO.cri.type}"> <input
																type="hidden" name="keyword"
																value="${pageDTO.cri.keyword}"> <input
																type="hidden" name="pageNum"
																value="${pageDTO.cri.pageNum}"> <input
																type="hidden" name="amount"
																value="${pageDTO.cri.amount}">
														</form>
													</div>
													<!-- /.panel-body -->
												</div>
												<!-- /.panel -->
											</div>
										</div>
										<!-- /.col-lg-12 -->
									</div>
									<!-- /.row -->
								</div>
								<!-- /.panel-body -->
							</div>
							<!-- /.panel -->
						</div>
						<!-- /.col-lg-8 -->
					</div>
					<!-- /.portfolio-description -->
				</div>
				<!-- /.col-lg-9 -->
				<!-- 사이드바 -->
				<%@ include file="../includes/sideMenuMem.jsp"%>
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
	</section>
	<script type="text/javascript">
		//게시물 처리 결과 알림 모달창 처리 -------------------	
		$(document).ready(
				function() {

					var result = '<c:out value="${result}"/>';

					checkModal(result);
					//모달 창 재출력 방지
					history.replaceState({}, null, null); //history 초기화

					function checkModal(result) {
						//result 값이 있는 경우에 모달 창 표시
						if (result === '' || history.state) {
							return;
						}

						if (parseInt(result) > 0) { //게시물이 등록된 경우
							$('.modal-body').html(
									parseInt(result) + '번 시공의뢰가 등록되었습니다.');
						}

						$('#myModal').modal('show');
					}

				});
		//END 게시물 처리 결과 알림 모달창 처리

		//페이지 번호 클릭 처리 -----------------------	
		var actionFrm = $('#actionFrm');

		$('.paginate_button a').on('click', function(e) {
			e.preventDefault();

			console.log('click');

			//a 태그의 href 값을 pageNum에 저장
			actionFrm.find("input[name='pageNum']").val($(this).attr('href'));
			actionFrm.submit();
		});
		//END 페이지 번호 클릭 처리

		$(function() {
			//검색 버튼 이벤트 처리 ---------------------------
			var searchFrm = $('#searchFrm')

			$('.searchBtn').on('click', function() {
				//검색 키워드를 입력하지 않은 경우
				// 		if(searchFrm.find("input[name='keyword']").val() == ''){
				// 			alert('검색 키워드를 입력해 주세요.');
				// 			return false;
				// 		}

				//검색 시 페이지 번호를 1이 되도록 설정
				searchFrm.find("input[name='pageNum']").val('1');
				searchFrm.submit();
			});
			//END 검색 버튼 이벤트 처리 -----------------------

			//시공의뢰 번호 클릭 이벤트 처리 -------------------
			$('.move')
					.on(
							'click',
							function(e) {
								e.preventDefault();

								//hidden 태그를 생성하여 이름을 sireqNo로 지정하고
								//a 태그의 href 값을 sireqNo에 저장한 후 actionFrm에 추가
								actionFrm
										.append("<input type='hidden' name='sireqNo' value='"
												+ $(this).attr('href') + "'>");

								actionFrm
										.attr('action', '/sirequest/sireqView');

								actionFrm.submit();
							});
			//END 시공의뢰 번호 클릭 이벤트 처리 -------------------

		});//END $
	</script>

</main>
<!-- End #main -->
<%@ include file="../includes/footer.jsp"%>