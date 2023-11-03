<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원데이클래스 신청서 조회</title>

<style>

.regiItemNm {	width: 150px;
						font-weight: bold;		}
.regiItem {		width: 200px;	
						border: none;
        				outline: none; /* 포커스 표시 없음 */	}
.odReqTitle{		border: none; 
        				outline: none; /* 포커스 표시 없음 */	}	
#odReqItem {	margin-bottom: 20px; 	}

/* 상단의 [원데이클래스 신청서] 글자 : 초록색*/
.regiText{	color: #008000;		}	

/* 신청서 전반의 배경색 : 노란색 */
.reqForm{		background-color: 	#fbfbde;		}

/* 신청클래스 이름에 마우스 올릴 때 색상 변경 */
.reqForm a:hover { color : gray; }	

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
    <h2>Oneday Class Request</h2>
  </div>
</div><!-- End Breadcrumbs -->


<!-- ======= 원데이클래스 신청서 상세조회 ======= -->
<section id="blog" class="blog">
  <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row g-5">
      <div class="col-lg-8 mx-auto">
        <div class="comments">
          <div class="reply-form reqForm">

            <h4 class="regiText">🔍 원데이클래스 신청서</h4>
            <br>
            
            <div class="form-group" id="odReqItem">
				<label class="regiItemNm">신청일자</label>
				<span class="regiItem" ><fmt:formatDate value="${odrvo.odReqDate}" pattern="yyyy-MM-dd (E)"/></span>
			</div>

			<div class="form-group" id="odReqItem">
				<label class="regiItemNm">신청자 ID</label>
				<span class="regiItem" >${odrvo.mid}</span>
			</div>
			
			<div class="form-group" id="odReqItem">
				<label class="regiItemNm">신청클래스</label>
				<a href="/oneday/view?odNo=${odNo }&mid=<sec:authentication property="principal.Username"/>"><span class="regiItem" >${odName}</span></a>
			</div>
			
			<div class="form-group" id="odReqItem">
			    <label class="regiItemNm">당첨여부</label>
			    <c:choose>
			        <c:when test="${odrvo.odReqWin eq 0}">
			        	<span class="badge rounded-pill bg-dark"  style="font-size: 15px;"> 미당첨 </span>
			        </c:when>
			        <c:when test="${odrvo.odReqWin eq 1}">
			        	<span class="badge rounded-pill bg-danger"  style="font-size: 15px;"> 당첨 </span>
			        </c:when>
			    </c:choose>
			</div>
			
			<div class="form-group" id="odReqItem">
				<label class="regiItemNm">제    목 ::</label><span class="odReqTitle">${odrvo.odReqTitle}</span>
			</div>
			
			<div class="form-group">
				<textarea name="odReqContent" class="form-control regiItem" rows="5" readonly>${odrvo.odReqContent }</textarea>
			</div>
			
			<div class="text-center" id="btn-group">
				
				<!-- 일반회원이 로그인했을 경우 [이전으로], 모집중인 클래스라면 [신청취소] -->
				<sec:authorize access="not hasRole('ROLE_ADMIN')">
					<button type="button" class="btn btn-secondary" onclick="history.back()">이전으로</button>
					<c:choose>
				        <c:when test="${odState eq 0 && odrvo.odReqWin eq 0}">
				            <a href="/odReq/remove?odReqNo=${odrvo.odReqNo}&mid=<sec:authentication property="principal.Username"/>" class="btn btn-danger reqX" onclick="return confirm('신청을 취소하면 되돌릴 수 없습니다. 취소하시겠습니까?')">신청취소</a>
				        </c:when>
				    </c:choose>
				 </sec:authorize>

			       	
				<!-- 관리자가 로그인했을 경우 [이전으로], [당첨자로 선정], [당첨취소] -->
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				    <a href="/odReq/list?odNo=${odrvo.odNo}" class="btn btn-secondary">신청자 목록으로</a>
				    <c:choose>
				        <c:when test="${odState eq 0 && odrvo.odReqWin eq 0}">
				            <a href="/odReq/win?odReqNo=${odrvo.odReqNo}&odNo=${odrvo.odNo}&mid=<sec:authentication property="principal.Username"/>" class="btn btn-success win" onclick="return confirm('당첨자로 선정하시겠습니까?')">당첨자로 선정</a>
				        </c:when>
				        <c:when test="${odState eq 0 && odrvo.odReqWin eq 1}">
				            <a href="/odReq/winX?odReqNo=${odrvo.odReqNo}&odNo=${odrvo.odNo}&mid=<sec:authentication property="principal.Username"/>" class="btn btn-danger winX" onclick="return confirm('당첨을 취소하시겠습니까?')">당첨 취소하기</a>
				        </c:when>
				    </c:choose>
				</sec:authorize>
				
			</div>

          </div>
        </div><!-- End blog comments -->
      </div>
    </div>
  </div>
</section><!-- End Blog Details Section -->

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

</body>
</html>
