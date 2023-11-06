<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %>	


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AS 목록</title>

<!-- 스타일 시트 링크, 스크립트 등의 추가 작업이 필요할 수 있습니다. -->

</head>
<body>


<main id="main">
    <!-- Breadcrumbs -->
    <div class="breadcrumbs d-flex align-items-center"
         style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
        <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
            <h2>AS 목록</h2>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <!-- AS 목록 표시 구간 -->
    <section id="asboard-list" class="services section-bg">
        <div class="container" data-aos="fade-up">
            <div class="row gy-4">
                <!-- AS 목록 개수 표시 구간 -->
                <h3>AS 문의목록 ${totalCount}</h3>
                <hr>
                <!-- END AS 목록 개수 표시 구간 -->
                
 <!-- AS 목록 표시 구간 -->
<section id="asboard-list" class="services section-bg">
    <div class="container" data-aos="fade-up">
        <table class="table table-bordered">
            <thead>
                <tr>
                <th>AS 번호</th>
                    <th>제목</th>
                    <th>AS 작성자</th>
                    
                    <th>AS 날짜</th>
                    <th>처리 상황</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="bvo">
                    <tr>
                     <td>${bvo.bno}</td>
                        <td><a href="/asboard/asview?bno=${bvo.bno}">${bvo.title}</a></td>
                        <td>${bvo.mid}</td>
                       
                        <td><fmt:formatDate value="${bvo.regDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${bvo.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>
<!-- End AS 목록 표시 구간 -->
<div class="d-flex justify-content-center">
	    <form action="/asboard/aslist" id="searchFrm" class="d-inline">
    <select id="searchType" name="type">
        <option value="mid" <c:if test="${pageDTO.cri.type == 'mid'}">selected</c:if>>작성자</option>
        <option value="status" <c:if test="${pageDTO.cri.type == 'status'}">selected</c:if>>처리 상황</option>
        <option value="title" <c:if test="${pageDTO.cri.type == 'title'}">selected</c:if>>제목</option>
        <option value="regdate" <c:if test="${pageDTO.cri.type == 'regdate'}">selected</c:if>>등록일</option>
    </select>
    <input id="searchKeyword" type="text" name="keyword" value="${pageDTO.cri.keyword}" placeholder="검색어를 입력하세요">
    <button class="btn btn-default btn-sm searchBtn" type="submit" onclick="return validateSearch();"><i class="bi bi-search"></i></button>
    <input type="hidden" id="pageNum" name="pageNum" value="${pageDTO.cri.pageNum}">
    <input type="hidden" id="actionFrmPageNum" name="pageNum" form="actionFrm" value="${pageDTO.cri.pageNum}">
</form>

</div>

<div class = "d-flex justify-content-end mt-3">
    <!-- AS 문의하기 버튼 -->
<sec:authorize access="!hasRole('ROLE_ADMIN')">
    <a href="/asboard/asregister"class = "btn btn-primary">AS 문의하기</a>
</sec:authorize>ㄴ
    <!-- END AS 문의하기 버튼 -->
</div> 
<!-- END 검색 :: AS 번호 -->

                <!-- 페이징 -->


<div class="text-center">
<ul class="pagination justify-content-center">
<c:if test="${pageDTO.prev}">
<li class="page-item">
<a href="/asboard/aslist?pageNum=${pageDTO.start - 1}" class="page-link">« Previous</a>
</li>
</c:if>
<c:forEach begin="${pageDTO.start}" end="${pageDTO.end}" var="i">
<li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : ''}">
<a href="/asboard/aslist?pageNum=${i}" class="page-link">${i}</a>
</li>
</c:forEach>
<c:if test="${pageDTO.next}">
<li class="page-item">
<a href="/asboard/aslist?pageNum=${pageDTO.end + 1}" class="page-link">Next »</a>
</li>
</c:if>
</ul>
</div>
<!-- 페이징 END -->


                <!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
                <form action="/asboard/aslist" id="actionFrm">
                    <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageDTO.cri.amount}">
                    <input type="hidden" name="type" value="${pageDTO.cri.type}">
                    <input type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
                </form>
            </div>
        </div>
    </section>
    <!-- End AS 목록 표시 구간 -->
    
  
</main>
<script>
function isValidDate(dateString) {
    var regEx = /^\d{4}-\d{2}-\d{2}$/;
    if(!dateString.match(regEx)) return false;  // Invalid format
    var d = new Date(dateString);
    var dNum = d.getTime();
    if(!dNum && dNum !== 0) return false; // NaN value, Invalid date
    return d.toISOString().slice(0,10) === dateString;
}

function validateSearch() {
    var type = document.getElementById('searchType').value;
    var keyword = document.getElementById('searchKeyword').value;
    if (type === 'regdate' && !isValidDate(keyword)) {
        alert('날짜 형식이 올바르지 않습니다. yyyy-mm-dd 형식으로 입력해주세요.');
        return false;
    }
    document.getElementById('pageNum').value = 1;
    document.getElementById('actionFrmPageNum').value = 1;
    return true;
}
</script>
</body>
</html>

<%@ include file="../includes/footer.jsp" %>
