<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>견적상담 상세조회</title>
<style>
/* 필드명들 강조 표시 */
.col-sm-2 {
	font-weight: 600;
	color: gray;
}
/* 견적상담내역 버튼 정렬 */
.findConsultButton {
	text-align: right;
}
/* 견적서 항목 등록 버튼 */
#plusBtn {
	cursor: pointer;
}
/* fullcalendar */
  #loading {
    display: none;
    position: absolute;
    top: 10px;
    right: 10px;
  }
    #script-warning {
    display: none;
    background: #eee;
    border-bottom: 1px solid #ddd;
    padding: 0 10px;
    line-height: 40px;
    text-align: center;
    font-weight: bold;
    font-size: 12px;
    color: red;
  }
</style>

	<!-- fullCalendar -->
	<link href="../resources/fullcalendar/main.css" rel="stylesheet"/>
	<script src="../resources/fullcalendar/main.js"></script>
	
<!--         //reply.js -->
<!--         //보낼때는 data : json , contentType : appli -- -->
    

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
				<h2>견적상담 상세 조회</h2>
			</div>
		</div>
		<!-- End Breadcrumbs -->

		<!-- ======= Blog Details Section (견적상담 상세조회 + 그외의 것들 구역)======= -->
		<section id="blog" class="blog">
			<div class="container" data-aos="fade-up" data-aos-delay="100">
				<div class="row g-3">
					<div class="col-lg-9">
						<!-- 견적 상담 상세조회  -->
						<article class="blog-details">
							<!-- 견적상담 해피콜 및 처리현황 수정 폼 -->
							<form action="/consult/modify" method="post" id="CancleForm">
								<h2>견적 신청 내용 📒</h2>
								<!-- 4개 항목 시작  -->
								<!-- https://icons.getbootstrap.com/ -->
								<section id="stats-counter" class="stats-counter"
									style="padding: 10px;">
									<div class="container">
										<div class="row gy-4">
											<!-- 견적상담번호 -->
											<div class="col-lg-3 col-md-6">
												<!-- lg : 큰화면, md : 중간 화면 비율 -->
												<div
													class="stats-item d-flex align-items-center w-100 h-100"
													style="padding: 5px; box-shadow: 0px 0 0px">
													<i class="bi bi-emoji-smile color-blue flex-shrink-0"></i>
													<div>
														<p>견적 상담 번호</p>
														<span style="font-size: 20px" data-purecounter-start="0"
															data-purecounter-end="${cvo.consultNo}"
															data-purecounter-duration="1" class="purecounter"></span>
													</div>
												</div>
											</div>
											<!-- End 견적상담번호 -->
											<!-- 평수 -->
											<div class="col-lg-3 col-md-6">
												<!-- lg : 큰화면, md : 중간 화면 비율 -->
												<div
													class="stats-item d-flex align-items-center w-100 h-100"
													style="padding: 5px; box-shadow: 0px 0 0px">
													<i class="bi bi-buildings color-blue flex-shrink-0"></i>
													<div>
														<p>평수</p>
														<span style="font-size: 20px" data-purecounter-start="0"
															data-purecounter-end="${cvo.pyeongsu}"
															data-purecounter-duration="1" class="purecounter"></span>
													</div>
												</div>
											</div>
											<!-- End 평수 -->
											<!-- 예산 -->
											<div class="col-lg-3 col-md-6">
												<!-- lg : 큰화면, md : 중간 화면 비율 -->
												<div
													class="stats-item d-flex align-items-center w-100 h-100"
													style="padding: 5px; box-shadow: 0px 0 0px">
													<i class="bi bi-cash-coin color-blue flex-shrink-0"></i>
													<div>
														<p>예상 예산</p>
														<span style="font-size: 20px" data-purecounter-start="0"
															data-purecounter-end="${cvo.budget}"
															data-purecounter-duration="1" class="purecounter"></span>
													</div>
												</div>
											</div>
											<!-- End 예산 -->
											<!-- 처리현황 -->
											<div class="col-lg-3 col-md-6">
												<!-- lg : 큰화면, md : 중간 화면 비율 -->
												<div
													class="stats-item d-flex align-items-center w-100 h-100"
													style="padding: 5px; box-shadow: 0px 0 0px">
													<i class="bi bi-headset color-blue flex-shrink-0"></i>
													<div>
														<p>처리현황</p>
														<span style="font-size: 17px">${cvo.status}</span>
													</div>
												</div>
											</div>
											<!-- End 처리현황 -->

										</div>
									</div>
								</section>
								<!-- END 4개 항목 시작-->
								<br>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">아이디</label>
									<div class="col-sm-3">${cvo.mid}</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">견적 신청 날짜</label>
									<div class="col-sm-3">
										<fmt:formatDate value="${cvo.consultDate}"
											pattern="yyyy-MM-dd" />
									</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">연락처</label>
									<div class="col-sm-5">${cvo.mphone}</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">시공 주소</label>
									<div class="col-sm-6">
										<span>(</span>${cvo.postcode}<span>)&nbsp;</span>${cvo.address}<span>&nbsp;</span>${cvo.detailAddress}
									</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">건물 유형</label>
									<div class="col-sm-5">${cvo.buildingType}</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">공사 예정</label>
									<div class="col-sm-5">${cvo.scheduledDate}</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">시공 항목</label>
									<div class="col-sm-5">
										<!-- cvo에 담긴 item이 1이면 표시하고 쉼표 `,`로 구분 -->
								<c:if test="${cvo.item.tiling != 0}">도배/벽</c:if>
								
								<c:if test="${cvo.item.flooring != 0}">
								    <c:if test="${cvo.item.tiling != 0}">, </c:if>바닥
								</c:if>
								
								<c:if test="${cvo.item.kitchen != 0}">
								    <c:if test="${cvo.item.tiling != 0 or cvo.item.flooring != 0}">, </c:if>주방
								</c:if>
								
								<c:if test="${cvo.item.bathroom != 0}">
								    <c:if test="${cvo.item.tiling != 0 or cvo.item.flooring != 0 or cvo.item.kitchen != 0}">, </c:if>욕실
								</c:if>
								
								<c:if test="${cvo.item.entrance != 0}">
								    <c:if test="${cvo.item.tiling != 0 or cvo.item.flooring != 0 or cvo.item.kitchen != 0 or cvo.item.bathroom != 0}">, </c:if>현관
								</c:if>
								
								<c:if test="${cvo.item.balcony != 0}">
								    <c:if test="${cvo.item.tiling != 0 or cvo.item.flooring != 0 or cvo.item.kitchen != 0 or cvo.item.bathroom != 0 or cvo.item.entrance != 0}">, </c:if>발코니
								</c:if>
								
								<c:if test="${cvo.item.lighting != 0}">
								    <c:if test="${cvo.item.tiling != 0 or cvo.item.flooring != 0 or cvo.item.kitchen != 0 or cvo.item.bathroom != 0 or cvo.item.entrance != 0 or cvo.item.balcony != 0}">, </c:if>조명
								</c:if>
								
								<c:if test="${cvo.item.door != 0}">
								    <c:if test="${cvo.item.tiling != 0 or cvo.item.flooring != 0 or cvo.item.kitchen != 0 or cvo.item.bathroom != 0 or cvo.item.entrance != 0 or cvo.item.balcony != 0 or cvo.item.lighting != 0}">, </c:if>문
								</c:if>
								
								<c:if test="${cvo.item.etc != 0}">
								    <c:if test="${cvo.item.tiling != 0 or cvo.item.flooring != 0 or cvo.item.kitchen != 0 or cvo.item.bathroom != 0 or cvo.item.entrance != 0 or cvo.item.balcony != 0 or cvo.item.lighting != 0 or cvo.item.door != 0}">, </c:if>그 외
								</c:if>
									</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">해피콜 일시</label>
									<fmt:parseDate value="${cvo.happyCall}"
										pattern="yyyy-MM-dd'T'HH:mm" var="date" />
									<fmt:formatDate value="${date}" pattern="yyyy-MM-dd a h시 mm분"
										var="formattedDate" />
									<div class="col-sm-5">${formattedDate}</div>
									<!-- fmt :  2023-10-18T12:30  >> 2023-10-18 오후 12시 30분 -->
								</div>
								<!-- 해피콜 희망 일시 수정  -->
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-5"
										style="font-weight: bold; color: green;">수정할 해피콜 날짜와
										시간을 선택하세요.</label>
									<div class="col-sm-5">
										<input type="datetime-local" id="happyCall" name="happyCall"
											value="${cvo.happyCall}" oninput="validateDateTime(this)">
									</div>
								</div>
								<div class="alert alert-warning">
									<p align="center">⚠️ 확인해주세요 ⚠️</p>
									<p>✔️ 해피콜 운영시간은 평일 9시 ~ 오후 5시입니다. 10분 단위로만 선택해주세요.</p>
									✔️ 견적 상담 내용의 수정을 원하신다면 기존 접수 건을 취소 후 신규로 다시 접수해주세요.
								</div>
								<div class="findConsultButton">
									<input type="hidden" name="consultNo" value="${cvo.consultNo}">
									<input type="hidden" name="status" value="${cvo.status}">
									<!-- 해피콜 수정 시 null 아니기 위해-->
									<input type="hidden" name="${_csrf.parameterName }"
										value="${_csrf.token }"> <input type="hidden"
										name="pageNum" value="${cri.pageNum}"> <input
										type="hidden" name="amount" value="${cri.amount}"> <input
										type="hidden" name="type" value="${cri.type}"> <input
										type="hidden" name="keyword" value="${cri.keyword}">
									<!-- 해피콜 수정 -->
									<button type="submit" class="btn btn-success">해피콜 수정</button>
									<!-- 견적상담 취소 -->
									<button type="submit" class="btn btn-danger" id="CancleButton"
										onclick="cancelConsult()">견적상담 취소</button>
								</div>
							</form>
						</article>
						<!-- END 견적 상담 상세조회 -->

						<!-- 방문 실측 스케줄 -->
						<article class="blog-details" id="visit">
							<h2>방문 실측 스케줄 📅</h2>
							<div id='loading'>loading...</div>
							<div id='calendar'></div>
							<div id='script-warning'>
							    <code>fail</code>
							</div>
							<c:forEach items="${cvo.vvoList}" var="vvo"> 
							<div id="visitNo" style="display: none;">${vvo.visitNo}</div>
							</c:forEach>
							<!-- 실험  -->
<%-- 							<c:forEach items="${cvo.vvoList}" var="vvo"> --%>
<!-- 								<div class="alert alert-light"> -->
<!-- 									<div class="form-group row" style="margin-bottom: 10px"> -->
<!-- 										<label class="col-sm-2">방문 실측 스케줄 번호</label> -->
<%-- 										<div class="col-sm-5">${vvo.visitNo}</div> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<%-- 							</c:forEach> --%>

						</article>
						<!-- END 방문 실측 스케줄 -->
						<!-- 견적서 -->
						<article class="blog-details">
							<h2>견적서 📝</h2>
<%-- 							<c:out value="${cvo.qvoList} "></c:out> --%>
							<!-- 견적서 정보 표시 -->
							<br>

							<!-- 등록된 견적서 X -->
							<c:if test="${empty cvo.qvoList}">
								<div class="col" align="center">
									<p class="alert alert-warning p-5">등록된 견적서가 없습니다.</p>
								</div>
							</c:if>
							<%-- 확인 : ${ quotationItem} --%>
							<!-- 등록된 견적서 O -->
							<c:if test="${!empty cvo.qvoList}">
								<div class="alert alert-light">
									<div class="form-group row" style="margin-bottom: 10px">
										<label class="col-sm-2">아이디</label>
										<div class="col-sm-3">${cvo.mid}</div>
									</div>
									<div class="form-group row" style="margin-bottom: 10px">
										<label class="col-sm-2">시공 주소</label>
										<div class="col-sm-6">
											<span>(</span>${cvo.postcode}<span>)&nbsp;</span>${cvo.address}<span>&nbsp;</span>${cvo.detailAddress}
										</div>
									</div>
									<div class="form-group row" style="margin-bottom: 10px">
										<label class="col-sm-2">건물 유형</label>
										<div class="col-sm-5">${cvo.buildingType}</div>
									</div>
									<div class="form-group row" style="margin-bottom: 10px">
										<label class="col-sm-2">평수</label>
										<div class="col-sm-5">${cvo.pyeongsu}평</div>
									</div>
									<hr>

									<c:forEach items="${cvo.qvoList}" var="qvo" varStatus="status">
										<c:if test="${status.index == 0}">
											<div class="form-group row" style="margin-bottom: 10px">
												<label class="col-sm-2">견적서 번호</label>
												<div class="col-sm-5">${qvo.quoNo}</div>
												<div id="quoNo" style="display: none;">${qvo.quoNo}</div>
											</div>
											<div class="form-group row" style="margin-bottom: 10px">
												<label class="col-sm-2">견적서 등록일</label>
												<div class="col-sm-5">
													<fmt:formatDate value="${qvo.quoDate}" pattern="yyyy-MM-dd" />
												</div>
											</div>
											<div class="form-group row" style="margin-bottom: 10px">
												<label class="col-sm-2">시공일정</label>
												<div class="col-sm-5">${qvo.constScheduleStart} ~
													${qvo.constScheduleEnd}</div>
											</div>
											<hr>
											<!-- 구분 -->
											<div class="form-group row" style="margin-bottom: 10px">
												<label class="col-sm-2">시공항목</label>
												<div class="col-sm-5">
													<!-- item이 0이 아니면 표시하고 쉼표 `,`로 구분 -->
													<c:if test="${quotationItem.tiling != 0}">도배/벽</c:if>
													<c:if test="${quotationItem.flooring != 0}">
													    <c:if test="${quotationItem.tiling != 0}">, </c:if>바닥
													</c:if>
													
													<c:if test="${quotationItem.kitchen != 0}">
													    <c:if test="${quotationItem.tiling != 0 or quotationItem.flooring != 0}">, </c:if>주방
													</c:if>
													
													<c:if test="${quotationItem.bathroom != 0}">
													    <c:if test="${quotationItem.tiling != 0 or quotationItem.flooring != 0 or quotationItem.kitchen != 0}">, </c:if>욕실
													</c:if>
													
													<c:if test="${quotationItem.entrance != 0}">
													    <c:if test="${quotationItem.tiling != 0 or quotationItem.flooring != 0 or quotationItem.kitchen != 0 or quotationItem.bathroom != 0}">, </c:if>현관
													</c:if>
													
													<c:if test="${quotationItem.balcony != 0}">
													    <c:if test="${quotationItem.tiling != 0 or quotationItem.flooring != 0 or quotationItem.kitchen != 0 or quotationItem.bathroom != 0 or quotationItem.entrance != 0}">, </c:if>발코니
													</c:if>
													
													<c:if test="${quotationItem.lighting != 0}">
													    <c:if test="${quotationItem.tiling != 0 or quotationItem.flooring != 0 or quotationItem.kitchen != 0 or quotationItem.bathroom != 0 or quotationItem.entrance != 0 or quotationItem.balcony != 0}">, </c:if>조명
													</c:if>
													
													<c:if test="${quotationItem.door != 0}">
													    <c:if test="${quotationItem.tiling != 0 or quotationItem.flooring != 0 or quotationItem.kitchen != 0 or quotationItem.bathroom != 0 or quotationItem.entrance != 0 or quotationItem.balcony != 0 or quotationItem.lighting != 0}">, </c:if>문
													</c:if>
													
													<c:if test="${quotationItem.etc != 0}">
													    <c:if test="${quotationItem.tiling != 0 or quotationItem.flooring != 0 or quotationItem.kitchen != 0 or quotationItem.bathroom != 0 or quotationItem.entrance != 0 or quotationItem.balcony != 0 or quotationItem.lighting != 0 or quotationItem.door != 0}">, </c:if>그 외
													</c:if>
													
												</div>
											</div>
											<div class="form-group row" style="margin-bottom: 10px">
												<label class="col-sm-2">철거항목</label>
												<div class="col-sm-5">
												   <c:if test="${quotationItem.tilingD != 0}">도배/벽</c:if>
													<c:if test="${quotationItem.flooringD != 0}">
													    <c:if test="${quotationItem.tilingD != 0}">, </c:if>바닥
													</c:if>
													
													<c:if test="${quotationItem.kitchenD != 0}">
													    <c:if test="${quotationItem.tilingD != 0 or quotationItem.flooringD != 0}">, </c:if>주방
													</c:if>
													
													<c:if test="${quotationItem.bathroomD != 0}">
													    <c:if test="${quotationItem.tilingD != 0 or quotationItem.flooringD != 0 or quotationItem.kitchenD != 0}">, </c:if>욕실
													</c:if>
													
													<c:if test="${quotationItem.entranceD != 0}">
													    <c:if test="${quotationItem.tilingD != 0 or quotationItem.flooringD != 0 or quotationItem.kitchenD != 0 or quotationItem.bathroomD != 0}">, </c:if>현관
													</c:if>
													
													<c:if test="${quotationItem.balconyD != 0}">
													    <c:if test="${quotationItem.tilingD != 0 or quotationItem.flooringD != 0 or quotationItem.kitchenD != 0 or quotationItem.bathroomD != 0 or quotationItem.entranceD != 0}">, </c:if>발코니
													</c:if>
													
													<c:if test="${quotationItem.lightingD != 0}">
													    <c:if test="${quotationItem.tilingD != 0 or quotationItem.flooringD != 0 or quotationItem.kitchenD != 0 or quotationItem.bathroomD != 0 or quotationItem.entranceD != 0 or quotationItem.balconyD != 0}">, </c:if>조명
													</c:if>
													
													<c:if test="${quotationItem.doorD != 0}">
													    <c:if test="${quotationItem.tilingD != 0 or quotationItem.flooringD != 0 or quotationItem.kitchenD != 0 or quotationItem.bathroomD != 0 or quotationItem.entranceD != 0 or quotationItem.balconyD != 0 or quotationItem.lightingD != 0}">, </c:if>문
													</c:if>
													
													<c:if test="${quotationItem.etcD != 0}">
													    <c:if test="${quotationItem.tilingD != 0 or quotationItem.flooringD != 0 or quotationItem.kitchenD != 0 or quotationItem.bathroomD != 0 or quotationItem.entranceD != 0 or quotationItem.balconyD != 0 or quotationItem.lightingD != 0 or quotationItem.doorD != 0}">, </c:if>그 외
													</c:if>
												   
												</div>
											</div>
											<div class="form-group row" style="margin-bottom: 10px">
												<label class="col-sm-2">시공 비용</label>
												<div class="col-sm-5">
													<fmt:formatNumber value="${qvo.constTotal}" pattern="#,###" />
													원
												</div>
											</div>
											<div class="form-group row" style="margin-bottom: 10px">
												<label class="col-sm-2">철거 비용</label>
												<div class="col-sm-5">
													<fmt:formatNumber value="${qvo.demolTotal}" pattern="#,###" />
													원
												</div>
											</div>
											<hr>
											<!-- 구분 -->
											<div class="form-group row" style="margin-bottom: 10px">
												<label class="col-sm-2">총 견적 금액</label>
												<div class="col-sm-5">
													<fmt:formatNumber value="${qvo.total}" pattern="#,###" />
													원
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</c:if>
							<!-- END 등록된 견적서 O -->

							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<!-- 관리자만 등록 및 수정 가능 -->
								<c:if test="${empty cvo.qvoList}">
									<!-- 등록된 견적서가 없는 경우에만 등록 버튼-->
									<button id="newBtn" class="btn btn-primary"
										style="margin-top: 5px">견적서 등록</button>
								</c:if>
								<c:if test="${!empty cvo.qvoList}">
									<!-- 등록된 견적서가 있는 경우에만 수정 버튼 -->
									<c:forEach items="${cvo.qvoList}" var="qvo" varStatus="status">
										<button type="submit" class="btn btn-success" id="modifyQuo"
											style="margin-top: 5px">견적서 수정</button>
										<a href="/sirequest/sireqRegister?quoNo=${qvo.quoNo }" class="btn btn-danger"
											style="margin-top: 5px">시공의뢰 등록</a>
									</c:forEach>
								</c:if>
							</sec:authorize>

						</article>
						<!-- END 견적서 표시 -->

						<!-- 견적상담 관리 버튼들 모음 -->
						<div class="findConsultButton" style="margin-top: 20px;">
							<button type="button" class="btn btn-light"
								onclick="history.back()">이전으로</button>
							<!-- 견적상담 삭제 -->
							<form action="/consult/remove" method="post" id="deleteForm">
								<input type="hidden" name="consultNo" value="${cvo.consultNo}" />
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }"> <input type="hidden"
									name="pageNum" value="${cri.pageNum}"> <input
									type="hidden" name="amount" value="${cri.amount}"> <input
									type="hidden" name="type" value="${cri.type}"> <input
									type="hidden" name="keyword" value="${cri.keyword}">
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<!-- 관리자만 삭제 가능 -->
									<button type="submit" class="btn btn-danger" id="deleteButton"
										style="margin-top: 5px">견적상담 삭제</button>
								</sec:authorize>
							</form>
							<!-- END 견적상담 삭제 -->
						</div>
						<a href="#visit" class="btn btn-primary float-end"
							style="margin-top: 5px">방문 실측 스케줄 보기</a>
						<!-- END 견적상담 관리 버튼들 모음-->

					</div>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<!-- 관리자로 접속시 -->
						<%@ include file="../includes/sideMenuAdm.jsp"%>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_MEMBER')">
						<!-- 회원으로 접속시 -->
						<%@ include file="../includes/sideMenuMem.jsp"%>
					</sec:authorize>
				</div>
				<!-- row g-5 -->
			</div>
		</section>
		<!-- End Blog Details Section -->

	</main>
	<!-- End #main -->


	<!-- Modal창 --------------------------->
	<div class="modal fade" id="quotationModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">견적서 📝</h4>
				</div>

				<!-- 견적서 관련 내용 시작 -->
				<div class="modal-body">
					<div class="form-group">
						<label>견적 상담 번호</label>
						<!-- readonly -->
						<input type="text" name="consultNo" id="consultNo"
							class="form-control" readonly>
					</div>
					<div class="form-group">
						<label>시공일정</label>
						<input type="date" name="constScheduleStart" id="constScheduleStart" class="form-control-sm" oninput="validateDate(this)"> 
						~ <input type="date" name="constScheduleEnd" id="constScheduleEnd" class="form-control-sm" oninput="validateDate(this)">
					</div>
					<hr>
					<div class="form-group">
						<label>선택했던 시공 항목 : </label>
						<!-- 견적상담에서 선택했던 시공 항목 표시 -->
						<div style="color: gray">
						    <c:if test="${cvo.item.tiling != 0}">도배/벽 : <c:out value="${cvo.item.tiling}"></c:out><br></c:if>
						    <c:if test="${cvo.item.flooring != 0}">바닥 : <c:out value="${cvo.item.flooring}"></c:out><br></c:if>
						    <c:if test="${cvo.item.kitchen != 0}">주방 : <c:out value="${cvo.item.kitchen}"></c:out><br></c:if>
						    <c:if test="${cvo.item.bathroom != 0}">욕실 : <c:out value="${cvo.item.bathroom}"></c:out><br></c:if>
						    <c:if test="${cvo.item.entrance != 0}">현관 : <c:out value="${cvo.item.entrance}"></c:out><br></c:if>
						    <c:if test="${cvo.item.balcony != 0}">발코니 : <c:out value="${cvo.item.balcony}"></c:out><br></c:if>
						    <c:if test="${cvo.item.lighting != 0}">조명 : <c:out value="${cvo.item.lighting}"></c:out><br></c:if>
						    <c:if test="${cvo.item.door != 0}">문 : <c:out value="${cvo.item.door}"></c:out><br></c:if>
						    <c:if test="${cvo.item.etc != 0}">그 외 : <c:out value="${cvo.item.etc}"></c:out><br></c:if>
						</div>
						<!-- END 견적상담에서 선택했던 시공 항목 표시 -->
					</div>
					<!-- 시공 항목 -->
					<div class="form-group">
						<div class="input-group">
							<label>시공 항목 &nbsp; </label> <select name="item" id="item">
								<option value="tiling">도배/벽</option>
								<option value="flooring">바닥</option>
								<option value="kitchen">주방</option>
								<option value="bathroom">욕실</option>
								<option value="entrance">현관</option>
								<option value="balcony">발코니</option>
								<option value="lighting">조명</option>
								<option value="door">문</option>
								<option value="etc">그 외</option>
							</select>
							<!-- <button id="plusBtn"> + </button> -->
							<i id="plusBtn" class="far fa-plus-square"></i>
						</div>
						<div id="plusItembox">
							<!-- 추가된 시공 항목이 여기에 표시 -->
						</div>
						
					<!-- 철거 항목 -->
					<hr>
						<div class="form-group">
						    <label>선택했던 철거 항목 : </label>
						    <!-- 견적서에서 선택했던 철거 항목 표시 -->
						    <div style="color: gray">
						        <c:if test="${cvo.item.tilingD != 0}">도배/벽 : <c:out value="${cvo.item.tilingD}"></c:out><br></c:if>
						        <c:if test="${cvo.item.flooringD != 0}">바닥 : <c:out value="${cvo.item.flooringD}"></c:out><br></c:if>
						        <c:if test="${cvo.item.kitchenD != 0}">주방 : <c:out value="${cvo.item.kitchenD}"></c:out><br></c:if>
						        <c:if test="${cvo.item.bathroomD != 0}">욕실 : <c:out value="${cvo.item.bathroomD}"></c:out><br></c:if>
						        <c:if test="${cvo.item.entranceD != 0}">현관 : <c:out value="${cvo.item.entranceD}"></c:out><br></c:if>
						        <c:if test="${cvo.item.balconyD != 0}">발코니 : <c:out value="${cvo.item.balconyD}"></c:out><br></c:if>
						        <c:if test="${cvo.item.lightingD != 0}">조명 : <c:out value="${cvo.item.lightingD}"></c:out><br></c:if>
						        <c:if test="${cvo.item.doorD != 0}">문 : <c:out value="${cvo.item.doorD}"></c:out><br></c:if>
						        <c:if test="${cvo.item.etcD != 0}">그 외 : <c:out value="${cvo.item.etcD}"></c:out><br></c:if>
						    </div>
						    <!-- END 견적상담에서 선택했던 철거 항목 표시 -->
						</div>
					
					<div class="form-group">
						<div class="input-group">
							<label>철거 항목 &nbsp; </label> <select name="itemD" id="itemD">
								<option value="tilingD">도배/벽</option>
								<option value="flooringD">바닥</option>
								<option value="kitchenD">주방</option>
								<option value="bathroomD">욕실</option>
								<option value="entranceD">현관</option>
								<option value="balconyD">발코니</option>
								<option value="lightingD">조명</option>
								<option value="doorD">문</option>
								<option value="etcD">그 외</option>
							</select> <i id="demoPlusBtn" class="far fa-plus-square"></i>
						</div>
						<div id="demoItembox">
							<!-- 추가된 철거 항목이 여기에 표시 -->
						</div>
					</div>
					<hr>
					<div class="form-group">
						<label>시공 비용</label> <input type="text" name="constTotal"
							id="constTotal" class="form-control" readonly>
					</div>
					<div class="form-group">
						<label>철거 비용</label> <input type="text" name="demolTotal"
							id="demolTotal" class="form-control" readonly>
					</div>
					<hr>
					<div class="form-group">
						<label>총 견적 금액</label> <input type="text" name="total" id="total"
							class="form-control" readonly>
					</div>
				</div>
				<!-- END 견적서 관련 내용 -->

				<div class="modal-footer">
					<!-- 모달 아래 버튼 -->
					<button id="remBtn" type="button" class="btn btn-danger">Remove</button>
					<button id="modBtn" type="button" class="btn btn-warning">Modify</button>
					<button id="addBtn" type="button" class="btn btn-primary">Add</button>
					<button id="closeBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
</div>	
	<!-- /.modal -->
	<!-- END Modal창 END--------------------------->


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

	<!-- ======= script ======= -->
<script>
var consultNo = "${param.consultNo}";
var visitNoElement = document.getElementById("visitNo");
var visitNo = visitNoElement ? visitNoElement.textContent : null;
document.addEventListener('DOMContentLoaded', function() {
    $(function () {
        var request = $.ajax({
            url: "/visit/", // 변경하기
            method: "GET",
            dataType: "json"
        });
        request.done(function (data) {
        console.log(data); // log 로 데이터 찍어주기
            
	           var calendarEl = document.getElementById('calendar');
	           var calendar = new FullCalendar.Calendar(calendarEl, {
	               headerToolbar: {
	                   left: 'prev,next today',
	                   center: "title",
	                   right: 'dayGridMonth,dayGridWeek'
	               },
                
                initialView: 'dayGridMonth',
                locale : 'ko',
                firstDay : 1,
                weekends : false,
                selectable:true,
                selectMirror:true,

                select:function(arg){	//날짜가 선택됐을 때
                     var title = prompt('일정을 입력해주세요.');
                     
                if(title){
                    calendar.addEvent({
                        title:title,
                        start:arg.start,
                        end:arg.end,
                        //allDay : arg.allDay
                    })
                }
                
               var allEvent = calendar.getEvents();
               
               var events = new Array(); // Json 데이터를 받기 위한 배열 선언
               for (var i = 0; i < allEvent.length; i++) {
                   var obj = new Object();     // Json 을 담기 위해 Object 선언
                   // alert(allEvent[i]._def.title); // 이벤트 명칭 알람
                   obj.title = allEvent[i]._def.title; // 이벤트 명칭  ConsoleLog 로 확인 가능.
                   obj.consultNo = consultNo;
                   obj.start = allEvent[i]._instance.range.start; // 시작
                   obj.end = allEvent[i]._instance.range.end; // 끝

                   events.push(obj);
               }
               var jsondata = JSON.stringify(events);
               console.log(jsondata);
               
               $(function saveData(jsondata) {
               $.ajax({
                   url: "/visit/add", // 변경하기
                   method: "POST",
                   dataType: "json",
                   data: JSON.stringify(events),
                   contentType: 'application/json',
               })
                   .done(function (result) {
                       // alert(result);
                   })
                   .fail(function (request, status, error) {
                        alert("에러 발생" + error);
                   });
               calendar.unselect()
               });
                 }, // END select 
                 
                 
                 //일정 삭제하기
                 eventClick: function (info){
                	    if(confirm("'"+ info.event.title +"' 번의 일정을 삭제하시겠습니까 ?")){
                	        // 확인 클릭 시
                	        info.event.remove();
                	    }
                	    console.log(visitNo);
                	    $(function deleteData(){
                	        $.ajax({
                	            url: "/visit/" + visitNo,
                	            method: "DELETE",
                	            contentType: 'application/json',
                	        })
                	    })
                	}, // END  eventClick

                 editable:true,
                 navLinks:true,
                 loading:function(bool){
                     document.getElementById('loading').style.display =
                       bool ? 'block' : 'none';
                  },
                  events:data, //일정 전체 조회
                  eventColor: '#378006',
                  displayEventTime : false,
                  
                  //수정하기
                  droppable: true, 
                  eventDrop: function (info){
                      console.log(info);
                      if(confirm("'"+ info.event.title +"' 번의 일정을 수정하시겠습니까 ?")){
                      }
                      var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                      var obj = new Object();

                      obj.title = info.event._def.title;
                      obj.consultNo = consultNo;
                      obj.visitNo = visitNo;
                      obj.start = info.event._instance.range.start;
                      obj.end = info.event._instance.range.end;
                      events.push(obj);

                      console.log(events);
                      $(function deleteData() {
                          $.ajax({
                              url: "/visit/" + visitNo,
                              method: "PATCH",
                              dataType: "json",
                              data: JSON.stringify(events),
                              contentType: 'application/json',
                          })
                      })
                  },// END eventDrop
                  
             }); // END Calendar
             calendar.render();
         }); // END Request Done 
     }); // END jQuery Function 
});
</script>
	<!-- END fullCalendar -->	
	
	
<script src="/resources/js/quotation.js"></script>
<script>
	// -------------------------------- 견적상담 관련 --------------------------------
	// 페이지 로드 시 처리현황에 따라 상담 취소 버튼 숨김 처리
	var statusVal = '${cvo.status}'
	document.addEventListener("DOMContentLoaded", function() {
		if (statusVal === "상담 취소") {
			document.getElementById("CancleButton").style.display = "none";
		}
	});
	// END 페이지 로드 시 처리현황에 따라 상담 취소 버튼 숨김 처리
	// 견적상담 취소 버튼 클릭 시 status에 상담 취소 값 전달 --------------
	function cancelConsult() {
		// status 필드 값을 "상담 취소"로 설정
		var statusField = document.querySelector('input[name="status"]');
		statusField.value = "상담 취소";

		// 폼 제출
		document.getElementById("CancleForm").submit();
	}
	// END 견적상담 취소 버튼 클릭 시 status에 상담 취소 값 전달 ----------
	//해피콜 입력받을 때 조건 설정 함수 -------------------------
	function validateDateTime(input) {
		// 입력된 날짜와 시간 가져오기
		var selectedDateTime = new Date(input.value);
		// 현재 날짜 가져오기
		var currentDate = new Date();

		// 	<!-- 날짜와 시간에 대한 유효성 검사 -->
		if (isValidWeekday(selectedDateTime)
				&& isValidTime(selectedDateTime)
				&& isValidTimeRange(selectedDateTime)
				&& isFutureDate(selectedDateTime, currentDate)) {
			// 유효한 경우, 아무 작업 없이 통과
		} else {
			// 	<!-- 유효하지 않은 경우, 초기 값을 복구 (이전 유효한 값으로) -->
			input.value = "2023-10-18T12:30";
			alert("평일 9시~17시만 10분단위로 선택 가능하며, 미래 날짜만 선택 가능합니다.");
		}
	}

	function isValidWeekday(dateTime) {
		// 주말 (토요일: 6, 일요일: 0)이 아니라면 유효
		var day = dateTime.getDay();
		return day !== 0 && day !== 6;
	}
	function isValidTime(dateTime) {
		// 	분 단위가 10의 배수인 경우 유효
		var minutes = dateTime.getMinutes();
		return minutes % 10 === 0;
	}
	function isValidTimeRange(dateTime) {
		// 시간 범위가 9:00 AM부터 5:00 PM까지인 경우 유효
		var hours = dateTime.getHours();
		return hours >= 9 && hours <= 17;
	}
	function isFutureDate(selectedDateTime, currentDate) {
		// 선택한 날짜가 현재 날짜보다 미래인 경우 유효
		return selectedDateTime > currentDate;
	}
	// 해피콜 입력받을 때 조건 설정 함수 -------------------------
	// 견적상담 삭제 버튼 클릭 시 의사 재확인
	// Confirm 대화상자를 띄우고 사용자의 의사를 물어봅니다.
	function deleteConsult() {
		if (confirm("정말 견적상담을 삭제하시겠습니까?")) {
			document.getElementById("deleteForm").submit();
		}
	}
	// END 견적상담 삭제 버튼 클릭 시 의사 재확인
	// -------------------------------- END 견적상담 관련--------------------------------

	// -------------------------------- 방문스케줄 관련 --------------------------------
	// -------------------------------- END 방문스케줄 관련 --------------------------------

	// -------------------------------- 견적서 --------------------------------
	var consultNoVal = '${cvo.consultNo}'; //견적 상담 번호 값
	var itemNoVal = '${cvo.item.itemNo}'; //견적 상담 번호 값
	//견적서 등록 및 수정 모달창 ---------------------------
	var modal = $('#quotationModal');
	var consultNoTxt = $('#consultNo');
	var constScheduleStartTxt = $('#constScheduleStart');
	var constScheduleEndTxt = $('#constScheduleEnd');
	var constTotalTxt = $('#constTotal'); //시공 비용
	var demolTotalTxt = $('#demolTotal'); // 철거 비용
	var totalTxt = $('#total'); //총 견적 금액
	//var constScheduleEndTxt    = $('#constScheduleEnd'); //아이템
	var addBtn = $('#addBtn');
	var modBtn = $('#modBtn');
	var remBtn = $('#remBtn');
	var plusBtn = document.getElementById("plusBtn"); // plusBtn을 정확한 HTML 요소로 선택
	var demoPlusBtn = document.getElementById("demoPlusBtn");

	// 모달 창 닫기
	$('#closeBtn').on('click', function() {
		modal.modal('hide');
	});

	//견적서 등록 버튼 누르면 모달 창 표시
	$('#newBtn').on('click', function() {
		modal.find('input').val(''); // input에 입력되어있는 값들을 모두 지우기! 안 그러면 전에 작성한 값들이 남음
		//totalTxt.closest('div').hide();            // totalTxt 근처에 있는 div를 숨김
		modal.find("button[id != 'closeBtn']").hide(); // close 버튼 빼고 다 숨김
		addBtn.show(); // 등록 버튼을 눌렀으니 add만 보이게 함
		//plusBtn.show();                        // #으로 가져올 때 등록 버튼을 눌렀으니 add만 보이게 함
		plusBtn.style.display = 'block'; // 등록 버튼을 눌렀으니 +만 보이게 함
		demoPlusBtn.style.display = 'block'; // 등록 버튼을 눌렀으니 +만 보이게 함
		modal.modal('show');
		modal.find('#consultNo').val(consultNoVal); //견적상담 번호를 자동으로 표시
	});
	// END 견적서 등록 버튼 누르면 모달 창 표시

	//beforeSend 대신 CSRF토큰 헤더 추가
	var csrfHeaderName = '${_csrf.headerName}'; //CSRF 토큰 관련 변수, 다른거 보낼수도 !
	var csrfTokenValue = '${_csrf.token}'; //
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	// END beforeSend 대신 CSRF토큰 헤더 추가

	//END 견적서 등록 및 수정 모달창 ---------------------------

	// Add 버튼 클릭 이벤트 처리  ----------------------
	// add 버튼 누르면 견적서 등록
 $('#addBtn').on('click', function() {
	 var quotation = {
			item : {
						itemNo: itemNoVal,
				        tiling: constItemPrices['tiling'] || 0, // 값이 없을 경우 0으로 설정
				        tilingD: demoItemPrices['tilingD'] || 0,
				        flooring: constItemPrices['flooring'] || 0,
				        flooringD: demoItemPrices['flooringD'] || 0,
				        kitchen: constItemPrices['kitchen'] || 0,
				        kitchenD: demoItemPrices['kitchenD'] || 0,
				        bathroom: constItemPrices['bathroom'] || 0,
				        bathroomD: demoItemPrices['bathroomD'] || 0,
				        entrance: constItemPrices['entrance'] || 0,
				        entranceD: demoItemPrices['entranceD'] || 0,
				        balcony: constItemPrices['balcony'] || 0,
				        balconyD: demoItemPrices['balconyD'] || 0,
				        lighting: constItemPrices['lighting'] || 0,
				        lightingD: demoItemPrices['lightingD'] || 0,
				        door: constItemPrices['door'] || 0,
				        doorD: demoItemPrices['doorD'] || 0,
				        etc: constItemPrices['etc'] || 0,
				        etcD: demoItemPrices['etcD'] || 0
		  },
			    consultNo: consultNoVal,
			    itemNo: itemNoVal,
			    constScheduleStart: constScheduleStartTxt.val(),
			    constScheduleEnd: constScheduleEndTxt.val(),
			    constTotal: constTotalTxt.val(),
			    demolTotal: demolTotalTxt.val(),
			    total: totalTxt.val()
			  };
	quotationService.register(quotation, function(result) {
		 // 여기에서 ItemVO 객체의 상태 확인
        console.log(quotation.item);
    alert('견적 상담 ' + consultNoVal + '번의 견적서가 등록되었습니다.');
    modal.find('input').val(''); //등록 후엔 모달창 값 지우기
    modal.modal('hide');
    // 새로고침
    location.reload();
  });
});
	//END Add 버튼 클릭 이벤트 처리 -------------------

	//Remove 버튼 클릭 이벤트 처리 --------------------------
	// Remove 버튼 누르면 견적서 삭제
	remBtn.on('click', function() {
		quotationService.remove(modal.data('quoNo'), function(result) {
			alert('견적서가 삭제되었습니다.');
			modal.modal('hide');
			// 새로고침
			location.reload();
		});
	});

	//END Remove 버튼 클릭 이벤트 처리 ------------------------

	//견적서 수정 버튼 클릭 이벤트 처리
	//견적서 수정 버튼 클릭 시 클릭한 하나의 견적서 상세 조회(수정, 삭제) 모달창이 뜸
	var quoNoElement = document.getElementById("quoNo");
	var quoNo = quoNoElement ? quoNoElement.textContent : null;
	// quoNo 변수가 null인지 확인한 후에 사용
	
	$('#modifyQuo').on('click', function() {
		quotationService.view(quoNo, function(result) {
			//견적상담번호
			consultNoTxt.val(result.consultNo)
			//시공일정 시작
			constScheduleStartTxt.val(result.constScheduleStart)
			//시공일정 끝
			constScheduleEndTxt.val(result.constScheduleEnd)
			//시공비용
			constTotalTxt.val(result.constTotal)
			//철거비용
			demolTotalTxt.val(result.demolTotal)
			//총견적금액
			totalTxt.val(result.total)

			//regDateTxt.closest('div').show();
			modal.find("button[id != 'closeBtn']").hide(); // close 버튼 빼고 다 숨김
			modBtn.show();
			remBtn.show();

			modal.modal('show');
			modal.data('quoNo', quoNo); //modal 데이터 보내기
		});
	});
	//END 견적서 수정 버튼 클릭 시

	//Modify 버튼 클릭 이벤트 처리 --------------------------
	// Modify 버튼 누르면 댓글 수정
	modBtn.on('click', function() {
		 var quotation = {
				 item : {
						itemNo: itemNoVal,
				        tiling: constItemPrices['tiling'] || 0, // 값이 없을 경우 0으로 설정
				        tilingD: demoItemPrices['tilingD'] || 0,
				        flooring: constItemPrices['flooring'] || 0,
				        flooringD: demoItemPrices['flooringD'] || 0,
				        kitchen: constItemPrices['kitchen'] || 0,
				        kitchenD: demoItemPrices['kitchenD'] || 0,
				        bathroom: constItemPrices['bathroom'] || 0,
				        bathroomD: demoItemPrices['bathroomD'] || 0,
				        entrance: constItemPrices['entrance'] || 0,
				        entranceD: demoItemPrices['entranceD'] || 0,
				        balcony: constItemPrices['balcony'] || 0,
				        balconyD: demoItemPrices['balconyD'] || 0,
				        lighting: constItemPrices['lighting'] || 0,
				        lightingD: demoItemPrices['lightingD'] || 0,
				        door: constItemPrices['door'] || 0,
				        doorD: demoItemPrices['doorD'] || 0,
				        etc: constItemPrices['etc'] || 0,
				        etcD: demoItemPrices['etcD'] || 0
					},
					quoNo : modal.data('quoNo'),
					consultNo : consultNoVal,
					itemNo : itemNoVal,
					constScheduleStart : constScheduleStartTxt.val(),
					constScheduleEnd : constScheduleEndTxt.val(),
					constTotal : constTotalTxt.val(),
					demolTotal : demolTotalTxt.val(),
					total : totalTxt.val()
		};
		 quotationService.modify(quotation, function(result) {
			alert('견적서가 수정되었습니다.');
			modal.modal('hide');
			location.reload();
		});
	});
	//END Modify 버튼 클릭 이벤트 처리 ------------------------

	//모달창 시공일정 조건 설정 함수 -------------------------
	function validateDate(input) {
		// 입력된 날짜와 시간 가져오기
		var selectedDate = new Date(input.value);
		// 현재 날짜 가져오기
		var currentDate = new Date();

		// 	<!-- 날짜와 시간에 대한 유효성 검사 -->
		if (isValidWeekday(selectedDate)
				&& isFutureDate(selectedDate, currentDate)) {
			// 유효한 경우, 아무 작업 없이 통과
		} else {
			// 	<!-- 유효하지 않은 경우, 초기 값을 복구 (이전 유효한 값으로) -->
			alert("평일만 선택 가능하며, 미래 날짜만 선택 가능합니다.");
		}
	}
	//END 모달창 시공일정 조건 설정 함수 -------------------------

	// 견적서 시공 및 철거항목 버튼 추가 및 계산------------------------------
	var plusItembox = document.getElementById("plusItembox");
	var demoItembox = document.getElementById("demoItembox");
	// 시공 항목의 가격 정보를 저장하는 객체를 생성
	var constItemPrices = {};
	// 철거 항목의 가격 정보를 저장하는 객체를 생성
	var demoItemPrices = {};

	plusBtn.addEventListener('click',function() {
						var selectedItem = document.getElementById("item");
						var selectedValue = selectedItem.value;

						if (selectedValue !== "select") {
							var itemName = selectedItem.options[selectedItem.selectedIndex].text;
							var itemPrice = prompt(itemName + " 가격을 입력하세요:");

							if (itemPrice !== null && itemPrice !== "") {
								var newItem = document.createElement("div");
								newItem.classList.add("item");
								newItem.innerHTML = "<b>" + itemName
										+ ":</b> " + itemPrice;
								plusItembox.appendChild(newItem);

								// 추가된 항목을 삭제할 버튼 추가
								var deleteButton = document
										.createElement("button");
								deleteButton.textContent = "X";
								newItem.appendChild(deleteButton);

								// 삭제 버튼 클릭 이벤트
								deleteButton.addEventListener('click',
										function() {
											plusItembox
													.removeChild(newItem);
											updateTotal();
										});
								// 시공 비용 업데이트
								updateTotal();
								
								// 각 항목의 이름을 그대로 키로 사용하고, 값은 사용자가 입력한 가격으로 설정
								 constItemPrices[selectedValue] = itemPrice;
							}
						}
					});

	demoPlusBtn
			.addEventListener(
					'click',
					function() {
						var selectedItemD = document
								.getElementById("itemD");
						var selectedValueD = selectedItemD.value;

						if (selectedValueD !== "select") {
							var itemNameD = selectedItemD.options[selectedItemD.selectedIndex].text;
							var itemPriceD = prompt(itemNameD
									+ " 가격을 입력하세요:");

							if (itemPriceD !== null && itemPriceD !== "") {
								var newItemD = document
										.createElement("div");
								newItemD.classList.add("itemD"); // 이 부분이 수정되었습니다.
								newItemD.innerHTML = "<b>" + itemNameD
										+ ":</b> " + itemPriceD;
								demoItembox.appendChild(newItemD);

								// 추가된 항목을 삭제할 버튼 추가
								var deleteButtonD = document
										.createElement("button");
								deleteButtonD.textContent = "X";
								newItemD.appendChild(deleteButtonD);

								// 삭제 버튼 클릭 이벤트
								deleteButtonD.addEventListener('click',
										function() {
											demoItembox
													.removeChild(newItemD);
											updateTotal();
										});
								updateTotal();
							}
						}
						// 시공 비용 업데이트
						updateTotal();
			            // 각 항목의 이름을 그대로 키로 사용하고, 값은 사용자가 입력한 가격으로 설정
						 demoItemPrices[selectedValueD] = itemPriceD;
					});

	// 시공 및 철거 비용 총합을 계산하고 표시하는 함수
	function updateTotal() {
		var itemElements = plusItembox.getElementsByClassName("item");
		var itemDElements = demoItembox.getElementsByClassName("itemD");

		var total = 0;
		var totalD = 0;

		for (var i = 0; i < itemElements.length; i++) {
			var itemText = itemElements[i].textContent;
			var itemPrice = parseFloat(itemText.match(/(\d+)/)[0]);
			total += itemPrice;
		}
		for (var i = 0; i < itemDElements.length; i++) {
			var itemText = itemDElements[i].textContent;
			var itemPrice = parseFloat(itemText.match(/(\d+)/)[0]);
			totalD += itemPrice;
		}

		// 시공 비용 입력란 업데이트
		var constTotal = document.getElementById('constTotal');
		constTotal.value = total;
		// 철거 비용 입력란 업데이트
		var demolTotal = document.getElementById('demolTotal');
		demolTotal.value = totalD;
		// 총 견적금액
		var totalInput = document.getElementById('total');
		var total = total + totalD;
		// 총 견적금액 입력란 업데이트	
		totalInput.value = total;
		//totalInput.value = total.toLocaleString() + ' 원'; , 로 보임
	}
	// END 시공 및 철거 비용 총합을 계산하고 표시하는 함수
	// -------------------------------- END 견적서 --------------------------------

	/*
	 quotationService.view(
	 38,
	 function(result){	
	 console.log(result);	
	 }
	 );
	 */
</script>
	<!-- ======= END script ======= -->

</body>
</html>
