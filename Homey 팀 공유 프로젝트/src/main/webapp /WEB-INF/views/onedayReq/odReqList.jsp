<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원데이클래스 신청자 목록</title>

<style>

/*	게시글 제목(링크) 색상 */
tbody a { color : 	#333333; }

/* 링크(게시글 제목, 신청자ID)에 마우스 올리면 주황색으로 표시 */
tbody a:hover { color : orange; }			


/* 테이블의 텍스트 가운데 정렬, 제목만 왼쪽 정렬 */
table {  text-align: center; }
table td.title {    text-align: left;	}

/* 클래스명 표시할 때 */
.custom-rectangle {
    background-color: #FFFACD; /* 연한 회색 */
    padding: 10px;
 
    border-radius: 5px;

    font-weight: bold;
    color: #333333;
}

.custom-rectangle .class-name {
    margin: 0;
    font-size: 15px;
}


/* 당첨 뱃지 스타일 */
.badge-winning {
    background-color: 	#FF8C00; /* 배경색-빨간색 */
    color: white; /* 글자-흰색 */
    border-radius: 5px;
    padding: 5px 10px;
}

/* 미당첨 뱃지 스타일 */
.badge-notWin {
    background-color: 	#696969	; /* 배경색-진회색 */
    color: white; /* 글자-흰색 */
    border-radius: 5px;
    padding: 5px 10px;
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
    <h2>Oneday Class Request</h2>
  </div>
</div><!-- End Breadcrumbs -->


<!-- ======= 원데이클래스 신청자 목록 ======= -->
 
<section id="project-details" class="project-details">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-desption">
	    	
	    	<hr><br>
	        <h2>👨‍👧‍👧원데이클래스 신청자 목록</h2>
			<br>
			
            <div class="custom-rectangle">
                <p class="class-name">⛳ 클래스명 ::  ${odName}</p>
            </div>
			
			<div class="container">
			<br>
			<!-- 리스트 출력 시작 구간 --------------------------------------->
			<!-- 해당 클래스의 신청자가 없는 경우 -->
			<c:if test="${empty odReqList }">
				<div class="row">
				<div class="col" align="center"> 
					<p class="alert alert-warning p-5">
						신청자가 없습니다.
					</p>
				</div>
				</div>
			</c:if>	
			
			<!-- 해당 클래스의 신청자가 있는 경우 -->
			<c:if test="${!empty odReqList }">
				<table class="table table-hover">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>신청자 ID</th>
                            <th>신청서 제목</th>
                            <th>당첨여부</th>
                            <th>신청일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <!------------- Model 데이터 출력 ---------------> 
                    <c:forEach items="${odReqList }" var="odrvo">
                  		<tr>
                  			<td>${odrvo.odReqRn }</td>
                  			<td><a href="/gen/memberView?mid=${odrvo.mid }">${odrvo.mid }</a></td>
                  			<td class="title"><a href="/odReq/view?odReqNo=${odrvo.odReqNo}&odNo=${odrvo.odNo}&mid=<sec:authentication property="principal.Username"/>">${odrvo.odReqTitle}</a></td>
                  			<!-- href의 나머지 내용은 스크립트에서 처리-->
                  			<td>
                  				<c:choose>
		                            <c:when test="${odrvo.odReqWin == 0}"><span class="badge badge-notWin">미당첨</span></c:when>
		                            <c:when test="${odrvo.odReqWin == 1}"><span class="badge badge-winning">당첨</span></c:when>
		                        </c:choose>
                  			</td>
                  			<td><fmt:formatDate value="${odrvo.odReqDate}" pattern="yyyy-MM-dd"/></td>
                  		</tr>
                    </c:forEach>
                    <!------------- END Model 데이터 출력 ----------->
                    </tbody>
                </table> <!-- /.table-responsive -->
			</c:if>	
			<!-- END 리스트 출력 구간 --------------------------------------->
			
			<br>

			<div class="text-center" id="btn-group">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a href="/oneday/view?odNo=${odNo}&mid=<sec:authentication property="principal.Username"/>" class="btn btn-warning">이전으로</a>
				</sec:authorize>
			</div>
			
			<br>
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

</body>
</html>
