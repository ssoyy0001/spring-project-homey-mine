<%@ include file="../includes/header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
@import
	url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900')
	;

body {
	font-family: 'Poppins', sans-serif;
	font-weight: 700;
	font-size: 20px;
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

<!-- ======= 비용 계산기 ======= -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<c:if test="${!empty msg }">
	<script>
		alert('${msg}');
	</script>
</c:if>
<main id="main">

	<!-- ======= Breadcrumbs ======= -->
	<div class="breadcrumbs d-flex align-items-center"
		style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
		<div
			class="container position-relative d-flex flex-column align-items-center"
			data-aos="fade">
			<h2>시공의뢰 상세조회</h2>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- ======= Projet Details Section (시공의뢰 입력 폼)======= -->
	<section id="project-details" class="project-details blog">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-between gy-4 mt-4">
				<div class="col-lg-8">
					<div class="portfolio-description">
						<div class="col-lg-9">
							<!-- /.row -->
							<div class="row">
								<div class="col-lg-12">
									<div class="panel panel-default">
										<div class="panel-heading">Sireq View Page</div>
										<!-- /.panel-heading -->
										<div class="panel-body">
											<!-- 게시물 상세조회 폼 -->

											<div class="form-group">
												<label>견적서 번호</label><a href="/consult/consultManage?consultNo=${sireq.consultvo.consultNo}"><input name="sireq.quotationvo.quoNo"
													value="${sireq.quotationvo.quoNo}" readonly
													class="form-control"></a>
											</div>
											<br>
											<div class="form-group">
												<label>의뢰인</label> <input name="mname"
													value='<c:out value="${sireq.mvo.mname}" />' readonly
													class="form-control">
											</div>
											<br>
											<div class="form-group">
												<label>시공의뢰 등록일</label> <input name="mname"
													value='<c:out value="${sireq.sireqDate}" />' readonly
													pattern="yyyy-MM-dd" class="form-control">
											</div>
											<br>
											<div class="form-group">
												<label>시공일정</label> <input name="constScheduleStart"
													value='<c:out value="${sireq.quotationvo.constScheduleStart}" />'
													readonly pattern="yyyy-MM-dd" class="form-control">
												~ <input name="constScheduleEnd"
													value='<c:out value="${sireq.quotationvo.constScheduleEnd}" />'
													readonly pattern="yyyy-MM-dd" class="form-control">
											</div>
											<br>
											<div class="form-group">
												<label>건물유형</label> <input name="buildingType" readonly
													value='${sireq.consultvo.buildingType}'
													class="form-control">
											</div>
											<br>
											<div class="form-group">
												<label>평수</label> <input name="pyeongsu"
													value='<c:out value="${sireq.consultvo.pyeongsu}" />'
													readonly class="form-control">
											</div>
											<br>
											<!-- type="checkbox" value="1"이면 출력 -->
											<div class="form-group">
												<label>시공의뢰 할 철거항목</label>

												<div id="demolDiv"
													style="border: 1px solid #ccc; padding: 10px; border-radius: 5px; font-size: 1rem; font-weight: 400;">

													<!-- 여러개 선택하려면 c:choose 각각 사용해야함 -->
													<c:choose>
														<c:when test="${sireq.ivo.tilingD != null}">
															<label class="checkbox-inline"> &nbsp; 도배/벽
																&nbsp; 철거비용: <input type="number" id="operand1"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.tilingD}">

															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.flooringD != null}">
															<label class="checkbox-inline"> &nbsp; 바닥 &nbsp;
																철거비용: <input type="number" id="operand2"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.flooringD}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.kitchenD != null}">
															<label class="checkbox-inline"> &nbsp; 주방 &nbsp;
																철거비용: <input type="number" id="operand3"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.kitchenD}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.bathroomD != null}">
															<label class="checkbox-inline"> &nbsp; 욕실 &nbsp;
																철거비용: <input type="number" id="operand4"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.bathroomD}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.entranceD != null}">
															<label class="checkbox-inline"> &nbsp; 현관 &nbsp;
																철거비용: <input type="number" id="operand5"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.entranceD}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.balconyD != null}">
															<label class="checkbox-inline"> &nbsp; 발코니 &nbsp;
																철거비용: <input type="number" id="operand6"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.balconyD}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.lightingD != null}">
															<label class="checkbox-inline"> &nbsp; 조명 &nbsp;
																철거비용: <input type="number" id="operand7"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.lightingD}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.doorD != null}">
															<label class="checkbox-inline"> &nbsp; 문 &nbsp;
																철거비용: <input type="number" id="operand8"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.doorD}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.etcD != null}">
															<label class="checkbox-inline"> &nbsp; 그 외(문의)
																&nbsp; </label>
														</c:when>
													</c:choose>
												</div>
											</div>
											<br>

											<div class="form-group">
												<label>시공의뢰 할 시공항목</label>

												<div id="constDiv"
													style="border: 1px solid #ccc; padding: 10px; border-radius: 5px; font-size: 1rem; font-weight: 400;">

													<c:choose>
														<c:when test="${sireq.ivo.tiling != null}">
															<label class="checkbox-inline"> &nbsp; 도배/벽
																&nbsp; 시공비용: <input type="number" id="operand_1"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.tiling}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.flooring != null}">
															<label class="checkbox-inline"> &nbsp; 바닥 &nbsp;
																시공비용: <input type="number" id="operand_2"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.flooring}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.kitchen != null}">
															<label class="checkbox-inline"> &nbsp; 주방 &nbsp;
																시공비용: <input type="number" id="operand_3"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.kitchen}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.bathroom != null}">
															<label class="checkbox-inline"> &nbsp; 욕실 &nbsp;
																시공비용: <input type="number" id="operand_4"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.bathroom}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.entrance != null}">
															<label class="checkbox-inline"> &nbsp; 현관 &nbsp;
																시공비용: <input type="number" id="operand_5"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.entrance}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.balcony != null}">
															<label class="checkbox-inline"> &nbsp; 발코니 &nbsp;
																시공비용: <input type="number" id="operand_6"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.balcony}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.lighting != null}">
															<label class="checkbox-inline"> &nbsp; 조명 &nbsp;
																시공비용: <input type="number" id="operand_7"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.lighting}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.door != null}">
															<label class="checkbox-inline"> &nbsp; 문 &nbsp;
																시공비용: <input type="number" id="operand_8"
																style="border: 1px solid #ccc;" readonly
																value="${sireq.ivo.door}">
															</label>
															<br>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${sireq.ivo.etc != null}">
															<label class="checkbox-inline"> &nbsp; 그 외(문의)
																&nbsp; </label>
														</c:when>
													</c:choose>

												</div>
											</div>


											<div id="callout">
												<label>* 공사진행상황에 따라 총 시공금액은 달라질 수 있습니다.<br> 최종
													선택된 철거/시공항목 여부에 따라 변경 된 총 시공금액은 추후 시공의뢰 상세보기 페이지에서 확인 할 수
													있으며, 최종적으로 변경된 비용이 반영된 후에는 시공의뢰 수정이 불가합니다.<br> 이후
													시공의뢰등록할 철거/시공항목 수정을 원하시는 경우, 등록한 시공의뢰 삭제 후 다시 등록 바랍니다.
												</label>
											</div>
											<br>
											<div class="form-group">
												<label>철거비용</label> <input id="demolTotal" name="demolTotal"
													value='<c:out value="${sireq.quotationvo.demolTotal}" />'
													readonly class="form-control">

											</div>
											<br>
											<div class="form-group">
												<label>시공비용</label> <input id="constTotal" name="constTotal"
													value='<c:out value="${sireq.quotationvo.constTotal}" />'
													readonly class="form-control">
											</div>
											<br>
											<div class="form-group">
												<label>총 시공금액</label> <input name="sigongTotal"
													value='<c:out value="${sireq.sigongTotal}" />' readonly
													class="form-control">
											</div>
											<br>
											<div class="form-group">
												<label>의뢰진행현황</label> <input name="sireqStatus"
													value='<c:out value="${sireq.sireqStatus}" />' readonly
													class="form-control">
											</div>
											<br>
											<div class="form-group">
												<label>결제진행현황</label> <input name="payStatus"
													value='<c:out value="${sireq.payStatus}" />' readonly
													class="form-control">
											</div>
											<br>
											<%-- 											${sireq.sireqNo}	
										${sireq.quotationvo.quoNo}
										${sireq.consultvo.consultNo}
										${sireq.ivo.itemNo} --%>
											<%-- <input type="hidden" name="sireqNo" value="${sireq.sireqNo}">
											<input type="hidden" name="quoNo" value="${sireq.quotationvo.quoNo}">
											<input type="hidden" name="consultNo" value="${sireq.consultvo.consultNo}">
											<input type="hidden" name="itemNo" value="${sireq.ivo.itemNo}"> --%>

											<button type="submit" data-oper="list" class="btn btn-info"
												onclick="location.href='/sirequest/sireqList'">목록</button>
											<%-- <button type="submit" data-oper="modify" class="btn btn-default" onclick="location.href='/sirequest/sireqModifyForm?sireqNo=${sireq.sireqNo }
																																								&quoNo=${sireq.quotationvo.quoNo}
																																								&consultNo=${sireq.consultvo.consultNo}
																																								&itemNo=${sireq.ivo.itemNo}'">수정</button> --%>

											<button type="submit" data-oper="remove"
												class="btn btn-danger"
												onclick="location.href='/sirequest/sireqRemove?sireqNo=<c:out value="${sireq.sireqNo }"/>'">삭제</button>
											<a href="/sischedule/sicheRegist?sireqNo=${sireq.sireqNo}">시공팀
												작업 등록</a>

											<!-- 페이지 번호와 페이지에 표시할 게시물의 수, 검색 타입, 키워드 -->
											<input type="hidden" name="type" value="${cri.type}">
											<input type="hidden" name="keyword" value="${cri.keyword}">
											<input type="hidden" name="pageNum" value="${cri.pageNum}">
											<input type="hidden" name="amount" value="${cri.amount}">


											<!-- END 게시물 상세조회 폼 -->
										</div>
										<!-- /.panel-body -->
									</div>
									<!-- /.panel -->
								</div>
								<!-- /.col-lg-12 -->
							</div>
							<!-- /.row -->
						</div>
						<!-- col-lg-9 -->
						<!-- 사이드바 -->
						<%@ include file="../includes/sideMenuMem.jsp"%>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 첨부 파일 ------------------------------->

	<!-- END 첨부 파일 --------------------------->

	<script type="text/javascript">
		//시공의뢰 번호 클릭 이벤트 처리 -------------------
		$('.move').on(
				'click',
				function(e) {
					e.preventDefault();

					//hidden 태그를 생성하여 이름을 sireqNo로 지정하고
					//a 태그의 href 값을 sireqNo에 저장한 후 actionFrm에 추가
					actionFrm
							.append("<input type='hidden' name='quoNo' value='"
									+ $(this).attr('href') + "'>");

					actionFrm.attr('action', '/sirequest/qutationView');

					actionFrm.submit();
				});
		//END 시공의뢰 번호 클릭 이벤트 처리 -------------------
	</script>
</main>
<!-- End #main -->
<%@ include file="../includes/footer.jsp"%>
