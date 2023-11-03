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
			<h2>시공의뢰 등록</h2>
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
										<div class="panel-heading">Sireq Register Page</div>
										<!-- /.panel-heading -->
										<div class="panel-body">

											<!-- 게시물 등록 폼 -->
											<form action="/sirequest/sireqRegister" method="get"
												role="form">
												<div class="form-group">

													<label>견적서 번호</label> <input name="quoNo"
														value='<c:out value="${qvo.quoNo }" />' readonly
														class="form-control">
												</div>
												<br>
												<div class="form-group">

													<label>아이디</label> <input name="mid"
														value='<c:out value="${cvo.mid}" />' readonly
														class="form-control">
												</div>
												<br>
												<div class="form-group">
													<label>시공일정</label> <input name="constScheduleStart"
														value='<c:out value="${qvo.constScheduleStart}" />'
														readonly pattern="yyyy-MM-dd" class="form-control">
													~ <input name="constScheduleEnd"
														value='<c:out value="${qvo.constScheduleEnd}" />' readonly
														pattern="yyyy-MM-dd" class="form-control">
												</div>
												<br>
												<div class="form-group">
													<label>건물유형</label> <input name="buildingType" readonly
														value="${cvo.buildingType}" class="form-control">
												</div>
												<br>
												<div class="form-group">
													<label>평수</label> <input name="pyeongsu"
														value='<c:out value="${cvo.pyeongsu}" />' readonly
														class="form-control">
												</div>
												<br>
												<!-- type="checkbox" value이 null 아니면 출력 -->
												<div class="form-group">
													<label>시공의뢰 할 철거항목 (선택/중복선택가능)</label>

													<div id="demolDiv"
														style="border: 1px solid #ccc; padding: 10px; border-radius: 5px; font-size: 1rem; font-weight: 400;">

														<!-- 여러개 선택하려면 c:choose 각각 사용해야함 -->

														<c:choose>
															<c:when test="${ivo.tilingD != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.tilingD" id="tilingDCheck"
																	class="item" value="${ivo.tilingD}" />&nbsp; 도배/벽
																	&nbsp; 철거비용: <input type="number" id="operand1"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.tilingD}">

																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.flooringD != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.flooringD"
																	id="flooringDCheck" class="item"
																	value="${ivo.flooringD}" />&nbsp; 바닥 &nbsp; 철거비용: <input
																	type="number" id="operand2"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.flooringD}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.kitchenD != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.kitchenD" id="kitchenDCheck"
																	class="item" value="${ivo.kitchenD}" />&nbsp; 주방
																	&nbsp; 철거비용: <input type="number" id="operand3"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.kitchenD}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.bathroomD != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.bathroomD"
																	id="bathroomDCheck" class="item"
																	value="${ivo.bathroomD}" />&nbsp; 욕실 &nbsp; 철거비용: <input
																	type="number" id="operand4"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.bathroomD}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.entranceD != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.entranceD"
																	id="entranceDCheck" class="item"
																	value="${ivo.entranceD}" />&nbsp; 현관 &nbsp; 철거비용: <input
																	type="number" id="operand5"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.entranceD}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.balconyD != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.balconyD" id="balconyDCheck"
																	class="item" value="${ivo.balconyD}" />&nbsp; 발코니
																	&nbsp; 철거비용: <input type="number" id="operand6"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.balconyD}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.lightingD != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.lightingD"
																	id="lightingDCheck" class="item"
																	value="${ivo.lightingD}" />&nbsp; 조명 &nbsp; 철거비용: <input
																	type="number" id="operand7"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.lightingD}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.doorD != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.doorD" id="doorDCheck"
																	class="item" value="${ivo.doorD}" />&nbsp; 문 &nbsp;
																	철거비용: <input type="number" id="operand8"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.doorD}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.etcD != 0}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.etcD" id="etcDCheck"
																	class="item" value="1">&nbsp; 그 외(문의) &nbsp;
																</label>
															</c:when>
														</c:choose>
													</div>
												</div>
												<br>

												<div class="form-group">
													<label>시공의뢰 할 시공항목 (선택/중복선택가능)</label>

													<div id="constDiv"
														style="border: 1px solid #ccc; padding: 10px; border-radius: 5px; font-size: 1rem; font-weight: 400;">

														<c:choose>
															<c:when test="${ivo.tiling != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.tiling" id="tilingCheck"
																	class="item" value="${ivo.tiling}" />&nbsp; 도배/벽
																	&nbsp; 시공비용: <input type="number" id="operand_1"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.tiling}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.flooring != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.flooring" id="flooringCheck"
																	class="item" value="${ivo.flooring}" />&nbsp; 바닥
																	&nbsp; 시공비용: <input type="number" id="operand_2"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.flooring}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.kitchen != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.kitchen" id="kitchenCheck"
																	class="item" value="${ivo.kitchen}" />&nbsp; 주방 &nbsp;
																	시공비용: <input type="number" id="operand_3"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.kitchen}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.bathroom != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.bathroom" id="bathroomCheck"
																	class="item" value="${ivo.bathroom}" />&nbsp; 욕실
																	&nbsp; 시공비용: <input type="number" id="operand_4"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.bathroom}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.entrance != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.entrance" id="entranceCheck"
																	class="item" value="${ivo.entrance}" />&nbsp; 현관
																	&nbsp; 시공비용: <input type="number" id="operand_5"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.entrance}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.balcony != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.balcony" id="balconyCheck"
																	class="item" value="${ivo.balcony}" />&nbsp; 발코니
																	&nbsp; 시공비용: <input type="number" id="operand_6"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.balcony}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.lighting != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.lighting" id="lightingCheck"
																	class="item" value="${ivo.lighting}" />&nbsp; 조명
																	&nbsp; 시공비용: <input type="number" id="operand_7"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.lighting}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.door != null}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.door" id="doorCheck"
																	class="item" value="${ivo.door}" />&nbsp; 문 &nbsp;
																	시공비용: <input type="number" id="operand_8"
																	style="border: 1px solid #ccc;" readonly
																	value="${ivo.door}">
																</label>
																<br>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ivo.etc != 0}">
																<label class="checkbox-inline"> <input
																	type="checkbox" name="ivo.etc" id="etcCheck"
																	class="item" value="1">&nbsp; 그 외(문의) &nbsp;
																</label>
															</c:when>
														</c:choose>

													</div>
												</div>


												<div id="callout">
													<label>* 견적서에 등록된 회원님이 선택하신 시공 종류를 바탕으로 선택항목이
														구성됩니다.<br> 선택항목에 따라 총 시공금액은 달라질 수 있습니다.
													</label>
												</div>
												<br>
												<div class="form-group">
													<label>철거비용</label> <input name="quotationvo.demolTotal"
														id="demolTotal"
														value='<c:out value="${qvo.demolTotal}" />' readonly
														class="form-control">

												</div>

												<br>
												<div class="form-group">
													<label>시공비용</label> <input name="quotationvo.constTotal"
														id="constTotal"
														value='<c:out value="${qvo.constTotal}" />' readonly
														class="form-control">
												</div>
												<br>

												<div class="form-group">
													<label>총 시공금액</label> <input name="sigongTotal"
														id="sigongTotal" value='<c:out value="${qvo.total}" />'
														readonly class="form-control">
												</div>
												<br> <input type="hidden" name="mvo.mid"
													value="${cvo.mid}" /> <input type="hidden"
													name="quotationvo.quoNo" value="${qvo.quoNo }" /> <input
													type="hidden" name="consultvo.consultNo"
													value="${cvo.consultNo}" /> <input type="hidden"
													name="ivo.itemNo" value="${cvo.item.itemNo}" /> <input
													type="hidden" name="quotationvo.demolTotal"
													value="${qvo.demolTotal}" /> <input type="hidden"
													name="quotationvo.constTotal" value="${qvo.constTotal}" />
												<input type="hidden" name="sigongTotal" value="${qvo.total}" />

												<button type="reset" class="btn btn-default">초기화</button>
												<button type="button" class="btn btn-warning"
													onclick="history.back()">취소</button>
												<button type="submit" id="submit" class="btn btn-primary">등록</button>

											</form>
											<!-- END 게시물 등록 폼 -->
										</div>
										<!-- /.panel-body -->
									</div>
									<!-- /.panel -->
								</div>
								<!-- /.col-lg-12 -->
							</div>
							<!-- /.row -->

							<!-- 첨부 파일 ------------------------------->

							<!-- END 첨부 파일 --------------------------->

						</div>
						<!-- col-lg-9 -->
						<!-- 사이드바 -->
						<%@ include file="../includes/sideMenuMem.jsp"%>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>
						
					
							//var frm = $('form[role="form"]');

							// 철거항목 자동계산기-----------------
							document.addEventListener('DOMContentLoaded', function () {
  // 아래 체크박스 ID와 연결된 철거 비용을 매핑합니다.
  var demolitionCosts = {
    'tilingDCheck': '${ivo.tilingD}',
    'flooringDCheck': '${ivo.flooringD}',
    'kitchenDCheck': '${ivo.kitchenD}',
    'bathroomDCheck': '${ivo.bathroomD}',
    'entranceDCheck': '${ivo.entranceD}',
    'balconyDCheck': '${ivo.balconyD}',
    'lightingDCheck': '${ivo.lightingD}',
    'doorDCheck': '${ivo.doorD}',
    'etcDCheck': '${ivo.etcD}'
  };

  // 철거비용을 자동으로 계산하고 업데이트하는 함수
  function updateDemolTotal() {
    var total = 0;
    for (var checkboxID in demolitionCosts) {
      var checkbox = document.getElementById(checkboxID);
      var cost = parseFloat(demolitionCosts[checkboxID]);
      
      if (checkbox && checkbox.checked && !isNaN(cost)) {
        total += cost;
      }
    }

    // 계산된 총값을 화면에 표시합니다.
    var demolTotalInput = document.getElementById('demolTotal');
    if (demolTotalInput) {
      demolTotalInput.value = total;
    }
  }

  // 페이지 로드 시와 각 체크박스 변경 시 자동으로 업데이트되도록 이벤트 핸들러를 등록합니다.
  updateDemolTotal();
  for (var checkboxID in demolitionCosts) {
    var checkbox = document.getElementById(checkboxID);
    if (checkbox) {
      checkbox.addEventListener('change', updateDemolTotal);
    }
  }
});
							
							//시공항목 자동계산기----------------
							document.addEventListener('DOMContentLoaded', function () {
  // 아래 체크박스 ID와 연결된 시공 비용을 매핑합니다.
  var constructionCosts = {
    'tilingCheck': '${ivo.tiling}',
    'flooringCheck': '${ivo.flooring}',
    'kitchenCheck': '${ivo.kitchen}',
    'bathroomCheck': '${ivo.bathroom}',
    'entranceCheck': '${ivo.entrance}',
    'balconyCheck': '${ivo.balcony}',
    'lightingCheck': '${ivo.lighting}',
    'doorCheck': '${ivo.door}',
    'etcCheck': '${ivo.etc}'
  };

  // 시공비용을 자동으로 계산하고 업데이트하는 함수
  function updateConstTotal() {
    var total = 0;
    for (var checkboxID in constructionCosts) {
      var checkbox = document.getElementById(checkboxID);
      var cost = parseFloat(constructionCosts[checkboxID]);
      
      if (checkbox && checkbox.checked && !isNaN(cost)) {
        total += cost;
      }
    }

    // 계산된 총값을 화면에 표시합니다.
    var constTotalInput = document.getElementById('constTotal');
    if (constTotalInput) {
    	constTotalInput.value = total;
    }
  }

  // 페이지 로드 시와 각 체크박스 변경 시 자동으로 업데이트되도록 이벤트 핸들러를 등록합니다.
  updateConstTotal();
  for (var checkboxID in constructionCosts) {
    var checkbox = document.getElementById(checkboxID);
    if (checkbox) {
      checkbox.addEventListener('change', updateConstTotal);
    }
  }
});
							

  // 총 시공금액 자동계산기----------------
 // 철거 비용 항목
var demolitionCosts = {
  'tilingDCheck': ${ivo.tilingD},
  'flooringDCheck': ${ivo.flooringD},
  'kitchenDCheck': ${ivo.kitchenD},
  'bathroomDCheck': ${ivo.bathroomD},
  'entranceDCheck': ${ivo.entranceD},
  'balconyDCheck': ${ivo.balconyD},
  'lightingDCheck': ${ivo.lightingD},
  'doorDCheck': ${ivo.doorD},
  'etcDCheck': ${ivo.etcD}
};

// 시공 비용 항목
var constructionCosts = {
  'tilingCheck': ${ivo.tiling},
  'flooringCheck': ${ivo.flooring},
  'kitchenCheck': ${ivo.kitchen},
  'bathroomCheck': ${ivo.bathroom},
  'entranceCheck': ${ivo.entrance},
  'balconyCheck': ${ivo.balcony},
  'lightingCheck': ${ivo.lighting},
  'doorCheck': ${ivo.door},
  'etcCheck': ${ivo.etc}
};

// 철거 비용 합산 및 총 시공금액 업데이트 함수
function updateDemolTotal() {
  var demolTotal = 0;
  for (var checkboxID in demolitionCosts) {
    var checkbox = document.getElementById(checkboxID);
    var cost = parseFloat(demolitionCosts[checkboxID]);

    if (checkbox && checkbox.checked && !isNaN(cost)) {
      demolTotal += cost;
    }
  }
  calculateSigongTotal();
}

// 시공 비용 합산 및 총 시공금액 업데이트 함수
function updateConstTotal() {
  var constTotal = 0;
  for (var checkboxID in constructionCosts) {
    var checkbox = document.getElementById(checkboxID);
    var cost = parseFloat(constructionCosts[checkboxID]);

    if (checkbox && checkbox.checked && !isNaN(cost)) {
      constTotal += cost;
    }
  }
  calculateSigongTotal();
}

// 총 시공금액 계산 및 업데이트 함수
function calculateSigongTotal() {
  var demolTotal = parseFloat($("input[id='demolTotal']").val()) || 0;
  var constTotal = parseFloat($("input[id='constTotal']").val()) || 0;
  var sigongTotal = demolTotal + constTotal;
  $("input[id='sigongTotal']").val(sigongTotal);
}

// 자동 계산 이벤트 처리
$(document).ready(function () {
  // 철거 항목 변경 시
  for (var checkboxID in demolitionCosts) {
    var checkbox = document.getElementById(checkboxID);
    if (checkbox) {
      checkbox.addEventListener('change', updateDemolTotal);
    }
  }

  // 시공 항목 변경 시
  for (var checkboxID in constructionCosts) {
    var checkbox = document.getElementById(checkboxID);
    if (checkbox) {
      checkbox.addEventListener('change', updateConstTotal);
    }
  }

  // 페이지 로드 시 초기 계산
  calculateSigongTotal();
});

							//체크박스 하나이상 체크 알림 -----------------------------------------
 							document.getElementById('submit').onclick = function(event) {
  var checkboxes = document.querySelectorAll('input[type=checkbox]');
  var checked = false;

  for (var i = 0; i < checkboxes.length; i++) {
    if (checkboxes[i].checked) {
      checked = true;
      break;
    }
  }

  if (!checked) {
    alert('시공의뢰 할 철거항목 또는 시공항목을 체크해주세요.');
    event.preventDefault(); // 이벤트 기본 동작 중지
  }
}//end 체크박스 하나이상 체크 알림 -----------------------------------------

//체크박스 해당 항목에 대한 값을 1로 설정하고, 선택되지 않았을 때는 0으로 설정-----------------------------------------
document
		.addEventListener(
				'DOMContentLoaded',
				function() {
					
					var value = document.getElementById('someElement');
					// 각 체크박스의 ID를 배열에 저장합니다
					var checkboxIDs = [
						'etcDCheck', 'etcCheck' ];

					// 각 체크박스에 대한 이벤트 핸들러를 등록합니다
					checkboxIDs
							.forEach(function(
									checkboxID) {
								var checkbox = document
										.getElementById(checkboxID);
								checkbox
										.addEventListener(
												'change',
												function() {
													handleCheckboxChange(
															checkbox,
															checkbox.value); // handleCheckboxChange 함수 호출
												});
							});

					// handleCheckboxChange 함수 정의
					function handleCheckboxChange(
							checkbox, value) {
						if (checkbox.checked) {
							// 체크박스가 선택된 경우 1로 설정
							value = 1;
						} else {
							// 체크박스가 선택되지 않은 경우 0으로 설정
							value = 0;
						}
					}
				});

//END 체크박스 해당 항목에 대한 값을 1로 설정하고, 선택되지 않았을 때는 0으로 설정

							// 페이지 로드 시 jqueryTest2() 함수 자동 실행

							//-----------------

							//-----------------
						</script>
</main>
<!-- End #main -->
<%@ include file="../includes/footer.jsp"%>